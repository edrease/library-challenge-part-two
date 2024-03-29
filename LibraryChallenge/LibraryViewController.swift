//
//  ViewController.swift
//  LibraryChallenge
//
//  Created by Edrease Peshtaz on 6/30/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController, UITableViewDataSource {
  
  var libraries = [Library]()
  var seattleLibrary = Library(libraryName: "Seattle Public")
  var puyallupLibrary = Library(libraryName: "Puyallup Library")
  var fictionShelf = Shelf(nameOfShelf: "Fiction")
  let bookOne = Book(title: "Call of the Wild")
  let bookTwo = Book(title: "The Shining")
  var staffPicksShelf = Shelf(nameOfShelf: "Staff Picks")
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    libraries.append(seattleLibrary)
    libraries.append(puyallupLibrary)
    bookOne.enshelf(fictionShelf)
    bookTwo.enshelf(fictionShelf)
    bookTwo.unshelf(fictionShelf)
    fictionShelf.addShelfToLibrary(seattleLibrary)
    fictionShelf.listBooks()
    seattleLibrary.listShelves()
    staffPicksShelf.addShelfToLibrary(seattleLibrary)
    bookTwo.enshelf(staffPicksShelf)
    seattleLibrary.listShelves()
    seattleLibrary.listBooksInLibrary()
    staffPicksShelf.addShelfToLibrary(puyallupLibrary)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return libraries.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
    let libraryToDisplay = libraries[indexPath.row]
    cell.textLabel?.text = libraryToDisplay.libraryName
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "toShelfViewController" {
      if let shelfViewController = segue.destinationViewController as? ShelfViewController {
        if let indexPath = tableView.indexPathForSelectedRow() {
          let selectedRow = indexPath.row
          let selectedLibrary = libraries[selectedRow]
          shelfViewController.selectedLibrary = selectedLibrary
        }
      }
    }
  }
  
}

