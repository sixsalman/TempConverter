//
//  cToFViewController.swift
//  TempConverter
//
//  Created by Salman on 7/31/21.
//

import UIKit

class cToFViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var cTextField: UITextField!
    @IBOutlet var fLabel: UILabel!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        cTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        
        var allowedChars = CharacterSet(charactersIn: "0123456789")
        allowedChars.insert(charactersIn: decimalSeparator)

        if string.rangeOfCharacter(from: allowedChars.inverted) != nil {
            return false
        }
        
        if textField.text?.range(of: decimalSeparator) != nil, string.range(of: decimalSeparator) != nil {
            return false
        }
        
        if let textNow = textField.text {
            let resAfterConcat = textNow + string
            
            if resAfterConcat.count == 5, resAfterConcat.last == decimalSeparator.first {
                return false
            }
            
            if resAfterConcat.replacingOccurrences(of: decimalSeparator, with: "").count > 4 {
                return false
            }
        }
        
        return true
    }
    
    @IBAction func cTextFieldEditingChanged(_ sender: UITextField) {
        if sender.text == "" {
            fLabel.text = "-"
        } else {
            if let text = sender.text, let num = numberFormatter.number(from: text)?.doubleValue {
                let fTemp: Measurement<UnitTemperature> = Measurement(value: num, unit: .celsius).converted(to: .fahrenheit)
                
                fLabel.text = numberFormatter.string(from: NSNumber(value: fTemp.value))
            }
        }
    }
    
}
