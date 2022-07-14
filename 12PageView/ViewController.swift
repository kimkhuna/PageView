//
//  ViewController.swift
//  12PageView
//
//  Created by 김경훈 on 2022/07/12.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    //AppDelegate 사용을 위한 선언 
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        appDelegate.mainVC = self
        
        
    }


}

