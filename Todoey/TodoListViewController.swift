//
//  ViewController.swift
//  Todoey
//
//  Created by Rohit Nigam on 25/04/18.
//  Copyright © 2018 Rohit Nigam. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["GoOffice", "Drink Coffee", "Go Home"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //Add Item Clicked
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTF) in
            alertTF.placeholder = "Create a new Item"
            //print(alertTF.text!)
            textField = alertTF
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    

}

