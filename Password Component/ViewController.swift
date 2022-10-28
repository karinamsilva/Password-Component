//
//  ViewController.swift
//  Password Component
//
//  Created by Karina on 30/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    let passwordStatusView: PasswordStatusView = {
        let passwordStatusView = PasswordStatusView()
        passwordStatusView.translatesAutoresizingMaskIntoConstraints = false
        return passwordStatusView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    
    let resetButton: UIButton = {
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset Password", for: [])
        resetButton.configuration = .filled()
        //resetButton.addTarget(self, action: #selector(resetTapped), for: .primaryActionTriggered)
        return resetButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        style()
        layout()
    }
}

extension ViewController {
    
    func setUp() {
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
    }
    
    private func setupNewPassword() {
        let newPasswordValidation: CustomValidation = {text in
            guard let text = text, !text.isEmpty else {
                self.passwordStatusView.reset()
                return (false, "Enter your password")
            }
            
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.passwordStatusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            
            self.passwordStatusView.updateDisplay(text)
            if !self.passwordStatusView.validate(text) {
                return (false, "Your password must meet the requirements below")
            }
            

            return (true, "")
        }
        newPasswordTextField.customValidation = newPasswordValidation
        newPasswordTextField.textFieldDelegate = self
    }
    
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }
            
            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match.")
            }
            return (true, "")
        }
        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.textFieldDelegate = self
    }
    
    
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    func style() {
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordStatusView.layer.cornerRadius = 5
        passwordStatusView.clipsToBounds = true
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(passwordStatusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
        ])
    }
}

extension ViewController: PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextField) {
        if sender == newPasswordTextField {
            passwordStatusView.updateDisplay(sender.textField.text ?? "")
        }
    }
    
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender == newPasswordTextField {
            passwordStatusView.shouldResetCriteria = false
            _ = newPasswordTextField.validate()
        }
        
        if sender == confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
}

