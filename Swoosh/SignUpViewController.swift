//
//  ViewController.swift
//  Swoosh
//
//  Created by Anthony Quispe on 11/3/24.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager() // Instantiate CLLocationManager

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the delegate
        mapView.delegate = self
        locationManager.delegate = self
        
        // Request location permissions
        locationManager.requestWhenInUseAuthorization()
        
        // Start updating location
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        
        // Set the initial location to user's location
          if let userLocation = locationManager.location {
              let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
              // Adjust the span for zoom level
              let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // Adjust these values for zoom level
              let region = MKCoordinateRegion(center: center, span: span)
              mapView.setRegion(region, animated: true)
          }
    }
    
    // Handle updates to location authorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        }
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let cornerRadius: CGFloat = 20
        let path = UIBezierPath(
            roundedRect: mapView.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        mapView.layer.mask = maskLayer
    }
   
    @IBAction func PasswordInput(_ sender: Any) {
    }
    @IBAction func EmailInput(_ sender: Any) {
    }
}
