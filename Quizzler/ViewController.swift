//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let questions = QuestionBank()
    var questionIndex : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        questionLabel.text = questions.list[questionIndex].questionText
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            checkAnswer(userAnswer: true)
        }else{
            checkAnswer(userAnswer: false)
        }
        updateUI()
    }
    
    
    func updateUI() {
        progressLabel.text = "\(questionIndex+1)/13"
        scoreLabel.text = "Score: \(score)"
        progressBar.frame.size.width = (view.frame.size.width/13) * CGFloat(questionIndex+1)
    }
    

    func nextQuestion() {
        questionIndex += 1
        dispQuestion(questionIndex: questionIndex)
        
    }
    
    
    func checkAnswer(userAnswer: Bool) {
        if(questions.list[questionIndex].answer == userAnswer){
            ProgressHUD.showSuccess("You got it!")
            score+=1
        }else{
            ProgressHUD.showError("Wrong Answer")
        }
        if questionIndex == questions.list.count-1 	{
            startOver()
        }else{
            nextQuestion()
        }
    }
    
    
    func startOver() {
       questionIndex = 0
        showAlert()
        dispQuestion(questionIndex: questionIndex)
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: "Finished", message: "You have finished all the questions. Congratulations!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func dispQuestion(questionIndex: Int){
        questionLabel.text = questions.list[questionIndex].questionText
    }
    
}
