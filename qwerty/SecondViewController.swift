//
//  SecondViewController.swift
//  qwerty
//
//  Created by Zaitsev Vladislav on 30.12.2024.
//

import UIKit

class SecondViewController: UIViewController {
    
    let label = UILabel()
    let switchControl = UISwitch()
    let pickerView = UIPickerView()
    let slider = UISlider()
    
    var nameOfUser: String?
    var isOn: Bool = false
    let colors = ["Mint", "Teal", "Gray"]
    let colorMap: [String: UIColor] = [
        "Mint": .systemMint,
        "Teal": .systemTeal,
        "Gray": .systemGray2
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorMap[colors[0]]
        
        isOn = UserDefaults.standard.value(forKey: "isOn") as? Bool ?? true
        
        doLabel()
        doSwitch()
        doPicker()
        doSlider()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(isOn, forKey: "isOn")
    }
    
    func doLabel() {
        label.font = .systemFont(ofSize: 24)
        label.textColor = .systemBackground
        label.textAlignment = .center
        //label.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
    }
    
    func doSwitch() {
        switchControl.isOn = isOn
        switchValueControl()
        
        switchControl.addTarget(self, action: #selector(switchControlValueChanged), for: .valueChanged)
        self.view.addSubview(switchControl)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            switchControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switchControl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func switchControlValueChanged() {
        isOn = switchControl.isOn
        switchValueControl()
    }
    
    func switchValueControl() {
        if isOn {
            label.text = "Тебя зовут: \(nameOfUser ?? "Неизвестный")"
        } else {
            label.text = "Включи, так надо"
        }
    }
    
    func doPicker() {
        self.view.addSubview(pickerView)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.topAnchor.constraint(equalTo: switchControl.bottomAnchor)
        ])
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func doSlider() {
        slider.minimumValue = 0
        slider.maximumValue = 100
        //slider.value = 50
        self.view.addSubview(slider)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -100),
            slider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc func sliderValueChanged() {
        view.backgroundColor = view.backgroundColor?.withAlphaComponent(1 - CGFloat(slider.value) / 100)
    }
}

extension SecondViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
}

extension SecondViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.view.backgroundColor = colorMap[colors[row]]
        sliderValueChanged()
    }
}
