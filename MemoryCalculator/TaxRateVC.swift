//
//  TaxRateVC.swift
//  MemoryCalculator
//
//  Created by Yaroslaw Bagriy on 3/30/16.
//

import UIKit

class TaxRateVC: UIViewController {
    
    @IBOutlet weak var taxRateEntry: UITextField!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyTaxRate(_ sender: AnyObject) {
        
        if taxRateEntry.text != "" {
            defaults.set(Double(taxRateEntry.text!)!, forKey: "taxrate")
            dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }
    

}
