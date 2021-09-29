//
//  SettingsViewController.swift
//  saabrosovPW2
//
//  Created by Сергей Абросов on 23.09.2021.
//

import UIKit
import CoreLocation

final class SettingsViewController: UIViewController {
    public let settingsView = UIView()
    var locationToggle = UISwitch()
    var locationTextView = UITextView()
    var locationManager = CLLocationManager()
    var secondScreen = UIView()
    private let sliders = [UISlider(), UISlider(), UISlider()]
    private let colors = ["Red", "Green", "Blue"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        view.backgroundColor = .red
        setupSettingsView()
        setupCloseButton()
        setupLocationToggle()
        setupSliders()
    }
    
    private func setupSettingsView() {
        view.addSubview(settingsView)
        settingsView.alpha = 1
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        //settingsView.backgroundColor = .green
        
        settingsView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        settingsView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        settingsView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 0
        ).isActive = true
        
        settingsView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: 0
        ).isActive = true
    }
    
    private func setupLocationToggle() {
        settingsView.addSubview(locationToggle)
        
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        
        locationToggle.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 50).isActive = true
        
        locationToggle.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -10 ).isActive = true
        
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
    
    private func setupCloseButton() {
        let button = UIButton(type: .close)
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10 ).isActive = true
        
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
    }
    
    @objc
    private func closeScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupSliders() {
        var top = 80
        for i in 0..<sliders.count {
            let view = UIView()
            settingsView.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.leadingAnchor.constraint(
                equalTo: settingsView.leadingAnchor,
                constant: 10
            ).isActive = true
            
            view.trailingAnchor.constraint(
                equalTo: settingsView.trailingAnchor,
                constant: -10 ).isActive = true
            
            view.topAnchor.constraint(
                equalTo: settingsView.topAnchor,
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
        settingsView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension SettingsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
}
