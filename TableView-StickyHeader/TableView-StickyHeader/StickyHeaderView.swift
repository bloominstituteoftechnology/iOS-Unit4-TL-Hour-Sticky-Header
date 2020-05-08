//
//  StickyHeaderView.swift
//  TableView-StickyHeader
//
//  Created by Paul Solt on 5/8/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class StickyHeaderView: UIView {
    
    // Properties for views
        
    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        setUpConstraints()
    }
    
    // You cannot use this view in a storyboard, it's all programmatic
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundColor = .systemBlue
    }
    
    func setUpConstraints() {
        
    }
    
    func updateViewForScrollPosition(y: CGFloat, width: CGFloat) {
        // Update the size
        var height: CGFloat = -y
        
        let minHeight: CGFloat = 100
        let defaultHeight: CGFloat = 300
        if height < minHeight {
            // Prevent view from disappearing
            height = minHeight
        } else if height > defaultHeight {
            // Prevent view from growing
            //height = defaultHeight
        }
        print("height: \(height)")

        frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        
        // update alpha for animations
    }

}
