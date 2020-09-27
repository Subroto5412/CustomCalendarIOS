//
//  ViewController.swift
//  CustomCalendar
//
//  Created by Subroto Mohonto on 27/9/20.
//  Copyright © 2020 Opu Sumon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var datNameMonthDateLbl: UILabel!
    @IBOutlet weak var monthYearLbl: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var minimumDate: Date?
    let collectionViewInsets = UIEdgeInsets(top:0, left: 10, bottom: 0, right: 10)
    
    public var selectedColor = UIColor(red:250/255, green: 16/255, blue:124/255, alpha:1.0)
    
    var selectDate = Date()
    
    var convertedString = ""
    
    var sectionNum: Int?
    {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CalendarDatePickerCell.self, forCellWithReuseIdentifier: "CalendarDatePickerCell")
        collectionView?.contentInset = collectionViewInsets
        
         sectionNum = 0
        minimumDate = Date()
    }

    @IBAction func BackBtn(_ sender: UIButton) {
        
        sectionNum! -= 1
        monthYearLbl.text = getMonthYear(date: getFirstDateForSection(section: sectionNum!))
    }
    @IBAction func nextBtn(_ sender: UIButton) {
        
        sectionNum! += 1
        monthYearLbl.text = getMonthYear(date: getFirstDateForSection(section: sectionNum!))
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int
     {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let firstDateForSection = getFirstDateForSection(section: sectionNum!)
        let weekDayRowItems = 7
        let blankItems = getWeekDay(date: firstDateForSection)-1
        let daysInMonth = getNumberOfDaysInMonth(date: firstDateForSection)
        
        return weekDayRowItems+blankItems+daysInMonth
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDatePickerCell", for: indexPath) as! CalendarDatePickerCell
        
        cell.layer.cornerRadius = 25
        cell.reset()
        
        let blankItems = getWeekDay(date: getFirstDateForSection(section: sectionNum!)) - 1
        
        if indexPath.item < 7
        {
            cell.label.text = getWeekDayLabel(weekday: indexPath.item+1)
        }
        else if indexPath.item < 7+blankItems
        {
            cell.label.text = ""
        }else{
            let dayOfMonth = indexPath.item - (7+blankItems)+1
            let date = getDate(dayOfMonth: dayOfMonth, section: sectionNum!)
            cell.date = date
            cell.label.text = "\(dayOfMonth)"
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            
            let selectDateString = dateFormatterGet.string(from: selectDate)
            let cellDataString = dateFormatterGet.string(from: cell.date!)
            
            if selectDateString == cellDataString{
                
                cell.backgroundColor = self.selectedColor
                let dateString = self.getWeekDayMonthDateYear(date: cell.date!)
                convertedString = convertDateToStringFormat(dateString: dateString)
                self.datNameMonthDateLbl.text = convertedString
                self.yearLbl.text = getYear(date: cell.date!)
                self.monthYearLbl.text = getMonthYear(date: cell.date!)
               
                
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section : Int) ->CGFloat {
        return 5
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section : Int) ->CGFloat {
        return 0
    }
    
    func getFirstDateForSection(section: Int) ->Date{
        return Calendar.current.date(byAdding: .month,value: section, to: getFirstDaate())!
    }
    
    func getFirstDaate()->Date{
        var components = Calendar.current.dateComponents([.month, .year], from: minimumDate!)
        components.day = 1
        return Calendar.current.date(from: components)!
    }
    
    func getWeekDay(date: Date)->Int{
        return Calendar.current.dateComponents([.weekday], from: date).weekday!
    }
    func getNumberOfDaysInMonth(date: Date) ->Int{
        return Calendar.current.range(of: .day, in: .month, for: date)!.count
    }
    
    func getWeekDayLabel(weekday: Int) ->String{
        
        var components = DateComponents()
        components.calendar = Calendar.current
        components.weekday = weekday
        
        let date = Calendar.current.nextDate(after: Date(), matching: components, matchingPolicy: Calendar.MatchingPolicy.strict)
        
        if date == nil
        {
            return "E"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEE"
        return dateFormatter.string(from: date!)
    }
    
    func getDate(dayOfMonth: Int, section: Int) ->Date{
        var components = Calendar.current.dateComponents([.month,.year], from: getFirstDateForSection(section: section))
        components.day = dayOfMonth
        return Calendar.current.date(from: components)!
    }
    
    func getWeekDayMonthDateYear(date: Date) ->String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
    
    func getYear(date: Date) ->String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getMonthYear(date: Date) ->String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    
    func convertDateToStringFormat(dateString: String) ->String
    {
        let dateArray = dateString.components(separatedBy: ",")
        var day = ""
        var monthAndDate  = ""
        
        if dateArray.count == 3{
            day = dateArray[0]
            monthAndDate = dateArray[1]
        }
        
        return day+", "+monthAndDate
    }
}

