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
        
        let timer = Timer.scheduledTimer(timeInterval: 0.01,target: self,selector: #selector(TimerUpdate),userInfo: nil,repeats: true)
    }
    @objc private func TimerUpdate() {
        if buttonstate == 1 {
            
            //add to tick score every 0.01 seconds
            ticks += 1
            
            
            //update label (if ticks < 10 -- add a 0 before the digit to keep the spacing consistant)
            if ticks >= 10 {
                if minutes == 0 {
                    LabelOutlet.text = String(seconds)+":"+String(ticks)
                }
                else if hours == 0 {
                    LabelOutlet.text = String(minutes)+":"+String(seconds)+":"+String(ticks)
                }
                else {
                    LabelOutlet.text = String(hours)+":"+String(minutes)+":"+String(seconds)+":"+String(ticks)
                }
            }
            
            //update label (if ticks >= 10)
            if ticks < 10 {
                
                if minutes == 0 {
                    LabelOutlet.text = String(seconds)+":0"+String(ticks)
                }
                else if hours == 0 {
                    LabelOutlet.text = String(minutes)+":"+String(seconds)+":0"+String(ticks)
                }
                else {
                    LabelOutlet.text = String(hours)+":"+String(minutes)+":0"+String(seconds)+":"+String(ticks)
                }
            }
            
            //change
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
        }
    }
    
    var ticks = 0
    var seconds = 0
    var minutes = 0
    var hours = 0
    
    var buttonstate = 0
    
    @IBOutlet var LabelOutlet: UILabel!
    
    @IBOutlet var AppBG: UIImageView!
    @IBOutlet var AppFace: UIImageView!
    
    @IBOutlet var ButtonOutlet: UIButton!
    
    @IBAction func ButtonAction(_ sender: Any) {
        
        AppFace.isHidden = !AppFace.isHidden
        AppBG.isHidden = !AppBG.isHidden
        
        if buttonstate == 0 {
            ButtonOutlet.setTitle("Stop", for: .normal)
            buttonstate = 1
        }
        else{
            ButtonOutlet.setTitle("Start", for: .normal)
            buttonstate = 0
        }
    }
}
