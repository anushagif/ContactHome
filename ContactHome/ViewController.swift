//
//  ViewController.swift
//  ContactHome
//
//  Created by Anusha on 31/12/22.
//

import UIKit
import ContactsUI
import Contacts


struct Person{
    
    let name: String
    let id: String
    let source: CNContact
}

class ViewController: UIViewController, CNContactPickerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var models = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
       navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusClicked))
    }
    
    
    @objc func plusClicked(){
        
        let vc = CNContactPickerViewController()
        vc.delegate = self
        present(vc, animated: true)
        
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print("\n\n \(contact)")
        let name = contact.givenName + " " + contact.familyName
        let phoneNumbers = contact.phoneNumbers
        if let firstPhoneNumber = phoneNumbers.index(phoneNumbers.startIndex, offsetBy: 0, limitedBy: phoneNumbers.endIndex) {
          let identifier = String(firstPhoneNumber)
            models.append(Person(name: name, id: identifier, source: contact))
            tableView.reloadData()
        }
       
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellone", for: indexPath) as! ContactTableViewCell
        cell.labelName.text = models[indexPath.row].name
        cell.numberLabel.text = models[indexPath.row].id
        return cell
        
    }
    
    
    
    
}
