//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginText: UITextField?
    var passwordText: UITextField?
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        // Title
        let loginTitleFrame = CGRect(x: 0, y: 20,
                                     width: UIScreen.main.bounds.width,
                                     height: 200)
        let loginTitle = UILabel(frame: loginTitleFrame)
        loginTitle.textAlignment = NSTextAlignment.center
        loginTitle.font = UIFont(descriptor: UIFontDescriptor.init(), size: 30)
        loginTitle.text = "Login"
        loginTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        // Holder
        let contentFrame = CGRect(x: 0, y: 0,
                                 width: UIScreen.main.bounds.width*9/10,
                                 height: 300)
        let contentHolder = UIView(frame: contentFrame)
        contentHolder.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        contentHolder.layer.cornerRadius = 10
        contentHolder.center = view.center

        
        
        // Login Button
        let buttonFrame = CGRect(x: contentFrame.width/2 - contentFrame.width*3/10, y: contentFrame.height - 90,
                                 width: contentFrame.width*3/5,
                                 height: 50)
        let loginButton = UIButton(frame: buttonFrame)
        loginButton.layer.cornerRadius = 10
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        loginButton.backgroundColor = Constants.backgroundColor
        
        // Login TextField
        let textFrame = CGRect(x: 15, y: 0,
                                 width: contentFrame.width,
                                 height: 75)
        loginText = UITextField(frame: textFrame)
        loginText?.placeholder = "Username"
        
        // Login Password
        let passwordFrame = CGRect(x: 15, y: 80,
                                   width: contentFrame.width,
                                   height: 75)
        passwordText = UITextField(frame: passwordFrame)
        passwordText?.placeholder = "Password"
        
        view.addSubview(loginTitle)
        view.addSubview(contentHolder)
        view.addSubview(loginButton)
        contentHolder.addSubview(loginText!)
        contentHolder.addSubview(passwordText!)
        contentHolder.addSubview(loginButton)
        
        // This is how you link buttons to methods programmatically (if we
        // were using a storyboard we would control drag to our IBAction instead)
        // `addTarget` takes in 3 parameters
        //     1. target: this is where the action method is defined (in our case,
        //          this is our MainViewController, or self)
        //     2. action: the method we want to be called when the button (or other
        //          UI element) is interacted with
        //     3. for: (controlEvents) here we tell Xcode when we want the action
        //          to be called. In this case, I put ".touchDown" since I want
        //          "goToNextView" to be called every time the user touches down on the button
        loginButton.addTarget(self, action: #selector(login), for: .touchDown)
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func login(sender: UIButton) {
        let username = loginText?.text
        let password = passwordText?.text
        authenticateUser(username: username, password: password)
        
    }
    
    
    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
