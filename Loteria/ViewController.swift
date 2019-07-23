//
//  ViewController.swift
//  Loteria
//
//  Copyright © 2019 Rafaela Galdino. All rights reserved.
//

import UIKit

enum GameType: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

class ViewController: UIViewController {

    @IBOutlet weak var gameTypeLabel: UILabel!
    @IBOutlet weak var gameTypeSc: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumbers(for: .megasena)
    }
    
    func showNumbers(for type: GameType) {
        gameTypeLabel.text = type.rawValue // o rawValue permite extrair a string do tipo GameType que é um enum
        
        var game: [Int] = []
        
        switch type {
            case .megasena:
                game = calcResult(6, 60)
                balls.last?.isHidden = false // last (último botão do array) - isHidden (o último botão deve aparecer)
            case .quina:
                game = calcResult(5, 80)
                balls.last?.isHidden = true
        }
        
        for (index, game) in game.enumerated() { // enumerated é um comando quere retorna o index junto com o registro
            balls[index].setTitle("\(game)", for: .normal) // last (último botão do array) isHidden (o último botão não deve aparecer)
        }
    }
    
    func calcResult(_ total: Int, _ universe: Int) -> [Int] {
        var result: [Int] = []
        while result.count < total {
            let randomNumber = Int.random(in:0...universe-1)
            if !result.contains(randomNumber) {
                result.append(randomNumber)
            }
        }
        return result.sorted()
    }
    
    @IBAction func generateGame() {
        switch gameTypeSc.selectedSegmentIndex {
            case 0:
                showNumbers(for: .megasena)
            default:
                showNumbers(for: .quina)
        }
    }
    
}

