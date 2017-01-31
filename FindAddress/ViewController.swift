//
//  ViewController.swift
//  FindAddress
//
//  Created by Vladimir Nevinniy on 1/31/17.
//  Copyright © 2017 Vladimir Nevinniy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var searchActive : Bool = false
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var filtered:[String] = []
    
    var scopeButtonTitles = ["San Francisco"]
    

    @IBOutlet var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = scopeButtonTitles
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    searchBar.showsScopeBar = true
        
     //   searchBar.scopeBarButtonTitleTextAttributes(for: <#T##UIControlState#>)
    //    searchBar.scopeButtonTitles = scopeButtonTitles
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive {
            return filtered.count
        }
        
        return data.count
    }
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if searchActive {
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = data[indexPath.row]
        
        scopeButtonTitles.append(value)
        searchBar.scopeButtonTitles = nil
        searchBar.scopeButtonTitles = scopeButtonTitles
        
      //  searchBar.invalidateIntrinsicContentSize()
    }
    
}


/*




@available(iOS 3.0, *)
optional public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)*/

extension ViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = data.filter({ (text) -> Bool in
            let tmp: String = text
            //let range = tmp.range(of: searchText)
            
            
            
            
            //let range = tmp.range(of: searchText, options: String.CompareOptions.caseInsensitive, range: Range(searchText.startIndex..<searchText.endIndex), locale: nil)
            let range = tmp.range(of: searchText, options: String.CompareOptions.caseInsensitive, range: nil, locale: nil)
            
            return (range != nil)
        })
        
        if filtered.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
        
        self.table.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        print("shouldChangeTextIn \(range), replacementText \(text)")
        
        return true
    }
    
    //shouldChangeTextIn
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(selectedScope)
    }
    
    
    
    
}

