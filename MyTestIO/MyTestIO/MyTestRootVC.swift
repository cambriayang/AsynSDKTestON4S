//
//  MyTestRootVC.swift
//  ASDKTestOn4S
//
//  Created by CambriaYang on 16/9/11.
//  Copyright © 2016年 CambriaYang. All rights reserved.
//

import UIKit

enum TestType: Int {
    case DecimalNumberPadForH5 = 0
    case LFMessage
    case PureSwift
    case PureOC
    case ARKit
}

class MyTestRootVC: BaseViewController {
    let testDataSource = [String(describing: "DecimalNumberPadForH5TestVC"), String(describing: "LFMessageTestVC"), String(describing: "PureSwiftTestVC"), String(describing: "PureOCViewController"), String(describing: "ARKitTestVC")];
    
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.baseTableView.register(UINib.init(nibName: "MyTestRootVCCell", bundle: nil), forCellReuseIdentifier: "MyTestRootVCCell")
        
        self.title = "MyTestRootVC"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: --- Table View Delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTestRootVCCell", for: indexPath) as! MyTestRootVCCell

        cell.textLabel?.text = testDataSource[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let testCase = testDataSource[indexPath.row]
        
        let row = TestType(rawValue: indexPath.row)!
        
        switch row {
        case .DecimalNumberPadForH5:
            fallthrough
        case .ARKit:
            fallthrough
        case .LFMessage:
            fallthrough
        case .PureSwift:
            let vc = swiftClassFromString(testCase)!
            
            vc.title = testCase
            self.navigationController?.pushViewController(vc, animated: true)
        case .PureOC:
            let vc = PureOCViewController.init()
            vc.title = testCase
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+5, execute:
            {
                NSLog("===[swift ayncafter: PureOCViewController");
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDataSource.count
    }
}

extension MyTestRootVC {
    func swiftClassFromString(_ className: String) -> UIViewController? {
        //方法 NSClassFromString 在Swift中已经不起作用了no effect，需要适当更改
        //官方文档方法：let myPersonClass: AnyClass? = NSClassFromString("MyGreatApp.Person")
        if  let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            let classStringName = "_TtC\(appName.count)\(appName)\(className.count)\(className)"
            let  cls: AnyClass? = NSClassFromString(classStringName)
            assert(cls != nil, "==[class not found,please check className]==")
            if let viewClass = cls as? UIViewController.Type {
                let view = viewClass.init()
                return view
            }
        }
        
        return nil;
    }
}
