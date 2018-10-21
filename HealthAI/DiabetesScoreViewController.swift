//
//  DiabetesScoreViewController.swift
//  HealthAI
//
//  Created by Naresh Kumar on 17/10/18.
//  Copyright © 2018 Team9. All rights reserved.
//

import UIKit
import Charts

class DiabetesScoreViewController: UIViewController {
    
    var yourGlucoseValue:Float = 0
    var yourBloodPressureValue:Float = 0
    var yourDiabetesPedigreeFunctionValue:Float = 0
    var yourHeight:Float = 0
    var yourWeight:Float = 0
    
    
    @IBOutlet weak var scorePieChart: PieChartView!
    
    var yourScore = PieChartDataEntry(value: 0)
    var remaining = PieChartDataEntry(value: 0)
    var scoreData = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        scorePieChart.chartDescription?.text = ""
        yourScore.value = 65
        yourScore.label = "Score"
        remaining.value = 35
        remaining.label = ""
        
        scoreData = [yourScore, remaining]
        updateChartData()
        
        let url  = URL(string: "https://f58cbluk1h.execute-api.us-east-1.amazonaws.com/ver1")
        
        if let url = url {
            postAndGetData(url: url)
        }
        
       
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
    
    func postAndGetData(url: URL){
        let yourBMIValue = yourWeight/(powf(yourHeight/100, 2))
        let json: [String: Any] = ["Glucose":yourGlucoseValue, "BloodPressure":yourBloodPressureValue, "BMI":yourBMIValue, "DiabetesPedigreeFunction" : yourDiabetesPedigreeFunctionValue]
    
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    // insert json data to the request
    request.httpBody = jsonData
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            do{
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print("printSomething")
                    print(responseJSON)
    }
            }
        }
    else {
            print(error!.localizedDescription)
    }
    }
    task.resume()
    }
    
    func updateChartData(){
    let chartDataSet = PieChartDataSet(values: scoreData, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.blue, UIColor.white]
        chartDataSet.colors = colors 
        
        scorePieChart.data = chartData
    }

}
