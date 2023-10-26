//
//  ViewController.swift
//  timerAida
//
//  Created by Aida Primkulova on 26.10.2023.
//

import UIKit
final class ViewController: UIViewController {
    // MARK: - UI
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = .red
        timeLabel.font = .boldSystemFont(ofSize: 70)
        timeLabel.textAlignment = .center
        return timeLabel
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setImage(UIImage(named: "play"), for: .normal)
        return button
    }()
    
    private var isWorkTime = true
    private var isStarted = false {
        didSet {
            if isStarted {
                button.setImage(UIImage(named: "pause"), for: .normal)
            } else {
                button.setImage(UIImage(named: "play"), for: .normal)
            }
        }
    }
    
    var timer: Timer?
    private let limitTime = 25
    var currentTime = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
        setupConstraints()
       
    }
    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(timeLabel)
        view.addSubview(button)
    }
    
    @objc func didTapButton() {
        isStarted.toggle()
        if isStarted {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                self.currentTime -= 1
                self.timeLabel.text = "\(self.currentTime)"
                if self.currentTime < 0 {
                    self.timeLabel.text = "5"
                    self.timeLabel.textColor = .green
                    self.currentTime = 5
                    self.timer?.invalidate()
                    self.isStarted = false
                }
            })
        } else {
            timer?.invalidate()
        }
    }
    
    // MARK: - Setup constraints
    private func setupConstraints() {
        timeLabel.text = "\(currentTime)"
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 70),
            button.heightAnchor.constraint(equalToConstant: 70),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 30)
        ])
    }
}

