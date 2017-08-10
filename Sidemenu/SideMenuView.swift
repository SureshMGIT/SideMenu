//
//  SideMenuView.swift
//  Sidemenu
//
//  Created by Suresh Murugaiyan on 7/26/17.
//  Copyright © 2017 dreamorbit. All rights reserved.
//

import UIKit

protocol MenuSelection{
    func selectedItem(sItem:String)
}
class SideMenuView: UIView,UITableViewDataSource,UITableViewDelegate,MenuSelection {
    func selectedItem(sItem: String) {
        print("view---->\(sItem)")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate:MenuSelection?
    
    @IBOutlet weak var tbl_Menu: UITableView!
    
    let dataArray = ["Main page","News","Notifications","Settings","Logout"]
    
//    required init?(coder aDecoder: NSCoder) {
//        
//        super.init(coder: aDecoder)
//        let backgroundView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
//        let imageView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: backgroundView.frame.size.width, height: backgroundView.frame.size.height))
//        backgroundView.addSubview(imageView)
//        
//        tbl_Menu.backgroundView=backgroundView
//    }
    
    override func layoutSubviews() {
        let backgroundView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        let imageView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: backgroundView.frame.size.width, height: backgroundView.frame.size.height))
        imageView.image=UIImage(named: "Sample2.jpg")
        backgroundView.addSubview(imageView)
        
        tbl_Menu.backgroundView=backgroundView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell==nil {
            cell=UITableViewCell(style: .default, reuseIdentifier: identifier)
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.clear
        }
        cell?.textLabel?.text=dataArray[indexPath.row]
        cell?.textLabel?.textColor=UIColor.white
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(dataArray[indexPath.row])
        delegate?.selectedItem(sItem: dataArray[indexPath.row])
    }
}
