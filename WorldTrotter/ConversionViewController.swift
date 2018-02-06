//
//  ConversionViewController.swift
//  tempature
//
//  Created by Devontae Reid on 1/29/18.
//  Copyright © 2018 Devontae Reid. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        
        if let text = sender.text, let value = Double(text) {
            if !letterIsFound(input: text) {
                fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
            }
        } else {
            fahrenheitValue = nil
        }
    }
    
    private func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    private func letterIsFound(input: String) -> Bool {
        let letters = NSCharacterSet.letters
        
        if let _ = input.rangeOfCharacter(from: letters) {
            return true
        } else {
            return false
        }
    }
    
    // Close keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    private func convertToCelsius(degrees: String) -> String {
        let celsius = (Double(degrees)! - 32) * (5/9)
        return String(format: "%.2f",celsius)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if letterIsFound(input: string) {
            return false
        } else {
            let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
            let replacementTextHasDecimalSeparator = string.range(of: ".")
            
            if existingTextHasDecimalSeparator != nil,
                replacementTextHasDecimalSeparator != nil {
                return false
            } else {
                return true
            }
        }
    }
    
}
