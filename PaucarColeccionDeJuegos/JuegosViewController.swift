//
//  JuegosViewController.swift
//  PaucarColeccionDeJuegos
//
//  Created by Mac 10 on 17/05/23.
//

import UIKit

class JuegosViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return opciones.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return opciones[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoriaseleccionada = opciones[row]
            print("Seleccionaste: \(categoriaseleccionada)")
    }

    
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var eliminarBoton: UIButton!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    var imagePicker = UIImagePickerController()
    var juego:Juego? = nil
    var opciones: [String] = ["Aventura", "Estrategia","Simulacion","Deportivo","Roles","Shooter"]
    var categoriaseleccionada:String = ""
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true,
        completion: nil)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as!
           AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil {
            juego!.titulo! = tituloTextField.text!
            juego!.categoria = categoriaseleccionada
            juego!.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
        }else{
           let context = (UIApplication.shared.delegate as!
               AppDelegate).persistentContainer.viewContext
           let juego = Juego(context:context)
            juego.titulo = tituloTextField.text
            juego.categoria = categoriaseleccionada
            juego.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerview.dataSource = self
        pickerview.delegate = self
        imagePicker.delegate = self
        
        if juego != nil {
            imageView.image = UIImage(data: (juego!.imagen!) as
               Data)
            let posicion:Int = opciones.firstIndex(of: juego!.categoria!) ?? 0
            pickerview.selectRow(posicion, inComponent: 0, animated: false)
            tituloTextField.text = juego!.titulo
            agregarActualizarBoton.setTitle("Actualizar",for: .normal)
        }else {
            eliminarBoton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        imageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    

}
