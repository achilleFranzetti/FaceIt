//
//  FaceView.swift
//  FaceIt
//
//  Created by FRANZETTI-LAPTOP on 13/11/17.
//  Copyright © 2017 FRANZETTI-LAPTOP. All rights reserved.
//

import UIKit

class FaceView: UIView {

    
    var scale: CGFloat = 0.9
    var eyesOpen: Bool = false
    
    private var skullRadius: CGFloat { return min(bounds.size.width, bounds.size.height) / 2 * scale }
    private var skullCenter: CGPoint { return CGPoint(x: bounds.midX, y: bounds.midY) }
    
    private enum Eye {
        case left
        case right
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        func centerOfEye(_ eye:Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratios.skullRadusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        
        let eyeRadius = skullRadius / Ratios.skullRadusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        var mult: CGFloat = 0
        if eyesOpen {mult = 2} else {mult = 1}
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: mult * CGFloat.pi, clockwise: true)
        path.lineWidth = 5.0
        return path
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.skullRadusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        let path = UIBezierPath(rect: mouthRect)
        path.lineWidth = 5.0
        return path
    }
    
    private func pathForSkull() -> UIBezierPath
    {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = 5.0
        return path
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.blue.set()
        pathForSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
    }
    
    private struct Ratios {
        static let skullRadusToEyeOffset: CGFloat = 3
        static let skullRadusToEyeRadius: CGFloat = 10
        static let skullRadusToMouthWidth: CGFloat = 1
        static let skullRadusToMouthHeight: CGFloat = 3
        static let skullRadusToMouthOffset: CGFloat = 3
    }
}
