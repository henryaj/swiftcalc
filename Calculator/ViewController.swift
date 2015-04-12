//
//  ViewController.swift
//  Calculator
//
//  Created by Henry Stanley on 10/04/2015.
//

// this line imports the base UI library into our app.
import UIKit

// here's our first class: the controller for our main view.
// it inherits from UIViewController.
class ViewController: UIViewController {
    
    // this is a property - an instance variable that references, in this case,
    // the our calculator's display. Its type is UILabel.
    // in Swift, all class instances live in the heap, and memory allocation is done
    // automatically for you.
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false

    
    // okay, this is a method (a 'func'tion). Its type is UIButton. 
    // if it returned something, it would have an arrow and a type after the bracket.
    @IBAction func appendDigit(sender: UIButton) {
        // here, 'let' is like var, but it's a constant. It gets defined and never changed.
        // the bang at the end of currentTitle 'unwraps' the optional and gets its value if set.
        // BUT if a value isn't set - the app will crash.
        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            // here, we're calling performOperation but passing in a function as an argument - 
            // a *closure*! performOperation pops off the right numbers from our stack
            // and then executes the function we've passed to it, rendering that output
            // on the display.
            case "+": performOperation() { $0 + $1 }
            case "–": performOperation() { $1 - $0 }
            case "÷": performOperation() { $1 / $0 }
            case "×": performOperation() { $0 * $1 }
            case "√": performOperation() { sqrt($0) }
            default: break
        }
    }
    
    // here, we're defining a function that takes in two doubles and returns a double.
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    // here, we're redefining performOperation - just with different arguments. weird.
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        // this gets the numbers from the display and adds them to a stack.
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println(operandStack)
    }
    
    var displayValue: Double {
        // this guy gets and sets the value of the display and does
        // type conversion to switch it between String and Double
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

