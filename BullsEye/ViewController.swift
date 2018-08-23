//
//  ViewController.swift
//  BullsEye
//
//  Created by Greg Tiu on 8/11/18.
//  Copyright © 2018 Greg Tiu. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var difference: Int = 0
    var roundValue: Int = 1
    var playerScore: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var target: UILabel!
    
    @IBOutlet weak var round:UILabel!
    
    @IBOutlet weak var score:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = Int(slider.value.rounded())
        targetValue = Int.random(in: 1...100)
        target.text = String(targetValue)
        // Do any additional setup after loading the view, typically from a nib.
        let thumbnailNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbnailNormal, for: .normal)
        
        let thumbnailHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbnailHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    
    
    @IBAction func showAlert(){
        difference = abs(targetValue - currentValue)
        
        playerScore = playerScore + (100 - difference)
        
        
        let title: String
        let bonusPoints: Int
        let totalPoints: Int
        
        if difference == 0
        {
            bonusPoints = 100
            title = "Perfect Hit! You gained \(bonusPoints) bonus points"
        }
        else if difference <= 5
        {
            bonusPoints = 50
            title = "So Close! You gained \(bonusPoints) bonus points"
            
        }
        else
        {
            bonusPoints = 0
            title = "Not even close"
        }
        
        totalPoints = (100 - difference) + bonusPoints
        
        let alert = UIAlertController(title: "\(title)" + "\nThe target value is \(targetValue)", message: "You hit a \(currentValue)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "You scored \(totalPoints) points", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        score.text = String(playerScore)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = Int(slider.value.rounded())
    }
    
    func startNewRound(){
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        target.text = String(targetValue)
        roundValue = roundValue + 1
        round.text = String(roundValue)
    }
    
    @IBAction func startNewGame(){
        roundValue = 0
        playerScore = 0
        round.text = String(roundValue)
        score.text = String(playerScore)
        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

