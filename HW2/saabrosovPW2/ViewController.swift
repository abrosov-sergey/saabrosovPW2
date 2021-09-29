//
//  ViewController.swift
//  saabrosovPW2
//
//  Created by Сергей Абросов on 21.09.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    private let settingView = UIView()
    private let locationManager = CLLocationManager()
    public let locationTextView = UITextView()
    let locationToggle = UISwitch()
    let locationLabel = UILabel()
    let secondView = SettingsViewController()
    private let sliders = [UISlider(), UISlider(), UISlider()]
    private let colors = ["Red", "Green", "Blue"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        setupLocationTextView()
        setupSettingsView()
        setupSettingsButton()
        setupLocationToggle()
        //setupLocationManager()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupSettingsButton() {
        let settingsButton = UIButton(type: .system)
        
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        
        view.addSubview(settingsButton)
        
        settingsButton.setImage(
            UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal),
            for: .normal
        )
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        settingsButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 15
        ).isActive = true
        
        settingsButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -15 ).isActive = true
        
        settingsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor).isActive = true
        
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
    }
    
    private func setupSettingsView() {
        view.addSubview(settingView)
        settingView.alpha = 0
        
        settingView.translatesAutoresizingMaskIntoConstraints = false
        
        settingView.backgroundColor = .green
        
        settingView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        settingView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        settingView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 10
        ).isActive = true
        
        settingView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -15
        ).isActive = true
    }
    
    private var buttonCount = 0
    @objc private func settingsButtonPressed() {
        /*switch buttonCount {
        //case 0, 1: UIView.animate(withDuration: 0.1, animations: { self.settingsView.alpha = 1 - self.settingsView.alpha })
        case 2: navigationController?.pushViewController(SettingsViewController(),  animated: true)
        default:
        }
        buttonCount = -1
        buttonCount += 1*/
        secondView.secondScreen = view
        view.backgroundColor = secondView.settingsView.backgroundColor
        secondView.locationTextView = locationTextView
        view.backgroundColor = secondView.settingsView.backgroundColor
        
        present(secondView, animated: true)
    }
    
    private func setupLocationTextView() {
        view.addSubview(locationTextView)
        
        locationTextView.backgroundColor = .white
        
        locationTextView.layer.cornerRadius = 20
        
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        
        locationTextView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 60
        ).isActive = true
        
        locationTextView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
        ).isActive = true
        
        locationTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        locationTextView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 15
        ).isActive = true
        
        locationTextView.isUserInteractionEnabled = false
    }
    
    private func setupLocationToggle() {
        settingView.addSubview(locationToggle)
        
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        
        locationToggle.topAnchor.constraint(
            equalTo: settingView.topAnchor,
            constant: 50
        ).isActive = true
        
        locationToggle.trailingAnchor.constraint(equalTo: settingView.trailingAnchor, constant: -10 ).isActive = true
        
        locationToggle.addTarget(self, action: #selector(locationToggleSwitched), for: .valueChanged)
    }
    
    @objc
    func locationToggleSwitched(_ sender: UISwitch) {
        if sender.isOn {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                sender.setOn(false, animated: true)
            }
        } else {
            locationTextView.text = ""
            locationManager.stopUpdatingLocation()
        }
    }
    
    private func setupLocationManager() {
        settingView.addSubview(locationLabel)

        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false

        locationLabel.topAnchor.constraint(
            equalTo: settingView.topAnchor,
            constant: 55
        ).isActive = true

        locationLabel.leadingAnchor.constraint(
            equalTo: settingView.leadingAnchor,
            constant: 10
        ).isActive = true

        locationLabel.trailingAnchor.constraint(
            equalTo: locationToggle.leadingAnchor,
            constant: -10
        ).isActive = true
    }
    
    private func setupSliders() {
        var top = 80
        for i in 0..<sliders.count {
            let view = UIView()
            settingView.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.leadingAnchor.constraint(
                equalTo: settingView.leadingAnchor,
                constant: 10
            ).isActive = true
            
            view.trailingAnchor.constraint(
                equalTo: settingView.trailingAnchor,
                constant: -10 ).isActive = true
            
            view.topAnchor.constraint(
                equalTo: settingView.topAnchor,
                constant: CGFloat(top)
            ).isActive = true
            
            view.heightAnchor.constraint(equalToConstant: 30).isActive =
                true
            top += 40
            
            let label = UILabel()
            
            view.addSubview(label)
            label.text = colors[i]
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 5
            ).isActive = true
            
            label.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ).isActive = true
            
            label.widthAnchor.constraint(
                equalToConstant: 50
            ).isActive = true
            
            let slider = sliders[i]
            
            slider.translatesAutoresizingMaskIntoConstraints = false
            
            slider.minimumValue = 0
            slider.maximumValue = 1
            
            slider.addTarget(self, action:
                                #selector(sliderChangedValue), for: .valueChanged)
            
            view.addSubview(slider)
            
            slider.topAnchor.constraint(equalTo: view.topAnchor,
                                        constant: 5).isActive = true
            
            slider.heightAnchor.constraint(equalToConstant: 20).isActive
                = true
            
            slider.leadingAnchor.constraint(equalTo:
                                                label.trailingAnchor, constant: 10).isActive = true
            
            slider.trailingAnchor.constraint(equalTo:
                                                view.trailingAnchor).isActive = true
        }
    }
       
    @objc private func sliderChangedValue() {
        let red: CGFloat = CGFloat(sliders[0].value)
        let green: CGFloat = CGFloat(sliders[1].value)
        let blue: CGFloat = CGFloat(sliders[2].value)
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
}


