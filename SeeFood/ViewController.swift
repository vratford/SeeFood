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
    
    @IBOutlet weak var firstguess: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        imagePicker.delegate = self
        imagePicker.sourceType = .camera // use .photolibrary with simulator and .camera with device
        imagePicker.allowsEditing = false // make true if you want to allow editing, ie: cropping image for classification
        
        
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
               imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert UIIamage to CIImage")
            }
        
            detect(image: ciimage)
        }
        
      imagePicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
//            print(results)
            
            if let firstResult = results.first {
                
                switch firstResult.identifier {
                    case "hotdog, hot dog, red hot":
                        self.navigationItem.title = "Hotdog!"
                case "orange":
                    self.navigationItem.title = "Orange!"
                case "lemon":
                    self.navigationItem.title = "Lemon"
                case "pasta":
                        self.navigationItem.title = "Pasta!"
                case "paper towel":
                    self.navigationItem.title = "Paper Towel!"
                    default:
                        self.navigationItem.title = "My First Guess!"
                    self.firstguess.text = "\(firstResult.identifier) @ \(round(firstResult.confidence*1000) / 10)%"
                }
 
            }
        
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
        

    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    

}

