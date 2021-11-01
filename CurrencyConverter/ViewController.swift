//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Swayam Barik on 11/1/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRateButtonClicked(_ sender: Any) {
        
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization - Process Data and get data we need
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=4a990ae1cc0ef5a920e4c7e9eeb1123c")
        let session = URLSession.shared
        
        // Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any> // based on JSON output
                        
                        
                        // ASYNC with labels w Dispatch (Do others things while this loads)
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any] {
                               //print(rates)
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                            }
                            
                            
                        }
                        
                        
                        
                    } catch {
                        print("error")
                    }
                    
                }
            }
        }
        // Actually starts the task
        task.resume()
        
    }
    
}

