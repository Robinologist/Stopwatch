//
//  ViewController.swift
//  Stopwatch
//
//  Created by Robin on 5/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
//-----------------------------------------------------------------------------------------------------------
        //hide reset button
        ResetOutlet.isHidden = true
        
        //setup TimerUpdate function to trigger every 1/100th of a sec
        let timer = Timer.scheduledTimer(timeInterval: 0.01,target: self,selector: #selector(TimerUpdate),userInfo: nil,repeats: true)
    }
    
//-----------------------------------------------------------------------------------------------------------
    
    //TimerUpdate function (called every 1/100th of a second)
    @objc private func TimerUpdate() {
        
        //if the button is in the on state (stored by buttonstate variable)
        if buttonstate == 1 {
            
            //add to tick score every 0.01 seconds
            ticks += 1
            
            //convert units
            if ticks == 100 {
                seconds += 1
                ticks = 0
            }
            else if seconds == 60 {
                minutes += 1
                seconds = 0
            }
            else if minutes == 60 {
                hours += 1
                minutes = 0
            }
            
            //reset time-storing variable
            time = ""
            
            //if there are any hours, append them to the time-storing variable first (so they appear on the left)
            if hours > 0 {time.append(String(hours) + ":")}
            
            //if there are any minutes, append them to the time-storing variable next
            if minutes > 0 {time.append(String(minutes) + ":")}
            
            //always append seconds to the time-storing variable next, even if just 00
            if seconds < 10 {time.append("0" + String(seconds) + ":")} //if seconds only has one place, add another 0 for the tens place
            else {time.append(String(seconds) + ":")} //otherwise just append seconds normally
            
            //always append ticks last (so that they appear on the right)
            if ticks < 10 {time.append("0" + String(ticks))} //if ticks only has one place, add another 0 for the tens place
            else {time.append(String(ticks))} //otherwise just append ticks normally
            
            
            //update label
            LabelOutlet.text = time
        }
    }
    
    
    
    //establish time-storing variable
    var time = ""
    
    //establish unit variables
    var ticks = 0
    var seconds = 0
    var minutes = 0
    var hours = 0
    
    //establish buttonstate variable (stores if button is on/off)
    var buttonstate = 0
    
//-----------------------------------------------------------------------------------------------------------
    
    //outlets
    @IBOutlet var LabelOutlet: UILabel!
    
    @IBOutlet var AppBG: UIImageView!
    @IBOutlet var AppFace: UIImageView!
    
    @IBOutlet var ButtonOutlet: UIButton!
    @IBOutlet var ResetOutlet: UIButton!
    
    //-----------------------------------------------------------------------------------------------------------
    
    //when button is tapped
    @IBAction func ButtonAction(_ sender: Any) {
        
        //switch what background is shown (all backgrounds switch to whatever they're not, hidden/shown)
        AppFace.isHidden = !AppFace.isHidden
        AppBG.isHidden = !AppBG.isHidden
        
        //if buttonstate is 0 change button label to "Stop" and buttonstate to 1
        if buttonstate == 0 {
            ButtonOutlet.setTitle("Stop", for: .normal)
            ResetOutlet.isHidden = true
            buttonstate = 1
        }
        //if buttonstate is 1 change button label to "Start" and buttonstate to 0
        else{
            ButtonOutlet.setTitle("Start", for: .normal)
            ResetOutlet.isHidden = false
            buttonstate = 0
        }
    }
    
    
    @IBAction func ResetAction(_ sender: Any) {
        //reset time
        ticks = 0
        seconds = 0
        minutes = 0
        hours = 0
        time = "00:00"
        
        //update label
        LabelOutlet.text = time
        
        //hide reset button
        ResetOutlet.isHidden = true
    }
}
