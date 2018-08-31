//
//  ViewController.swift
//  GCDSamples
//
//  Created by Gabriel Theodoropoulos on 07/11/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
   
    
    let queue1 = DispatchQueue(label: "com.appcoda.queue1", qos: DispatchQoS.background)
    let queue2 = DispatchQueue(label: "com.appcoda.queue2", qos: DispatchQoS.utility)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // simpleQueues()
        
        // queuesWithQoS()
        
        
//         concurrentQueues()
//         if let queue = inactiveQueue {
//            queue.activate()
//         }
        
        
         queueWithDelay()
        
         fetchImage()
        
         useWorkItem()
    }
    
    
    
    func simpleQueues() {
        
        queue1.async {
            for i in 0..<10 {
                print("red", i)
            }
        }
        
        queue2.async {
            for i in 100..<110 {
                print("aqua",i)
            }
        }
        
        for i in 1000..<1010 {
            print("blue",i)
        }
        
        
    }
    
    
    func queuesWithQoS() {
        
    }
    
    
    var inactiveQueue: DispatchQueue!
    func concurrentQueues() {
        
        let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility, attributes:[.concurrent,.initiallyInactive])
        
        inactiveQueue = anotherQueue
        
        anotherQueue.async {
            for i in 0..<10 {
                print("red",i)
            }
        }
        
        anotherQueue.async {
            for i in 100..<110 {
                print("aqua",i)
            }
        }
        
        anotherQueue.async {
            for i in 1000..<1010 {
                print("blue",i)
            }
        }
        
    }
    
    
    func queueWithDelay() {
        
        let delayQueue = DispatchQueue(label: "com.appcoda.delayqueue",qos: .userInitiated)
        print(Date())
        
        let additionalTime: DispatchTimeInterval = .seconds(2)
        
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print(Date())
        }
        
    }
    
    
    func fetchImage() {
        
        let imageURL:URL = URL(string: "http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png")!
        
        (URLSession(configuration: .default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            
            if let data = imageData {
                print("Did download image data")
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
                
            }
        }).resume()
        
    }
    
    
    func useWorkItem() {
        
        let queue  = DispatchQueue.global()
        
        var value  = 10
        
        let workItem = DispatchWorkItem {
            value += 5
            print(value)
        }
            queue.async(execute: workItem)
    }
}

