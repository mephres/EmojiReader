//
//  EmojiTableTableViewController.swift
//  EmojiReader
//
//  Created by INTAS Company on 24/04/2020.
//  Copyright © 2020 INTAS Company. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojiArray = [Emoji]()
    var emoji1 = Emoji(emoji: "😻", name: "Love", description: "Love cat", isFavourite: false)
    var emoji2 = Emoji(emoji: "⚽️", name: "Footbal", description: "Footbal game", isFavourite: false)
    var emoji3 = Emoji(emoji: "🐭", name: "Mouse", description: "Mouse is a funny animal", isFavourite: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem?.title = "Редактировать"
        
        emojiArray.append(emoji1)
        emojiArray.append(emoji2)
        emojiArray.append(emoji3)
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        
        let sourceViewController = segue.source as! NewEmojiTableViewController
        let emoji = sourceViewController.emoji
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojiArray[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: emojiArray.count, section: 0)
            
            emojiArray.append(emoji)
            
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojiArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        
        let object = emojiArray[indexPath.row]
        cell.set(object: object)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            emojiArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojiArray.remove(at: sourceIndexPath.row)
        emojiArray.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Done") {
            (action, view, completion) in
            self.emojiArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var emoji = emojiArray[indexPath.row]
        
        let action = UIContextualAction(style: .normal, title: "Favourite" ) {
            (action, view, complection) in
            emoji.isFavourite = !emoji.isFavourite
            self.emojiArray[indexPath.row] = emoji
            complection(true)
        }
        action.backgroundColor = emoji.isFavourite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "editEmoji" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = emojiArray[indexPath.row]
        
        let navigationViewController = segue.destination as! UINavigationController
        let newEmojiViewController = navigationViewController.topViewController as! NewEmojiTableViewController
        
        newEmojiViewController.title = "Редактировать"
        newEmojiViewController.emoji = emoji
        
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
