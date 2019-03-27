//
//  LogInViewController.swift
//  Log-In-Progress
//
//  Created by Lee, Steve on 3/16/19.
//  Copyright © 2019 Lee, Steve. All rights reserved.
//

import UIKit
import Lottie

class LogInViewController: UIViewController {
    
    let checkAnimationView = LOTAnimationView(name: "check")

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var animationContainerView: UIView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var progressBarConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        addPaddingAndBorder(to: usernameTextField)
        addPaddingAndBorder(to: passwordTextField)
        setTextFieldTags()
        setAnimationView()
        progressBarConstraint.constant = (buttonContainerView.frame.size.width) * 2
        fadeInTransition(view: usernameTextField, delay: 0.1)
        fadeInTransition(view: passwordTextField, delay: 0.2)
        fadeInTransition(view: buttonContainerView, delay: 0.3)
        usernameTextField.becomeFirstResponder()
        }

    @IBAction func buttonPressed(_ sender: Any) {
        view.endEditing(true)
        logInTextHide()
        loggingInTextShow()
        progressStart()
    }
    
    func fadeInTransition(view: UIView, delay: Double) {
        view.alpha = 0
        UIView.animate(withDuration: 0.5,
                       delay: delay,
                       options: .curveEaseInOut,
                       animations: {
                        view.alpha = 1.0
        },
                       completion: nil
        )
    }
    
    func setAnimationView() {
        animationContainerView.addSubview(checkAnimationView)
        checkAnimationView.frame.size.height = 25
        checkAnimationView.frame.size.width = 25
        checkAnimationView.loopAnimation = false
        checkAnimationView.animationSpeed = 13
    }
    
    func logInTextHide() {
        UIView.animate(withDuration: 0.2) {
            self.logInButton.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func loggingInTextShow() {
        logInButton.setTitle("Logging In", for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.logInButton.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    func progressStart() {
        UIView.animate(withDuration: 5) {
            self.progressBarConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.8) {
            self.logInTextHide()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.3) {
            self.checkAnimationView.play()
        }
    }
    
    func setTextFieldTags() {
        usernameTextField.tag = 0
        passwordTextField.tag = 1
    }
    
    func addPaddingAndBorder(to textfield: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 12.0, height: 2.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layoutIfNeeded() // text field jumps when ending edit, bug fix
    }
}


