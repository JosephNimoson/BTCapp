//
//  ViewController.swift
//  BTC
//
//  Created by Joseph on 22.07.2018.
//  Copyright © 2018 Joseph Nimoson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    let startURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD"
    let currencySymbolArray = ["$ ", "R$ ", "$ ", "¥ ","€ ","£ ", "$ ", "Rp ","₪ ","₹ ", "¥ ","$ ","kr ","$ ","zł ","lei ","₽ ", "kr ","$ ","$ ","R "]
    var fStartURL = "$"
    
    
    var currencySelected = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        finalURL = baseURL + currencyArray[row]
        print(finalURL)
        currencySelected = currencySymbolArray[row]
        getBitcoinData(url: finalURL)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
         getBitcoinData(url: startURL)
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Networking
    /***************************************************************/
    
        func getBitcoinData(url: String) {
    //
            Alamofire.request(url, method: .get)
                .responseJSON { response in
                    if response.result.isSuccess {
    
                        print("Sucess! Got the bitcoin data")
                        let bitcoinJSON : JSON = JSON(response.result.value!)
    //
                        self.updateBitcoinData(json: bitcoinJSON)
    //
                    } else {
                        print("Error: \(String(describing: response.result.error))")
                        self.priceLabel.text = "Connection Issues"
                    }
                }
    
        }
    
    
    //
    //
    //
    //    //MARK: - JSON Parsing
    //    /***************************************************************/
    //
       func updateBitcoinData(json : JSON) {
    //
            if let bitcoinResult = json["ask"].double {
                priceLabel.text = currencySelected + String(bitcoinResult)
            }else {
                priceLabel.text = "price unavaible"
    //
        }
    }
    //
    



}

