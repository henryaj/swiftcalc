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

    
    // okay, this is a method (a 'func'tion). Its type is UIButton. 
    // if it returned something, it would have an arrow and a type after the bracket.
    @IBAction func appendDigit(sender: UIButton) {
        // here, 'let' is like var, but it's a constant. It gets defined and never changed.
        // the bang at the end of currentTitle 'unwraps' the optional and gets its value if set.
        // BUT if a value isn't set - the app will crash.
        let digit = sender.currentTitle!
        display.text = display.text! + digit
    }
}

