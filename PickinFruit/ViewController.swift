//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var fruitPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruitsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let fruit = fruitsArray[row]
        return fruit
    }
    
    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
        self.fruitPicker.delegate = self
        self.fruitPicker.dataSource = self
        
        
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        let fruitNumber = fruitsArray.count - 1
        for i in 0...2 {
            fruitPicker.selectRow(Int(arc4random_uniform(UInt32(fruitNumber))), inComponent: i, animated: true)
            fruitPicker.selectedRow(inComponent: i)
            print(fruitPicker.selectedRow(inComponent: i))
        }
        if fruitPicker.selectedRow(inComponent: 0) == fruitPicker.selectedRow(inComponent: 1) && fruitPicker.selectedRow(inComponent: 0) == fruitPicker.selectedRow(inComponent: 2) {
            animateLabel(message: "WINNER!")
        }   else {
            animateLabel(message: "TRY AGAIN")
        }
    }

  
    func animateLabel(message: String) {
        resultLabel.text = message
//        UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, options: [.calculationModeCubic, .autoreverse], animations: {
//           UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: { 
//             self.resultLabel.alpha = 1
//           })
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
//                self.resultLabel.alpha = 0
//            })
//            }) { (success) in
//                print("done")
//        }

        resultLabel.alpha = 1
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.autoreverse, .curveEaseInOut], animations: {
            UIView.setAnimationRepeatCount(8)
            self.resultLabel.alpha = 0
        }) { (success) in
                print("done")
        }
    }
    
    
}

// MARK: Set Up
extension ViewController {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.white.cgColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
}



