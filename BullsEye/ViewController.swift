//
//  ViewController.swift
//  BullsEye
//
//  Created by Nastaran Fekri on 02.10.15.
//  Copyright © 2015 Nastaran Fekri. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
     @IBOutlet weak var slider : UISlider!
     @IBOutlet weak var targetLabel :UILabel!
     @IBOutlet weak var roundLabel: UILabel!
     @IBOutlet weak var scoreLabel: UILabel!
     @IBAction func AlertAction(sender: AnyObject) {
     }
     @IBAction func startOver() {
          startNewGame()
          updateLabels()
          let transition = CATransition()
          transition.type = kCATransitionFade
          transition.duration  = 1
          transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
          view.layer.addAnimation(transition, forKey: nil)
          
     }
    var currentValue = 0
     var targetValue = 0
     var score :Int = 0
     var round = 0
     
    func startNewGame(){
          score = 0
          round = 0
          startNewRound()
     }
     func startNewRound(){
          round += 1
          targetValue = 1+Int(arc4random_uniform(100))
          currentValue = 50
          slider.value = Float(currentValue)
     }

     override func viewDidLoad() {
          let thumbImageNormal = UIImage (named: "SliderThumb-Normal")
          slider.setThumbImage(thumbImageNormal, forState: .Normal)
          let thumbImageHighlighted = UIImage (named: "SliderThumb-Highlighted")
          slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
          
          let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
          
          if let trackLeftImage = UIImage (named: "SliderTrackLeft"){
               let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
               slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
          }
          
          if let trackRightImage = UIImage (named :"SliderTrackRight"){
               let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
               slider.setMinimumTrackImage(trackRightResizable, forState: .Normal)
          }
        super.viewDidLoad()
          startNewGame()
          updateLabels()
          //currentValue = lroundf(slider.value)
      // targetValue = 1+Int(arc4random_uniform(100))
          
    }
     func updateLabels(){
          targetLabel.text = String(targetValue)
          scoreLabel.text = String(score)
          roundLabel.text = String(round)
          
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    // Dispose of any resources that can be recreated.
    }
    
   
     @IBAction func showAlert(){
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
          
          var title: String
          if  difference == 0
          {
               title = "Perfect!"
               points += 100
          }
          else if difference < 5
          {
               title = "You almost had it!"
             if difference == 1 {
                    
               points += 50
               }
          }else if difference < 10 {
               title = "Pretty good!"
          } else {
               title = "Not even close..."
          }
          
          score += points
     
          
          let message =  /*"The value of the slider is: \(currentValue)"
               
               + "\nThe target value is: \(targetValue)"
               
               + "\nThe difference is: \(difference)" + */ "\nYour score :\(points) points"
          
          
          
          let alert = UIAlertController(title: title ,message: message, preferredStyle: .Alert)
          
          let action=UIAlertAction(title: "OK", style: .Default,handler : { action in self.startNewRound()
               self.updateLabels() })
          
          alert.addAction(action)
          
          presentViewController( alert, animated: true, completion:nil)
          

        
    }
    @IBAction func slidermoved(slider: UISlider){
     currentValue = lroundf(slider.value)
     
     
     
    }
    
        
        
        
        
    }




