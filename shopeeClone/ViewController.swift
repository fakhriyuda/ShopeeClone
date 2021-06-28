//
//  ViewController.swift
//  shopeeClone
//
//  Created by Fakhri Yuda Rabbani on 28/06/21.
//  Copyright © 2021 Yudstudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let userCorrect = "user"
    let passCorrect = "pass"

    
    @IBOutlet weak var userTF2: UITextField!
    @IBOutlet weak var passTF2: UITextField!
    @IBOutlet weak var eyes: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Login"
        // Do any additional setup after loading the view.
        userTF2.addBottomBorder()
        passTF2.addBottomBorder()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(gesture:)))
        
        eyes.addGestureRecognizer(tapGesture)
        eyes.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            //Here you can initiate your new ViewController
            passTF2.isSecureTextEntry = !passTF2.isSecureTextEntry
            setVisible(eyes)

        }
    }
    
    fileprivate func setVisible(_ button: UIImageView) {
        if(passTF2.isSecureTextEntry){
            button.image = UIImage(named: "view")
        }else{
            button.image = UIImage(named: "invisible")
        }
    }
    @IBAction func loginButton(_ sender: Any) {
        if userTF2.text != userCorrect || passTF2.text != passCorrect{
            Toast(Title: "Error", Text: "Sistem mengalami gangguan, silahkan coba lagi.", delay: 2)
        }else{
            Toast(Title: "Success", Text: "Selamat datang di Shopee", delay: 2)
        }
    }
    func Toast(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
    
    
}
extension UITextField {
    //border bottom
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
    func setLeftView(image: UIImage) {
        //icon kiri textfield
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25)) // set your Own size
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
    
    //kondisi icon eye-password
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(named: "view"), for: .normal)
        }else{
            button.setImage(UIImage(named: "invisible"), for: .normal)
        }
    }
    
    func enablePasswordToggle(image:UIImage){
        //icon kanan textfield
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(18), height: CGFloat(18))
        //action saat eye di click
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
    
        
        self.rightView = button
        self.rightViewMode = .always
        
        //icon kiri textfield
        let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25)) // set your Own size
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        
    }
    //
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        self.setPasswordToggleImage(sender as! UIButton)
    }
}

