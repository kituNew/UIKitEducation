//
//  ViewController.swift
//  qwerty
//
//  Created by Zaitsev Vladislav on 30.12.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var isGoToNext: Bool = true
    var nameOfUser: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitle("Тык для вопроса", for: .normal)
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
        //button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.view.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        button.addTarget(self, action: #selector(moveToSecondScene), for: .touchUpInside)
    }

    @objc func moveToSecondScene() {
        if (isGoToNext) {
            let alert = UIAlertController(title: "Введите имя", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отмена", style: .default))
            alert.addAction(UIAlertAction(title: "Ввод", style: .default) {(action) in
                self.isGoToNext = false
                if alert.textFields?.first?.text != "" {
                    self.nameOfUser = alert.textFields?.first?.text
                }
                self.SecondScene()
            })
            alert.addTextField { (textField) in
                textField.placeholder = "Введите имя"
            }
            
            present(alert, animated: true)
        } else {
            SecondScene()
        }
    }
    
    func SecondScene() {
        let secondVC = SecondViewController()
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.nameOfUser = self.nameOfUser
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

}

