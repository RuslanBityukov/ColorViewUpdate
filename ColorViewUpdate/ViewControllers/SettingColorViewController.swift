//
//  SettingColorViewController.swift
//  ColorViewUpdate
//
//  Created by Руслан Битюков on 05.09.2021.
//

import UIKit

class SettingColorViewController: UIViewController {
    
    @IBOutlet var imageView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var delegate: SettingColorViewControllerDelegate!
    var colorScreenViewController: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = colorScreenViewController
        
        updateValueSlider()
        sliderValue()
    }
        
    
    private func numberOfCharacters() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func backgraundColor() {
        let colorSlider = UIColor(red: CGFloat(redSlider.value),
                                  green: CGFloat(greenSlider.value),
                                  blue: CGFloat(blueSlider.value),
                                  alpha: 1)
        imageView.backgroundColor = colorSlider
    }
    
    private func updateValueSlider() {
        let newValue = CIColor(color: colorScreenViewController)
        redSlider.value = Float(newValue.red)
        greenSlider.value = Float(newValue.green)
        blueSlider.value = Float(newValue.blue)
        
        numberOfCharacters()
    }
    
    @IBAction func sliderValue() {
        numberOfCharacters()
        backgraundColor()
    }
    
    @IBAction func doneButtonPresed() {
        dismiss(animated: true)
        delegate.updateColorView(color: imageView.backgroundColor ?? .white)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
}

extension SettingColorViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else {
            showAlert(with: "Attention",
                      and: "Enter a floating point value"); return }
        
        if textField == redTextField {
            redSlider.value = numberValue
        } else if textField == greenTextField {
            greenSlider.value = numberValue
        } else {
            blueSlider.value = numberValue
        }
        
        numberOfCharacters()
        backgraundColor()
    }
}





extension SettingColorViewController {
    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


