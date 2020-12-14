//
//  ViewController.swift
//  MetalTest
//
//  Created by Mac mini on 14/12/20.
//

import UIKit
import MetalPetal
class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let temp = CGRect(x: 100, y: 100, width: 100, height: 100)
            let tempView = UIView(frame: temp )
                
            let mtiImageView = MTIImageView(frame: temp)
                
            mtiImageView.image = MTIImage(cgImage: (UIImage(named: "TestImage")!.cgImage)!)//.withCachePolicy( .persistent ) //.withCachePolicy(MTIImage.CachePolicy.transient )
            mtiImageView.isUserInteractionEnabled = false
                
            let panGesture = UIPanGestureRecognizer(target: self,action: #selector(handlePan))
            panGesture.delegate = self
            tempView.addGestureRecognizer(panGesture)
                
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
            pinchGesture.delegate = self
            tempView.addGestureRecognizer(pinchGesture)
                
            let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate))
            rotateGesture.delegate = self
            tempView.addGestureRecognizer(rotateGesture)
                
                
            tempView.clipsToBounds = true
            let crossButton = UIView(frame: CGRect(x: 5, y: 5, width: 10, height: 10))
            crossButton.backgroundColor = UIColor.red
            mtiImageView.frame = tempView.bounds
            mtiImageView.addSubview(crossButton)
            tempView.addSubview(mtiImageView)


            contentView.addSubview(tempView)
        
    }


}

extension ViewController : UIGestureRecognizerDelegate  {
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
      let translation = gesture.translation(in: view)
      guard let gestureView = gesture.view else {
        return
      }

      gestureView.center = CGPoint(
        x: gestureView.center.x + translation.x,
        y: gestureView.center.y + translation.y
      )
      gesture.setTranslation(.zero, in: view)
    }
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let gestureView = gesture.view else {
          return
        }

        gestureView.transform = gestureView.transform.scaledBy(
          x: gesture.scale,
          y: gesture.scale
        )
        gesture.scale = 1
        
        
      }
    @objc func handleRotate(_ gesture: UIRotationGestureRecognizer) {
        guard let gestureView = gesture.view else {
          return
        }

        gestureView.transform = gestureView.transform.rotated(
          by: gesture.rotation
        )
        gesture.rotation = 0
      }
    
    func gestureRecognizer(
      _ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
    }
    
}
