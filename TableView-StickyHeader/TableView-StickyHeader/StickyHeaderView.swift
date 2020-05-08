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
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "98º"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 60.0, weight: .light)
//        label.hasDropShadow = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Rochester, NY"
        label.textColor = .white
//        label.hasDropShadow = true
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Clear"
        label.textColor = .white
//        label.hasDropShadow = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "partly-cloudy-day")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
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
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(summaryLabel)
        stackView.addArrangedSubview(temperatureLabel)
        addSubview(stackView)
    }
    
    func setUpConstraints() {
        iconImageView.addConstraints([
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let centerY = centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        centerY.priority = .defaultHigh // can break when at top
        
        let cityTopSpace = cityLabel.topAnchor.constraint(greaterThanOrEqualTo: self.layoutMarginsGuide.topAnchor, constant: 1)
        cityTopSpace.priority = .defaultHigh + 1
        
        addConstraints([
            self.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            centerY,
            cityTopSpace
        ])
    }
    
    var systemSpace: CGFloat = 8

    var minHeight: CGFloat {
        // FIXME: Why is this off by 1 pixel? Where odes it come from?
        // FIXME: Put it inside an inner stack view and get the height of that inner stack view
        return round(cityLabel.frame.height + summaryLabel.frame.height + systemSpace + safeAreaInsets.top + 1 + systemSpace)
    }
    
    let alphaCutOffDistance: CGFloat = 100  // after x points scrolled up, image alpha is 0

    func updateViewForScrollPosition(y: CGFloat, width: CGFloat) {
        // Update the size
        var height: CGFloat = -y
        
    //        let minHeight: CGFloat = 100
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
                
        // Hide content if you scroll up
        var alpha: CGFloat = 1
        if height < defaultHeight &&
            height >= defaultHeight - alphaCutOffDistance {
            alpha = (height - (defaultHeight - alphaCutOffDistance)) / alphaCutOffDistance
        } else if height < (defaultHeight - alphaCutOffDistance) {
            alpha = 0
        }
        fadeViews(alpha: alpha)
    }

    func fadeViews(alpha: CGFloat) {
        iconImageView.alpha = alpha
        temperatureLabel.alpha = alpha
    }

}
