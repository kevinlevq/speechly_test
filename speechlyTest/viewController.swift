//
//  File.swift
//  speechlyTest
//
//  Created by Local Admin on 6/9/23.
//
// this is the github version

import UIKit
import Speechly
import Foundation

class ViewController: UIViewController, SpeechlyManagerDelegate {
    private let manager = SpeechlyManager()

    // Input fields
    fileprivate var district: UITextField!
    fileprivate var poleHeight: UITextField!
    fileprivate var transformerCount: UITextField!
    
    func updateDistrictField(with name: String) { // accepts name as a string
        district.text = name // update fields
    }

    func updatePoleHeightField(with height: String) { // accepts height as a string
        poleHeight.text = height // update fields
    }

    func updateTransformerField(with count: String) { // accepts count as a string
        transformerCount.text = count // update fields
    }
    
    // Submit button
    fileprivate var submitButton: UIButton!
    
    // Error labels
    fileprivate var districtErrorLabel: UILabel!
    fileprivate var poleHeightErrorLabel: UILabel!
    fileprivate var transformerCountErrorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = UIColor.white
        manager.addViews(view: view)
        setupForm()
        NotificationCenter.default.addObserver(self, selector: #selector(self.resetForm), name: NSNotification.Name(rawValue: "resetForm"), object: nil)
        //delegate the values
        manager.delegate = self

    }
     
    
    // styling of the form
    fileprivate func setupForm() {
        // Similar to your Alan AI setupForm function
        // Create your text fields, button and error labels here
        // Add necessary constraints as well
        let padding: CGFloat = 20
        let textFieldHeight: CGFloat = 50
        let buttonHeight: CGFloat = 50

        district = UITextField()
        district.placeholder = "Enter your district (ie the district is ... )"
        district.borderStyle = .roundedRect
        district.font = UIFont.preferredFont(forTextStyle: .body)
        district.textColor = UIColor.darkGray
        district.attributedPlaceholder = NSAttributedString(string: "Enter your district (ie My district is ___ )", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        district.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(district)

        poleHeight = UITextField()
        poleHeight.placeholder = "Enter the pole height (ie The pole height is ...)"
        poleHeight.borderStyle = .roundedRect
        poleHeight.font = UIFont.preferredFont(forTextStyle: .body)
        poleHeight.textColor = UIColor.darkGray
        poleHeight.attributedPlaceholder = NSAttributedString(string: "Enter the pole height (ie The pole height is ___ feet tall)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)])
        poleHeight.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(poleHeight)

        transformerCount = UITextField()
        transformerCount.placeholder = "Enter the transformer count (ie The number of transformers is ...)"
        transformerCount.borderStyle = .roundedRect
        transformerCount.font = UIFont.preferredFont(forTextStyle: .body)
        transformerCount.textColor = UIColor.darkGray
        transformerCount.attributedPlaceholder = NSAttributedString(string: "Enter the transformer count (ie There are ___ transformers)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        transformerCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(transformerCount)

        submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.setTitleColor(UIColor.lightGray, for: .disabled)
        submitButton.backgroundColor = UIColor.systemBlue
        submitButton.layer.cornerRadius = 10
        submitButton.clipsToBounds = true
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
    
        districtErrorLabel = UILabel()
        districtErrorLabel.textColor = UIColor.red
        districtErrorLabel.isHidden = true
        districtErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(districtErrorLabel)

        poleHeightErrorLabel = UILabel()
        poleHeightErrorLabel.textColor = UIColor.red
        poleHeightErrorLabel.isHidden = true
        poleHeightErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(poleHeightErrorLabel)

        transformerCountErrorLabel = UILabel()
        transformerCountErrorLabel.textColor = UIColor.red
        transformerCountErrorLabel.isHidden = true
        transformerCountErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(transformerCountErrorLabel)

    
    NSLayoutConstraint.activate([
        district.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
        district.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
        district.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        district.heightAnchor.constraint(equalToConstant: textFieldHeight),

        poleHeight.topAnchor.constraint(equalTo: district.bottomAnchor, constant: padding),
        poleHeight.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
        poleHeight.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        poleHeight.heightAnchor.constraint(equalToConstant: textFieldHeight),

        transformerCount.topAnchor.constraint(equalTo: poleHeight.bottomAnchor, constant: padding),
        transformerCount.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
        transformerCount.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        transformerCount.heightAnchor.constraint(equalToConstant: textFieldHeight),

        submitButton.topAnchor.constraint(equalTo: transformerCount.bottomAnchor, constant: padding),
        submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
        submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        submitButton.heightAnchor.constraint(equalToConstant: buttonHeight),
                
        districtErrorLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 5),
        districtErrorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
        districtErrorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
                
        poleHeightErrorLabel.topAnchor.constraint(equalTo: districtErrorLabel.bottomAnchor, constant: 5),
        poleHeightErrorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
        poleHeightErrorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
                
        transformerCountErrorLabel.topAnchor.constraint(equalTo: poleHeightErrorLabel.bottomAnchor, constant: 5),
        transformerCountErrorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
        transformerCountErrorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),

    ])
}
    

    // methods to check if forms are filled -> if not give error message
    @objc func submitButtonTapped(){
        var isFormValid = true
        /// check if name is valid
        if let districtField = district.text, !districtField.isEmpty{
            districtErrorLabel.isHidden = true
        }else{
            districtErrorLabel.text = "District Field must be filled"
            districtErrorLabel.isHidden = false
            isFormValid = false
        }
        /// check if adddress is vaid
        if let poleHeightField = poleHeight.text, !poleHeightField.isEmpty{
            poleHeightErrorLabel.isHidden = true
        }else{
            poleHeightErrorLabel.text = "Pole Height Field must be filled"
            poleHeightErrorLabel.isHidden = false
            isFormValid = false
        }
        ///check if phone number vaid
        if let transformerCountField = transformerCount.text, !transformerCountField.isEmpty{
            transformerCountErrorLabel.isHidden = true
        }else{
            transformerCountErrorLabel.text = "Transformer Count Field must be filled"
            transformerCountErrorLabel.isHidden = false
            isFormValid = false
        }
        if isFormValid{
            guard let districtField = district.text, !districtField.isEmpty,
                  let poleHeightField = poleHeight.text, !poleHeightField.isEmpty,
                  let transformerCountField = transformerCount.text, !transformerCountField.isEmpty else {
                       print("all fields must be filled")
                       return
                   }
                   let thankYouVC = ThankYouViewController()
                   thankYouVC.modalPresentationStyle = .fullScreen // or another presentation style that suits your needs
                   self.present(thankYouVC, animated:true, completion: nil)
        }
    }
    
    // reset form function
    @objc func resetForm() {
        // Reset form fields
        district.text = ""
        poleHeight.text = ""
        transformerCount.text = ""
        
        // Reset error labels
        districtErrorLabel.isHidden = true
        poleHeightErrorLabel.isHidden = true
        transformerCountErrorLabel.isHidden = true
    }
}

// define the protocal in swift -> allow me to access the district, poleHeight, and transformer input fields
protocol SpeechlyManagerDelegate: AnyObject {
    func updateDistrictField(with name: String)
    func updatePoleHeightField(with height: String)
    func updateTransformerField(with count: String)
}

// speechly implementation
class SpeechlyManager {
    private let client: Speechly.Client
    private let transcriptView = TranscriptView()
    private lazy var speechButton = MicrophoneButtonView(delegate: self)

