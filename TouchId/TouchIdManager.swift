//
//  TouchIdManager.swift
//  TouchId
//
//  Created by Niranjan, Rajabhaiya on 07/09/17.
//  Copyright © 2017 harman. All rights reserved.
//

import Foundation
import LocalAuthentication

final class TouchIdManager{
    static let shared = TouchIdManager()
    let laContext : LAContext
    
    private init() {
        //super.init();
        laContext = LAContext();
    }
    
    private func getLaPolicy() -> LAPolicy {
        var laPolicyValue : LAPolicy
        if #available(iOS 9.0, *) {
            // iOS 9+ users with Biometric and Passcode verification
            laPolicyValue = .deviceOwnerAuthentication
        } else {
            // iOS 8+ users with Biometric and Custom (Fallback button) verification
            //context.localizedFallbackTitle = "Fuu!"
            laPolicyValue = .deviceOwnerAuthenticationWithBiometrics
        }
        return laPolicyValue
    }
    
   public func canTouchIdAcess() -> Bool {
        var err: NSError?
        if laContext.canEvaluatePolicy(getLaPolicy(), error: &err){
            return true
        }
        return false
    }
    
    func touchIDAuthentication(message: String, completion: @escaping (_ successful: Bool, _ error: Error?) -> Void) {
        laContext.evaluatePolicy(getLaPolicy(), localizedReason: message, reply: {
            successful,error in
            completion(successful,error)
        })
    }
}
