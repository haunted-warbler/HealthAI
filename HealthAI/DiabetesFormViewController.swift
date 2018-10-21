//
//  DiabetesFormViewController.swift
//  HealthAI
//
//  Created by Naresh Kumar on 17/10/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit

class DiabetesFormViewController: UIViewController {

    @IBOutlet weak var glucoseValue: UITextField!
    @IBOutlet weak var heightValue: UITextField!
    @IBOutlet weak var bloodPressureValue: UITextField!
    @IBOutlet weak var diabetesPedigreeValue: UITextField!
    @IBOutlet weak var weightValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func trackButton(_ sender: Any) {
        performSegue(withIdentifier: "formToScorePage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "formToScorePage"{
            let scorePageValue = segue.destination as! DiabetesScoreViewController
            scorePageValue.yourGlucoseValue = Float(glucoseValue.text!)!
            scorePageValue.yourBloodPressureValue = Float(bloodPressureValue.text!)!
            scorePageValue.yourDiabetesPedigreeFunctionValue = Float(diabetesPedigreeValue.text!)!
            scorePageValue.yourHeight = Float(heightValue.text!)!
            scorePageValue.yourWeight = Float(weightValue.text!)!
            
        }
    }
    
}
