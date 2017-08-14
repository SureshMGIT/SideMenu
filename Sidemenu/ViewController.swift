//
//  ViewController.swift
//  Sidemenu
//
//  Created by Suresh Murugaiyan on 7/26/17.
//  Copyright © 2017 dreamorbit. All rights reserved.
//

import UIKit


class ViewController: UIViewController,MenuSelection {
    
    func selectedItem(sItem: String) {
        print("viewcontroller---->\(sItem)")
        resetSideMenu()
        let alert = UIAlertController(title: "Selected item", message: sItem, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    let reduceWidth:CGFloat = 50.0
    
    var previuosVal,currentVal:CGFloat?
    var isSideMenuViewAdded:Bool? = false
    var isSideMenuShowing:Bool = false
    var alphaVal:CGFloat?
    var sideMenuWidth:CGFloat?
    
    var sideMenUView:SideMenuView?
    
    
    @IBOutlet weak var viewBackground: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewBackground.isHidden=true
        
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(pannMenuAction(panGes:)))
        self.view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidLayoutSubviews() {
        if isSideMenuViewAdded==false {
            isSideMenuViewAdded=true
            sideMenUView = UINib(nibName: "SidemenuView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? SideMenuView
            let xVal = self.view.frame.size.width-50
            alphaVal=1.0/xVal
            sideMenUView?.delegate=self
            sideMenUView!.frame=CGRect(x: -xVal, y: 0, width: xVal, height: self.view.frame.size.height)
            sideMenuWidth=sideMenUView?.frame.size.width
            self.view.addSubview(sideMenUView!)
            viewBackground.alpha=0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapAction(_ sender: Any) {
        resetSideMenu()
    }
    @IBAction func menuAction(_ sender: Any) {
        viewBackground.isHidden=false
//        self.viewBackground.alpha=1.0
        showSideMenu()
    }
    
    func pannMenuAction(panGes:UIPanGestureRecognizer) {
        
        if panGes.state==UIGestureRecognizerState.began {
            
            print("began")
            
        }else if panGes.state==UIGestureRecognizerState.changed{
//            print(panGes.translation(in: self.view))
            
            let tempPoint:CGPoint = panGes.translation(in: self.view)
//            print(tempPoint)
            
            
            if tempPoint.x>0 {
                if currentVal==nil {
                    currentVal=tempPoint.x
                }else{
                    
                    
                    viewBackground.isHidden=false
                    
                    
                    previuosVal=currentVal
                    currentVal=tempPoint.x
                    
                    //                if (sideMenUView?.frame.origin.x)!<0 {
                    let travalVal = currentVal!-previuosVal!
                    //                    print(travalVal)
                    let tempVal = (sideMenUView?.frame.origin.x)!+travalVal
                    
                    if tempVal<0 {
                        //                        print("----------")
                        sideMenuMovingAnimation(tVal: tempVal)
                    }else{
                        //                        print("+++++++++++")
                        sideMenuMovingAnimation(tVal: 0)
                        isSideMenuShowing=true
                    }
                    
                    //                }
                    
                }
            }else if tempPoint.x<0 && isSideMenuShowing==true{
                
                if currentVal==nil {
                    currentVal=tempPoint.x
                }else{
                    
                    previuosVal=currentVal
                    currentVal=tempPoint.x
                    
                    //                if (sideMenUView?.frame.origin.x)!<0 {
                    let travalVal = currentVal!-previuosVal!
                    //                    print(travalVal)
                    let tempVal = (sideMenUView?.frame.origin.x)!+travalVal
                    
                    if tempVal<0 {
                        //                        print("----------")
                        sideMenuMovingAnimation(tVal: tempVal)
                    }else{
                        //                        print("+++++++++++")
                        sideMenuMovingAnimation(tVal: 0)
                        isSideMenuShowing=true
                    }
                    
                    //                }
                    
                }
            }
            
        }else if panGes.state==UIGestureRecognizerState.ended{
            print("ended")
            
            var tVal=self.view.frame.size.width-reduceWidth
            tVal = -tVal
            
            if isSideMenuShowing==false {
                
                if let tempK = currentVal {
                    if tempK > 0 {
                        let tempWidth:Double = Double((sideMenUView?.frame.size.width)!/2)
                        let tempX:Double = Double((sideMenUView?.frame.origin.x)!)
                        
                        let orX = (sideMenUView?.frame.origin.x)!
                        
                        let kVal = orX - tVal
                        
//                        print(kVal)
                        
                        if kVal<80 {
                            
                            showSideMenu()
                            
                        }else{
                            
                            if -tempWidth < tempX {
                                showSideMenu()
                            }else{
                                
                                resetSideMenu()
                            }
                        }
                    }
                }
                
            }else{
                if currentVal == nil {
                    resetSideMenu()
                }else{
                    let kTempVal2:CGFloat = 0
                    
                    if currentVal!<kTempVal2 {
                        resetSideMenu()
                    }else{
                        currentVal=nil
                        previuosVal=nil
                    }
                }
            }
            
        }else if panGes.state==UIGestureRecognizerState.cancelled{
            print("cancelled")
        }else if panGes.state==UIGestureRecognizerState.failed{
            print("failed")
        }
    }
    func sideMenuMovingAnimation(tVal:CGFloat) {
        
        let tempVal = sideMenuWidth!+tVal
        let tempAplha = tempVal*alphaVal!
        UIView.animate(withDuration: 0.1, animations: {
            
        self.sideMenUView!.frame=CGRect(x: tVal, y: 0, width: self.view.frame.size.width-self.reduceWidth, height: self.view.frame.size.height)
            self.viewBackground.alpha=tempAplha
        })
    }
    
    func resetSideMenu(){
        var tVal=self.view.frame.size.width-reduceWidth
        tVal = -tVal
        UIView.animate(withDuration: 0.2, animations: {
            
            self.sideMenUView?.frame.origin.x = tVal
            self.viewBackground.alpha=0
            
        }, completion: {(isFinished:Bool) in
            
            self.viewBackground.isHidden=true
            self.currentVal=nil
            self.previuosVal=nil
            self.isSideMenuShowing=false
        } )
    }
   
    func showSideMenu(){
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.sideMenUView?.frame.origin.x = 0
            self.viewBackground.alpha=1.0
            
        }, completion: {(isFinished:Bool) in
            
            self.currentVal=nil
            self.previuosVal=nil
            self.isSideMenuShowing=true
        } )
    }
    
    
}
