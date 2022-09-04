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
    
    let resetButton: UIButton = {
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset Password", for: [])
        resetButton.configuration = .filled()
        //resetButton.addTarget(self, action: #selector(resetTapped), for: .primaryActionTriggered)
        return resetButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
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

