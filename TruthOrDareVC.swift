//
//  TruthOrDareVC.swift
//  SiseCevirme
//
//  Created by elif müberra GÜNESLİCE on 27.08.2024.
//

import UIKit

class TruthOrDareVC: UIViewController {
    @IBOutlet weak var NavigationBar: UINavigationBar!
    @IBOutlet weak var BackButton: UIBarButtonItem!
    @IBOutlet weak var PlayerNameLabel: UILabel!
    @IBOutlet weak var WheelImage: UIImageView!
    @IBOutlet weak var TruthButton: UIButton!
    @IBOutlet weak var DareButton: UIButton!
    @IBOutlet weak var BgImage: UIImageView!
    var viewModel: TruthOrDareViewModelProtocol = TruthOrDareVM() as TruthOrDareViewModelProtocol
    let gradientView = GradientView()


    var selectedCategory: String?
    var questions: [Question] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientView()
        loadQuestions() // Soruları yükle
        setupUI()
    }
    private func loadQuestions() {
            let repository = QuestionRepository()
            repository.fetchQuestions { [weak self] fetchedQuestions in
                DispatchQueue.main.async {
                    self?.questions = fetchedQuestions
                }
            }
        }
    private func setupGradientView() {
        gradientView.frame = view.bounds
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(gradientView, at: 0)
    }
    
    private func setupUI() {
        PlayerNameLabel.text = "Player Name"
    }

    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        // Geri dönme işlemi
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func TruthButton(_ sender: UIButton) {
        presentQuestion(ofType: "Truth")
    }
    
    @IBAction func DareButton(_ sender: UIButton) {
        presentQuestion(ofType: "Dare")
    }
    
    private func presentQuestion(ofType type: String) {
        let filteredQuestions = questions.filter { question in
            return question.questionText.contains(type)
        }
        
        if let randomQuestion = filteredQuestions.randomElement() {
            viewModel.navigateToQuestionscreen()
        } else {
            showAlert(message: "No questions available for \(type).")
        }
    }
    
   

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
