//
//  CalendarDatePickerCell.swift
//  CustomCalendar
//
//  Created by Subroto Mohonto on 27/9/20.
//  Copyright © 2020 Opu Sumon. All rights reserved.
//

import UIKit

class CalendarDatePickerCell: UICollectionViewCell {
    
    var label : UILabel!
    var date: Date?
    
    var selectedView: UIView?
    var halfBackgroundView : UIView?
    var roundHighlightView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        initLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initLabel()
    }
    
    func initLabel(){
        label = UILabel(frame: frame)
        label.center = CGPoint(x:frame.size.width/2, y:frame.size.height/2)
        label.font = UIFont(name: "Arial", size: 15.0)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        self.addSubview(label)
    }
    
    func reset(){
        
        self.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        
        if selectedView != nil
        {
            selectedView?.removeFromSuperview()
            selectedView = nil
        }
        
         if halfBackgroundView != nil
        {
            halfBackgroundView?.removeFromSuperview()
            halfBackgroundView = nil
        }
        
        if roundHighlightView != nil
        {
            roundHighlightView?.removeFromSuperview()
            roundHighlightView = nil
        }
        
    }
    
}
