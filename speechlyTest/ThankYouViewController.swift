//
//  ThankYouViewController.swift
//  myapp
//
//  Created by Local Admin on 6/5/23.
//

import UIKit

class ThankYouViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        let thankYouLabel = UILabel()
        thankYouLabel.text = "Thank you!"
        thankYouLabel.textAlignment = .center
        thankYouLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(thankYouLabel)
        
        let goBackButton = UIButton(type: .system)
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        goBackButton.setTitleColor(UIColor.white, for: .normal)
        goBackButton.backgroundColor = UIColor.link
        goBackButton.layer.cornerRadius = 10
        goBackButton.clipsToBounds = true
        goBackButton.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(goBackButton)

        
        
        
        
        NSLayoutConstraint.activate([
            thankYouLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            thankYouLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            goBackButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            goBackButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            goBackButton.heightAnchor.constraint(equalToConstant: 44),
            goBackButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    @objc func goBackButtonTapped(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetForm"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
