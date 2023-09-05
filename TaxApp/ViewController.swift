//
//  ViewController.swift
//  TaxApp
//
//  Created by Yumi Ito on 2023/09/04.
//


//「原価」など、大体◯◯priceという単語で訳分からなくなったので、日本語で書きました
import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var 結果表示窓: UILabel!
    @IBOutlet weak var 原価入力窓: UITextField!
    @IBOutlet weak var 税率切り替えボタン: UISegmentedControl!
    @IBOutlet weak var 追加ボタン: UIButton!
    @IBOutlet weak var テーブルビュー: UITableView!
    
    var prices: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        テーブルビュー.delegate = self
        テーブルビュー.dataSource = sel
    }
    
    @IBAction func 原価入力窓(_ sender: Any) {
    }
    
    @IBAction func 税率切り替えボタン(_ sender: Any) {
    }
 
    @IBAction func addButtonTapped(_ sender: Any) {    //自分で追加したボタンなのに、なんだったのか分からなくなりました
        if let price = Double(結果表示窓.text ?? "") {
            prices.append(price)
            tableView.reloadData()    //リロードデータがなにかわからない！なんかエラーでる
        }
        func 追加ボタンTapped(_ sender: Any) {
            let totalAmount = prices.reduce(0, +)
            let alert = UIAlertController(title: "合計", message: "\(totalAmount)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    func updateTotalLabel() {
            //入力された原価をDouble型に変換、できないときは終了させる
            guard let price = Double(原価入力窓.text ?? "") else { return }
            //押されたセグメントに合わせた税率の設定
            let taxRate = 税率切り替えボタン.selectedSegmentIndex == 0 ? 0.10 : 0.08
            //原価に税率をかける
            let totalPrice = price * (1 + taxRate)
            //計算結果を結果表示窓に表示
            結果表示窓.text = String(totalPrice)
        }
     
        //入力がないときに落ちないようにする処理群のつもり
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return prices.count
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath)
            cell.textLabel?.text = String(prices[indexPath.row])
            return cell
        }
    }
}
