//
//  ViewController.swift
//  DynamicTable
//
//  Created by MAC on 13/10/20.
//

import UIKit

struct data{
    var title:String
    var description:String
}

class ViewController: UIViewController {
    
    var model = [data]()
    var index = IndexPath()
    
    @IBOutlet weak var txtField1: UITextField!
    @IBOutlet weak var txtField2: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func InsertValue(_ sender: UIButton){
        model.append(data(title:txtField1.text! , description: txtField2.text!))
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    
  
    @IBAction func updateValue(_ sender: UIButton) {
        
        if sender.isEnabled{
            if let cell = tableView.cellForRow(at: index) as? TableViewCell{
                cell.lblTitle.text = self.txtField1.text
                cell.lblDescription.text = self.txtField2.text
            }
        }else{
            if let cell = tableView.cellForRow(at: index) as? TableViewCell{
                cell.lblTitle.text = self.txtField1.text
                cell.lblDescription.text = self.txtField2.text
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }


}

extension ViewController: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if ((indexPath.row % 2) != 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.lblTitle.text = model[indexPath.row].title
            cell.lblDescription.text = model[indexPath.row].description
            cell.backgroundColor = #colorLiteral(red: 0.9214683175, green: 0.921626389, blue: 0.9214584231, alpha: 1)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.lblTitle.text = model[indexPath.row].title
            cell.lblDescription.text = model[indexPath.row].description
            cell.backgroundColor = .none
            return cell
        }
       
    }
    
    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath
        self.txtField1.text = model[indexPath.row].title
        self.txtField2.text = model[indexPath.row].description
    }
  
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            model.remove(at: indexPath.row)
            tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        }
    }
}
