//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Trần Sơn on 10/30/20.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label:UILabel?
    
    var task:String?
    
    var updateAfterDelete: (()->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label?.text=task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))

    }
    
    @objc func deleteTask()
    {
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count-1
        
        UserDefaults().setValue(newCount, forKey: "count")
        UserDefaults().setValue(nil, forKey: "task_\(count)")
        
        updateAfterDelete?()
        
        navigationController?.popViewController(animated: true)
    }
    

}
