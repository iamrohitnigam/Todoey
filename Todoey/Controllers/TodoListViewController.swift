//
//  ViewController.swift
//  Todoey
//
//  Created by Rohit Nigam on 25/04/18.
//  Copyright © 2018 Rohit Nigam. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Items]()
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        loadData()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Items]{
//            itemArray = items
//        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].isSelected == true {
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        itemArray[indexPath.row].isSelected = !itemArray[indexPath.row].isSelected
        
//        if itemArray[indexPath.row].isSelected == true
//        {
//            itemArray[indexPath.row].isSelected = false
//        }
//        else{
//            itemArray[indexPath.row].isSelected = true
//        }
        
        saveData()
        
        
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//            itemArray[indexPath.row].isSelected = false
//        }
//        else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            itemArray[indexPath.row].isSelected = true
//        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //Add Item Clicked
            //self.itemArray.append(textField.text!)
            let newItem = Items()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.saveData()
            
           
        }
        alert.addTextField { (alertTF) in
            alertTF.placeholder = "Create a new Item"
            //print(alertTF.text!)
            textField = alertTF
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveData()
    {
        let encoder = PropertyListEncoder()
        
        do
        {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch
        {
            print("Error occurred, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData()
    {
        if let data = try? Data(contentsOf: dataFilePath!)
        {
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Items].self, from: data)
            }
            catch{
                print("Errorr Occurred")
            }
        }
    }

}

