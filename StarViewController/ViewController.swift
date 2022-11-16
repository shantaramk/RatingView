//
//  ViewController.swift
//  StarViewController
//
//  Created by Shantaram Kokate on 9/5/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var starRateView: StarRateView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupRatingView()
    }
    func setupRatingView() {
        starRateView.delegate = self
        starRateView.ratingValue = 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: RatingViewDelegate {
    func updateRatingFormatValue(_ value: Int) {
        print("Rating : = ", value)
    }
}
