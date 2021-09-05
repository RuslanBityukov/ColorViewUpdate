//
//  ColorScreenViewController.swift
//  ColorViewUpdate
//
//  Created by Руслан Битюков on 05.09.2021.
//

import UIKit

protocol SettingColorViewControllerDelegate {
    func updateColorView(color: UIColor)
}

class ColorScreenViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorVC = segue.destination as? SettingColorViewController else { return }
        colorVC.delegate = self
        colorVC.colorScreenViewController = view.backgroundColor
    }
}

extension ColorScreenViewController: SettingColorViewControllerDelegate {
    func updateColorView(color: UIColor) {
        view.backgroundColor = color
    }
}

