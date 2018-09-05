//
//  StarRateView.swift
//  StarRateViewController
//
//  Created by Shantaram Kokate on 9/5/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit
protocol RatingViewDelegate {
    func updateRatingFormatValue(_ value: Int)
}
@IBDesignable
class StarRateView: UIView {
    // MARK: - Properties
    var imageViewList = [UIImageView]()
    var rating = 0.0
    var delegate: RatingViewDelegate!
    @IBInspectable
    var maxCount: Int = 5 {
        didSet {
            updateView()
        }
    }
    @IBInspectable
    var fillImage: UIImage = UIImage(named: "shapeFill.png")! {
        didSet {
             updateView()
        }
    }
    @IBInspectable
    var emptyImage: UIImage = UIImage(named: "shapeEmpty.png")! {
        didSet {
            updateView()
        }
    }
    @IBInspectable
    var ratingValue: Int = -1 {
        didSet {
             updateViewAppearance(ratingValue)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateView()
    }
    // MAKR: - View
    func updateView() {
        imageViewList.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        for index in 1...maxCount {
            let imageView: UIImageView = UIImageView()
            imageView.image = emptyImage
            imageView.tag = index
            imageView.contentMode = .scaleAspectFit
            imageViewList.append(imageView)
        }
        //Create UIStackView
        let stackView = UIStackView(arrangedSubviews: imageViewList)
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func updateViewAppearance(_ xPoint: Int) {
        var tag = 0
        for imageView in imageViewList {
            let imageViewX = Int(imageView.frame.origin.x)
            print("imageViewX = ",imageViewX)
            if xPoint > imageViewX {
                imageView.image = fillImage
                setNeedsDisplay()
                tag = tag + 1
            } else {
                imageView.image = emptyImage
                setNeedsDisplay()
            }
        }
        updateRating(tag)
    }
    // MARK: - UITouch Delegate
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            updateViewAppearance(Int(currentPoint.x))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            updateViewAppearance(Int(currentPoint.x))
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            updateViewAppearance(Int(currentPoint.x))
        }
    }
    //MARK: - Delegate
    func updateRating(_ value: Int) {
        if delegate != nil {
            delegate.updateRatingFormatValue(value)
        }
    }
}
