//
//  CastleTableViewController.swift
//  TheCastle
//
//  Created by Natalia Wcisło on 31/10/2019.
//  Copyright © 2019 Natalia Wcisło. All rights reserved.
//

import UIKit

class CastleTableViewController: UITableViewController {
    let castles = ["Austrian", "Colorodo", "England", "France", "Ireland", "Italy", "Japan", "Massachusetts", "New York", "Prauge", "Slovakia", "United Kingdom"]
    
    var castlesDict = [String: [String]]()
    var castleSectionTitles = [String]()
    
    let castleIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createCastleDict()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return castleSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let castleKey = castleSectionTitles[section]
        guard let castleValues = castlesDict[castleKey] else {
            return 0
        }
        
        return castleValues.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return castleSectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        guard let index = castleSectionTitles.firstIndex(of: title) else {
            return -1
        }
        
        return index
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let castleKey = castleSectionTitles[indexPath.section]
        if let castleValues = castlesDict[castleKey] {
            cell.textLabel?.text = castleValues[indexPath.row]
            let imageFilename = castleValues[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "_")
            cell.imageView?.image = UIImage(named: imageFilename)
        }
        
        return cell
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return castleIndexTitles
    }

    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        headerView.textLabel?.textColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    }
    
    // MARK: - Helper Methods
    
    func createCastleDict() {
        for castle in castles {
            let firstLetterIndex = castle.index(castle.startIndex, offsetBy: 1)
            let castleKey = String(castle[..<firstLetterIndex])
            
            if var castleValues = castlesDict[castleKey] {
                castleValues.append(castle)
                castlesDict[castleKey] = castleValues
            } else {
                castlesDict[castleKey] = [castle]
            }
        }
        castleSectionTitles = [String](castlesDict.keys)
        castleSectionTitles = castleSectionTitles.sorted(by: { $0 < $1 })
    }
}

