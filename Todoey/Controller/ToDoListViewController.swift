//
//  ViewController.swift
//  Todoey
//
//  Created by Duy Nguyen on 12/17/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    var itemArr=[Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem1 = Item()
        newItem1.item = "Finish Homework"
        itemArr.append(newItem1)
        
        let newItem2 = Item()
        newItem2.item = "Cook some foods"
        newItem2.done = true
        itemArr.append(newItem2)
        
        if let items = defaults.array(forKey: "itemArray") as? [Item]{
            itemArr = items
        }
        
    }
    
    //MARK:- Tableview DataSources Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let newItem = itemArr[indexPath.row]
        cell.textLabel?.text=newItem.item
        cell.accessoryType = newItem.done == true ? .checkmark : .none
        return cell
    }
    
    //MARK: Tableview delegates Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemSelected = itemArr[indexPath.row]
        itemSelected.done = !itemSelected.done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: When add button is pressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add in todo list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.item = textField.text!
            self.itemArr.append(newItem)
            self.defaults.setValue(self.itemArr, forKey: "itemArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    
}
