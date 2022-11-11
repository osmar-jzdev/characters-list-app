//
//  ViewController.swift
//  RickAndMorthyCharactersApp
//
//  Created by Osmar Juarez on 07/11/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var characterImgURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let elDelegueit =  UIApplication.shared.delegate as! AppDelegate
        if elDelegueit.internetStatus {
            let configuracion = URLSessionConfiguration.default
            let sesion = URLSession(configuration: configuracion)
            guard let laURL = URL(string:characterImgURL)
            else { return }
            
            let request = URLRequest(url: laURL)
            let tarea = sesion.dataTask(with:request) { datos, response, error in
                if  nil != error {
                    print ("algo salió mal \(String(describing: error?.localizedDescription))")
                    return
                }
                guard let bytes = datos else {
                    print ("el response no trajo datos")
                    return
                }
                // para cualquier cambio que se haga en UI debe ser en el thread principal
                DispatchQueue.main.async {
                    let imageview = UIImageView(frame: self.view.frame)
                    imageview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    imageview.image = UIImage(data:bytes)
                    self.view.addSubview(imageview)
                }
            }
            tarea.resume()
        } else {
            
            let alertController = UIAlertController(title: "Error", message: "Lo sentimos, pero al parecer no hay conexión a Internet", preferredStyle: .alert)
            let action = UIAlertAction(title: "Enterado", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
    }

}

