//
//  ViewController.swift
//  TestTest
//
//  Created by Calvin Chueh on 3/5/18.
//  Copyright © 2018 Calvin. All rights reserved.
//

import UIKit
import CoreLocation





// Flip this to *true* to use GCD

private let kGCDMode: Bool = true


class ViewController: UIViewController {

  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    locationManager.pausesLocationUpdatesAutomatically = false
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.delegate = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    locationManager.requestAlwaysAuthorization()
  }

}


extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    locationManager.startUpdatingLocation()
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.startMonitoringSignificantLocationChanges()
    print("available", CLLocationManager.significantLocationChangeMonitoringAvailable())
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print(Date(),"UPDATING")
    
    if true == kGCDMode {
    
      DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: { [weak self] in
        self?.locationManager.startUpdatingLocation()
        self?.locationManager.allowsBackgroundLocationUpdates = true
        self?.locationManager.startMonitoringSignificantLocationChanges()
      })
      
    } else {
      print(Date(), #function, "SPAMMING UPDATES")
    }
    
    
  }
  
}
