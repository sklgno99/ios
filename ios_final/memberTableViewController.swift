//
//  memberTableViewController.swift
//  ios_final
//
//  Created by Mac on 2017/6/21.
//  Copyright © 2017年 VM_cyy. All rights reserved.
//

import UIKit

class memberTableViewController: UITableViewController {
    //@IBOutlet var memberTableView: UITableView!
    var members:[[String:String]] = []
    var isAdd = false
    //let fileManager = FileManager.default
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("isADD")
        if isAdd{
            isAdd = false
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    /*func getEditMemberNoti(noti:Notification)
    {
        let dic = noti.userInfo as! [String:String]
        members[self.memberTableView.indexPathForSelectedRow!.row] = dic
            //["name":dic["name"]!,"birth":dic["birth"]!]
        
        /*if self.memberTableView.indexPathForSelectedRow != nil {
            members[self.memberTableView.indexPathForSelectedRow!.row] = noti.userInfo as! [String:String]
        }
        else{
            
            self.members.insert(noti.userInfo as! [String:String], at: 0)
        }
        let url = Setfile()
        (members as NSArray).write(to: url!, atomically:true)
        self.memberTableView.reloadData()*/
        
        self.memberTableView.reloadData()
    }*/
    
    func getAddMemberNoti(noti:Notification) {
        let m_members = noti.userInfo as? [String:String]
        
        members.insert(m_members!, at: 0)
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        var url = docUrl?.appendingPathComponent("mem.txt")
        if navigationItem.title == "Team A"{
            url = docUrl?.appendingPathComponent("TA.txt")
        }
        else if navigationItem.title == "Team K"{
            url = docUrl?.appendingPathComponent("TK.txt")
        }
        else if navigationItem.title == "Team B"{
            url = docUrl?.appendingPathComponent("TB.txt")
        }
        else if navigationItem.title == "Team 4"{
            url = docUrl?.appendingPathComponent("T4.txt")
        }
        else if navigationItem.title == "Team 8"{
            url = docUrl?.appendingPathComponent("T8.txt")
        }
        
        (members as NSArray).write(to: url!, atomically: true)
        
        isAdd = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        var url = docUrl?.appendingPathComponent("mem.txt")
        
        if navigationItem.title == "Team A"{
            url = docUrl?.appendingPathComponent("TA.txt")
        }
        else if navigationItem.title == "Team K"{
            url = docUrl?.appendingPathComponent("TK.txt")
        }
        else if navigationItem.title == "Team B"{
            url = docUrl?.appendingPathComponent("TB.txt")
        }
        else if navigationItem.title == "Team 4"{
            url = docUrl?.appendingPathComponent("T4.txt")
        }
        else if navigationItem.title == "Team 8"{
            url = docUrl?.appendingPathComponent("T8.txt")
        }
        
        let array = NSArray(contentsOf: url!)
        if array != nil {
            members = array as! [[String:String]]
        }
        let notiName = Notification.Name("addNotification")
        //let notiName2 = Notification.Name("maintainNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(memberTableViewController.getAddMemberNoti(noti:)), name: notiName, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(getEditMemberNoti(noti:)), name: notiName2, object: nil)
        
        /*let notificationName = Notification.Name("maintainNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(self.maintainMemberNotification(noti:)), name: notificationName, object: nil)
        let url = Setfile()
        if let readmember = NSArray(contentsOf: url!)
        {
            members = readmember as![Dictionary<String,String>]
        }*/

        //let initmember = nil
        //(initmember as NSArray).write(to: url!, atomically:true)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    /*func getAddMemberNoti(noti:Notification) {
        let m_members = noti.userInfo as? [String:String]
        
        members.insert(m_members!, at: 0)
        
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("member.txt")
        (members as NSArray).write(to: url!, atomically: true)
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! memberTableViewCell

        // Configure the cell...
        let dic = members[indexPath.row]
        cell.nameLabel?.text = dic["name"]
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) -> [UITableViewRowAction]{
        let deleteAct = UITableViewRowAction(style:UITableViewRowActionStyle.default, title:"Delete",handler:{(action,indexPath) -> Void in
            self.members.remove(at: indexPath.row)
        })*/
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        self.members.remove(at: indexPath.row)
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        var url = docUrl?.appendingPathComponent("mem.txt")
        
        if navigationItem.title == "Team A"{
            url = docUrl?.appendingPathComponent("TA.txt")
        }
        else if navigationItem.title == "Team K"{
            url = docUrl?.appendingPathComponent("TK.txt")
        }
        else if navigationItem.title == "Team B"{
            url = docUrl?.appendingPathComponent("TB.txt")
        }
        else if navigationItem.title == "Team 4"{
            url = docUrl?.appendingPathComponent("T4.txt")
        }
        else if navigationItem.title == "Team 8"{
            url = docUrl?.appendingPathComponent("T8.txt")
        }
        print(url)
        (members as NSArray).write(to: url!, atomically: true)
        
        
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.destination is memberDetailTableViewController{
            let controller = segue.destination as! memberDetailTableViewController
            
            let indexPath = tableView.indexPathForSelectedRow
            let memberSelect = members[indexPath!.row]
            controller.memberSelect = memberSelect
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
