//
//  ViewController.swift
//  SeeFood
//
//  Created by Vincent Ratford on 3/24/18.
//  Copyright © 2018 Vincent Ratford. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // use .photolibrary with simulator and .camera with device
        imagePicker.allowsEditing = false // make true if you want to allow editing, ie: cropping image for classification
        
        
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
               imageView.image = userPickedimage
        }
        
     
      imagePicker.dismiss(animated: true, completion: nil)
        
        
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    

}

