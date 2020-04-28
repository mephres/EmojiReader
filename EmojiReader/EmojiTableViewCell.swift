//
//  EmojiTableViewCell.swift
//  EmojiReader
//
//  Created by INTAS Company on 24/04/2020.
//  Copyright © 2020 INTAS Company. All rights reserved.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(object: Emoji){
        self.emojiLabel.text = object.emoji
        self.nameLabel.text = object.name
        self.decriptionLabel.text = object.description
    }
}
