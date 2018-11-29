//
//  BrowseViewController.swift
//  BookBusters
//
//  Created by Shubham Gupta on 11/27/18.
//  Copyright © 2018 B-E-S-M. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {

    var books: [Book] = []
    
    override func viewDidLoad() {
        
        
    }
    
    // set up fetch method for use in view controller
    // NOTE: this fetch is done asynchronously
    // => if it takes time for completion, other tasks that are called
    //    outside of the closure are performed first
    // => any tasks that need to be performed after the fetch finishes
    //    need to be called after completion
    func fetchBooks() {
        // the argument, books, will contain a filled array of Books if successful
        BookBustersAPI().fetchBooks() { (books: [Book]?, error: Error?) in
            // guard if there's an error fetching the books
            if let books = books {
                // if successful, populate self.books with result
                self.books = books
            }
            else {
                // if error, print error in console
                print("Error: \(error ?? " " as! Error)")
            }
            // This is performed after completion.
            // This is still inside of the closure.
            // Calling this outside of the closure will result
            //  in attempting to print from an empty array.
            self.testPrint()
        } // end of closure
    }
    
    // set up post method for use in view controller
    // NOTE: this fetch is done asynchronously
    // => if it takes time for completion, other tasks that are called
    //    outside of the closure are performed first
    // => any tasks that need to be performed after the fetch finishes
    //    need to be called after completion
    func postTestBook() {
        // This is a book dictionary just for testing.
        // You also have the option of passing a dictionary to this
        //  method's arguments.
        // NOTE: Books have an "id" property, but it should not be
        //       set manually. It is auto-assigned and auto-incremented
        //       when a new book is inserted into the database.
        let testBookDictionary: [String: Any] = [
            "name" : "Random Book Of Things",
            "subject" : "English",
            "condition": "Used - Good",
            "quantity" : 1,
            "price": "10.00",
            "description": "No writing, no major wear and tear.",
            "location": "Sacramento, CA",
            "image_link": "https://i.imgur.com/rAoagIA.png",
            "seller_phone": "916-555-0101",
            "seller_email": "coolestperson@yourmail.com"
        ]
        
        // the argument, book, represents a new Book
        // using it is optional, but it is available if needed
        BookBustersAPI().postBook(bookDictionary: testBookDictionary) { (book: Book?, error: Error?) in
            // guard if there's an error with the book
            if let book = book {
                // if successful, notify in console
                print("Post was successful!\n")
                print("NEW BOOK")
                print("--------")
                book.printProperties()
            }
            else {
                // if error, printer error in console
                print("Error: \(error ?? " " as! Error)")
            }
        } // end of closure
    }
    
    // print out any desired book info in this test print method
    func testPrint() {
        print("Books in json")
        print("-------------")
        for book in books {
            print(book.name!)
        }
    }
}




extension BrowseViewController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "booksCell", for: indexPath) as! BrowseCollectionViewCell
        
        
       
       return cell
        
    }
}
    