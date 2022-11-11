//
//  CharactersTableViewController.swift
//  RickAndMorthyCharactersApp
//
//  Created by Osmar Juarez on 07/11/22.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    var personajes = [Result]()
    private var selectedCharacterImgURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //--------------------------------------------------------------------------
        let elDelegueit =  UIApplication.shared.delegate as! AppDelegate
        if elDelegueit.internetStatus {
            if let url=URL(string: "https://rickandmortyapi.com/api/character/") {
                do {
                    let bytes = try Data(contentsOf: url)
                    let rick = try JSONDecoder().decode(Rick.self, from: bytes)
                    self.personajes = rick.results
                }
                catch {}
            }
        }
        //--------------------------------------------------------------------------
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personajes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterNameCell", for: indexPath)
        let personaje = personajes[indexPath.row]
        cell.textLabel?.text = personaje.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacterImgURL = personajes[indexPath.row].image
        self.performSegue(withIdentifier: "detailsSegue", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailsViewController
        destination.characterImgURL = selectedCharacterImgURL
    }
}
