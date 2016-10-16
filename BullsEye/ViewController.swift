//
//  ViewController.swift
//  BullsEye
//
//  Created by Yiqin Yao on 11/10/2016.
//  Copyright © 2016 Yiqin Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel! //Interface Building
    var currentValueOfSlider: Int = 0
    var targetValue: Int = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        //print("Slider now is at \(sender.value)")
        currentValueOfSlider = lroundf(sender.value)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func staroverButton(_ sender: UIButton) {
        startNewGame()
        updateLabels()
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        let difference = abs(currentValueOfSlider - targetValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        let message = "Your scored \(points) points"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default) {
                                                    action in
                                                    self.startNewRound()
                                                    self.updateLabels()
                                                    }// handler: tells the alert what should happen when the button is pressed. This is the “alert dismissed” event you’ve been looking for.
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValueOfSlider = 50
        slider.value = Float(Double(currentValueOfSlider))
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

