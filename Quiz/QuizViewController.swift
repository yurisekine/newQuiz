//
//  QuizViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    //クイズを格納する配列
    var quizArray = [AnyObject]()
    
    //正解数
    var correctAnswer:Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons1: UIButton!
    @IBOutlet var choiceButtons2: UIButton!
    @IBOutlet var choiceButtons3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        choiceButtons1.titleLabel!.numberOfLines = 3
        choiceButtons2.titleLabel!.numberOfLines = 3
        choiceButtons3.titleLabel!.numberOfLines = 3
        
        var tmpArray = [AnyObject]()
        
        //------------------------ここから下にクイズを書く------------------------//
        tmpArray.append(["調味料の「さしすせそ」の「さ」は？","砂糖","サラダ油","酒",1])
        tmpArray.append(["調味料の「さしすせそ」の「し」は？","醤油","塩","こしょう",2])
        tmpArray.append(["調味料の「さしすせそ」の「す」は？","マヨネーズ","酢","ソース",2])
        tmpArray.append(["調味料の「さしすせそ」の「せ」は？","焼酎","背脂","醤油",3])
        tmpArray.append(["調味料の「さしすせそ」の「そ」は？","ソース","豆板醤","味噌",3])
        tmpArray.append(["火加減の「強火」とはどれくらい？","炎の先端が鍋の底に\nあたるくらいの火","鍋の底全体に炎が\nあたっている状態","お鍋の底から炎が\nはみだすくらい",2])
        tmpArray.append(["水加減について「たっぷり」とは？","鍋にいれた材料が\n隠れないくらいの水量","ひたひたより少し多めの水量で材料の頭が\n水面にでないくらい","鍋にいれた材料が\nゆったり動かせる\nくらいの状態",3])
        tmpArray.append(["「水からゆでる」のに向いているものは？","葉菜類","イモ類","根菜類",1])
        tmpArray.append(["「熱湯からゆでる」のに向いているものは？","葉菜類や豆類","果菜類","イモ類や根菜類",3])
        tmpArray.append(["「三杯酢」のつくりかたは？","「酢」＋「醤油」","「酢」＋「醤油」\n＋「砂糖」","「酢」＋「砂糖」\n＋「塩」",2])
        tmpArray.append(["「塩ひとつまみ」は？","親指・人さし指・\n中指の3本の指先で\nつまんだ量","親指と人さし指の\n指2本でつまんだ\nくらいの量","人差し指の1本\nの指先についた量",1])
        tmpArray.append(["「塩少々」は？","親指・人さし指・\n中指の3本の指先で\nつまんだ量","親指と人さし指の\n指2本でつまんだ\nくらいの量","人差し指の1本\nの指先についた量",2])
        tmpArray.append(["調味料の「さしすせそ」の順番の意味は？","上から順番に\n使いましょう","下から順番に\n使いましょう","特に意味はない",1])
        tmpArray.append(["「昆布だし」の取り方は？","水につける","火にかけて\n沸騰直前に取り出す","火にかけて\n沸騰後に取り出す",2])
        tmpArray.append(["「かつおだし」の取り方は？","水につける","火にかけて\n沸騰直前に取り出す","沸騰後に\nかつお節を入れる",3])
        tmpArray.append(["味噌汁の「貝類」の入れ方は？","水から入れる","沸騰直前に入れる","沸騰してから入れる",1])
        tmpArray.append(["ステーキ肉に塩コショウをするタイミングは？","焼く１時間前","焼く直前","食べる直前",2])
        tmpArray.append(["冷凍肉を冷凍焼けしない方法は？","砂糖水につけて冷凍する","酢水につけて冷凍する","塩水につけて冷凍する",1])
        tmpArray.append(["ゆで卵の殻をつるっとむくのに向いている？","生みたての卵","1週間後の卵","1ヶ月後の卵",2])
        tmpArray.append(["卵焼きを作る時の混ぜ方は？","切るように混ぜる","かき混ぜる","空気を含むように混ぜる",1])
        //------------------------ここから上にクイズを書く------------------------//
        
        // 問題をシャッフルしてquizArrayに格納する
        while (tmpArray.count > 0) {
            let index = Int(arc4random_uniform(UInt32(tmpArray.count)))
            quizArray.append(tmpArray[index])
            tmpArray.removeAtIndex(index)
        }
        choiceQuiz()
    }
    
    func choiceQuiz() {
        quizTextView.text = quizArray[0][0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        choiceButtons1.setTitle(quizArray[0][1] as? String, forState: .Normal)
        choiceButtons2.setTitle(quizArray[0][2] as? String, forState: .Normal)
        choiceButtons3.setTitle(quizArray[0][3] as? String, forState: .Normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        if quizArray[0][4] as! Int == sender.tag {
            //正解数を増やす
            correctAnswer++
        }
        
        quizArray.removeAtIndex(0)
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultView") {
            
            let resultView = segue.destinationViewController as! ResultViewController
            resultView.correctAnswer = self.correctAnswer
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


