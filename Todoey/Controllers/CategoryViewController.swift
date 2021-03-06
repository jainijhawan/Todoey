//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jai Nijhawan on 20/02/19.
//  Copyright © 2019 Jai Nijhawan. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()


    }
    
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }


    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()
            
        }
        alert.addAction(action)
        alert.addTextField { (field) in
         textField = field
            textField.placeholder = "Add New Category"
        }
        
        present(alert, animated: true,completion: nil)
        
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategories(){
        do {
        try context.save()
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    func loadCategories(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
        categories = try context.fetch(request)
        }catch{
            print(error)
        }
        tableView.reloadData()
        
    }
}
