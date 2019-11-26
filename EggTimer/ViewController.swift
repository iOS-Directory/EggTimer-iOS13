//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

import AVFoundation

class ViewController: UIViewController {
    
    //Label to display countdown
    @IBOutlet var timerLabel: UILabel!
    
    //Progress bar
    @IBOutlet var progressBar: UIProgressView!
    
    //Initializing counter
    var counter = 0
    var totalTime = 0
    var countCompleted = true
    //Use a dictionary instead (Like an object but with []
    let eggTimes = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12
    ]
    
    
    var player: AVAudioPlayer!
    
    var timer = Timer()
    //On click will run the following code
    @IBAction func myButton(_ sender: UIButton) {
        
        //get the button being pressed
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        counter = eggTimes[hardness]!
        countCompleted = false
    }
    
    //Timer func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        
        if (counter > 0 && !countCompleted ) {
            timerLabel.text = String(counter)
            
            //Count down progress bar
            let completionPercentage =  ((Float(totalTime) - Float(counter)) / Float(totalTime))
            
            progressBar.progress =  completionPercentage
            
            counter -= 1
            print(counter)
        }else if(counter == 0 && !countCompleted){
            timerLabel.text = "Done!"
            progressBar.progress = 1.0
            playSound()
            countCompleted = true
        }else{
            timerLabel.text = "Start"
        }
        
    }
    //Function to play sound
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        //
        player = try! AVAudioPlayer(contentsOf: url!)
        
        //finally play the sound
        player.play()
    }
}