    weak var delegate: SpeechlyManagerDelegate?

    public init() {
        client = try! Speechly.Client(
            appId: UUID(uuidString: "7af28b2c-8bb3-4134-9a66-b8ceb2b48c1a")!
        )
        client.delegate = self
        speechButton.holdToTalkText = "Hold to talk"
        speechButton.pressedScale = 1.5
        transcriptView.autohideInterval = 3
    }

    public func addViews(view: UIView) {
        view.addSubview(transcriptView)
        view.addSubview(speechButton)

        transcriptView.translatesAutoresizingMaskIntoConstraints = false
        speechButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            transcriptView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            transcriptView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            transcriptView.bottomAnchor.constraint(equalTo: speechButton.topAnchor, constant: -20),
            transcriptView.heightAnchor.constraint(equalToConstant: 60), // This controls the height of your transcript view

            speechButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speechButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            speechButton.widthAnchor.constraint(equalToConstant: 80),
            speechButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }



    public func start() {
        client.startContext()
    }

    public func stop() {
        client.stopContext()
    }
}

extension SpeechlyManager: MicrophoneButtonDelegate {
    func didOpenMicrophone(_ button: MicrophoneButtonView) {
        self.start()
    }
    func didCloseMicrophone(_ button: MicrophoneButtonView) {
        self.stop()
    }
}

// input values into the application
extension SpeechlyManager: SpeechlyDelegate {
    func speechlyClientDidUpdateSegment(_ client: SpeechlyProtocol, segment: Segment) {
        DispatchQueue.main.async {
            self.transcriptView.configure(segment: segment, animated: true)
            
            // Extracting entities from the segment
            for entity in segment.entities {
                switch entity.type {
                case "name":
                    self.delegate?.updateDistrictField(with: entity.value) // extracts entity value of district
                case "height":
                    self.delegate?.updatePoleHeightField(with: entity.value) // extracts entity value of pole height
                case "count":
                    self.delegate?.updateTransformerField(with: entity.value) // extracts entity value of transformer
                default:
                    print("Unknown entity type: \(entity.type)") // edge case where there is an unknown entity value
                }
            }
        }
    }
}



