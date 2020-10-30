//
//  ViewController.swift
//  ToDoList
//
//  Created by Trần Sơn on 10/25/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView?
    
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.title = "Task"
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
//        ========= setup
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        updateTasks()
        
    }
    
    @IBAction func didTapAdd(){
        
        let viewController = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        
        viewController.title = "New Task"
        viewController.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func updateTasks(){
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else
        {
            return
        }
        
        for x in 0..<count{
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String{
                self.tasks.append(task)
            }
        }
        
        tableView?.reloadData()
    }

}


extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        
        viewController.title = "New Task"
        viewController.task = tasks[indexPath.row]
        viewController.updateAfterDelete = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
}
