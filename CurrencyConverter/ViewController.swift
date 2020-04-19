//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Samet Bugra Oktay on 19.04.2020.
//  Copyright © 2020 Samet Bugra Oktay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usdLable: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    @IBOutlet weak var nameText: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        
        
        let url = URL(string: "https://prime.exchangerate-api.com/v5/[YOUR API KEY]/latest/TRY")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse["conversion_rates"]  as? [String : Any]
                            {
                                
                                
                                var myString = self.nameText?.text
                                if let myNumber = NumberFormatter().number(from: myString!) {
                                    var price = myNumber.doubleValue
                                    if let usd = rates["USD"] as? Double {
                                        
                                        self.usdLable.text = "USD : \(price * usd)"
                                    }
                                    if let eur = rates["EUR"] as? Double {
                                        self.eurLabel.text = "EUR : \(price * eur)"
                                    }
                                    if let gbp = rates["GBP"] as? Double {
                                        self.gbpLabel.text = "GBP : \(price * gbp)"
                                    }
                                } else {
                                    // what ever error code you need to write
                                    print("error")
                                }
                                
                              
                                
                            }
                        }
                    }catch {
                        print("error")
                    }
                }
            }
            
        }
        task.resume() //bunu eklemeyi unutma
    }
    
}

