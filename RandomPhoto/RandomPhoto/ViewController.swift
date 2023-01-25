//
//  ViewController.swift
//  RandomPhoto
//
//  Created by 黃紹恩 on 2022/9/20.
//

import UIKit

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
     
    private let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.backgroundColor = .white
        saveButton.setTitle("Save the Image", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.setTitle("Image saved", for: .highlighted)
        saveButton.setTitleColor(.red, for: .highlighted)
        return saveButton
    }()
    
    let colors: [UIColor] = [
        .systemBlue,
        .systemRed,
        .systemCyan,
        .systemGray,
        .systemPink,
        .systemTeal
    ]
    
    var outputImage: UIImage!
    
    func getRandomPhoto(){
        let urlString = "https://source.unsplash.com/random/600x600"
        let url = URL(string: urlString)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        outputImage = UIImage(data: data)
        imageView.image = outputImage
    
    }
    
    @objc func didTapButton(){
        getRandomPhoto()
        view.backgroundColor = colors.randomElement()
    }
    
    @objc func didTapSave(){
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: outputImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(imageView)
        imageView.frame = CGRect(x:0, y:0, width: 350, height:350)
        imageView.center = view.center
        view.addSubview(button)
        view.addSubview(saveButton)
        getRandomPhoto()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        saveButton.frame = CGRect(
            x: 30,
            y: view.frame.size.height-150-view.safeAreaInsets.bottom,
            width: view.frame.size.width-60,
            height: 55
        )
        button.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
        button.center = view.center
    }
    
    

    
}

