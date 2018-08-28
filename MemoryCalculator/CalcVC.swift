//
//  CalcVC.swift
//  MemoryCalculator
//
//  Created by Yaroslaw Bagriy on 3/30/16.
//

import UIKit

class CalcVC: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    var displayValue : Double {
        
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = "\(newValue)"
        }
        
    }
    
    var userIsTypingNumber = false
    var numberOne : Double = 0
    var numberTwo : Double = 0
    var currentOperator = ""
    var defaults = UserDefaults.standard
    var savedNumber : Double = 0
    var memoryType = ""
    var tax : Double = 7

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func digitTapped(_ sender: UIButton) {
        
        let digit = sender.currentTitle
        
        if userIsTypingNumber == false {
            display.text = ""
            display.text = digit
            userIsTypingNumber = true
        } else if userIsTypingNumber == true {
            display.text = display.text! + digit!
        }
        
    }
    
    @IBAction func operatorTapped(_ sender: UIButton) {
        // reference symbols --> % √ + − × ÷
        
        userIsTypingNumber = false
        currentOperator = sender.currentTitle!
        
        if numberOne == 0 && numberTwo == 0 {
            
            switch currentOperator {
                
            case "÷":
                currentOperator = "/"
                numberOne = displayValue
            case "×":
                currentOperator = "*"
                numberOne = displayValue
            case "−":
                currentOperator = "-"
                numberOne = displayValue
            case "+":
                currentOperator = "+"
                numberOne = displayValue
            default:
                break
                
            }
        } else if numberOne != 0 && numberTwo == 0 {
                        
            switch currentOperator {
                
            case "÷":
                currentOperator = "/"
                numberTwo = displayValue
                displayValue = numberOne / numberTwo
                numberOne = displayValue
                numberTwo = 0
            case "×":
                currentOperator = "*"
                numberTwo = displayValue
                displayValue = numberOne * numberTwo
                numberOne = displayValue
                numberTwo = 0
            case "−":
                currentOperator = "-"
                numberTwo = displayValue
                displayValue = numberOne - numberTwo
                numberOne = displayValue
                numberTwo = 0
            case "+":
                currentOperator = "+"
                numberTwo = displayValue
                displayValue = numberOne + numberTwo
                numberOne = displayValue
                numberTwo = 0
            default:
                break
                
            }
            
        }
        
    }

    @IBAction func sqrtTapped(_ sender: AnyObject) {
        
        displayValue = sqrt(displayValue)
        
    }
    
    @IBAction func percTapped(_ sender: AnyObject) {
        
        numberTwo = displayValue
        
        if currentOperator == "+" || currentOperator == "-" {
            displayValue = (numberTwo / 100) * numberOne
        } else if currentOperator == "/" || currentOperator == "*" {
            displayValue = (numberTwo / 100)
        }
        
    }
    
    @IBAction func equalTapped(_ sender: AnyObject) {
        
        userIsTypingNumber = false
        numberTwo = displayValue
        
        if currentOperator == "/" {
            displayValue = numberOne / numberTwo
        } else if currentOperator == "*" {
            displayValue = numberOne * numberTwo
        } else if currentOperator == "+" {
            displayValue = numberOne + numberTwo
        } else if currentOperator == "-" {
            displayValue = numberOne - numberTwo
        }
        
        numberOne = displayValue
    }
    
    @IBAction func minus10(_ sender: AnyObject) {
        
        userIsTypingNumber = false
        displayValue = displayValue * (90/100)
        
    }
    
    @IBAction func plusTax(_ sender: AnyObject) {
        
        userIsTypingNumber = false
        
        tax = defaults.double(forKey: "taxrate")
        displayValue = (displayValue + (displayValue * (tax / 100)))
        
    }
    
    @IBAction func memoryTapped(_ sender: UIButton) {
        
        memoryType = sender.currentTitle!
        
        switch memoryType {
            
        case "M+":
            savedNumber = savedNumber + displayValue
            defaults.set(savedNumber, forKey: "saved")
        case "M-":
            savedNumber = savedNumber - displayValue
            defaults.set(savedNumber, forKey: "saved")
        case "MR":
            displayValue = defaults.double(forKey: "saved")
        case "MC":
            defaults.removeObject(forKey: "saved")
            display.text = "0"
        case "CA":
            defaults.removeObject(forKey: "saved")
            clearTapped(self)
        default:
            break
        }
        
    }
    
    @IBAction func clearTapped(_ sender: AnyObject) {
        
        currentOperator = ""
        numberOne = 0
        numberTwo = 0
        displayValue = 0
        display.text = "0"
        userIsTypingNumber = false
        
    }
    
}








