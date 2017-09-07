//
//  ViewController.swift
//  TouchId
//
//  Created by Niranjan, Rajabhaiya on 06/09/17.
//  Copyright © 2017 harman. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchMeButtonClicked(sender: UIButton) {
        //authenticateUser();
        let touchManager = TouchIdManager.shared;
        if (touchManager.canTouchIdAcess()  as Bool) {
           // to
            touchManager.touchIDAuthentication(message: "Hellowrolrd", completion: { (successful, error) in
                if successful {
                    self.showMassageInMainThread(message: "Succesfully authenticate")
                }else{
                    // If authentication failed then show a message to the console with a short description.
                    // In case that the error is a user fallback, then show the password alert view.
                    print(error?.localizedDescription as Any)
                    switch (error as! LAError).code {
                        case LAError.Code.systemCancel:
                            print("Authentication was cancelled by the system")
                            self.showMassageInMainThread(message: "Authentication was cancelled by the system");
                        case LAError.Code.userCancel:
                            print("Authentication was cancelled by the user")
                            self.showMassageInMainThread(message: "Authentication was cancelled by the user");
                
                        case LAError.Code.userFallback:
                            print("User selected to enter custom password")
                            self.showMassageInMainThread(message: "User selected to enter custom password");
                        default:
                            print("Authentication failed")
                            self.showMassageInMainThread(message: "Authentication failed");
                    }
                }
            })
        }else{
            self.showMassageInMainThread(message: "Touch Id is not enable")
        }
    }
    
    func showMassageInMainThread(message : String) {
        OperationQueue.main.addOperation({ () -> Void in
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
}
