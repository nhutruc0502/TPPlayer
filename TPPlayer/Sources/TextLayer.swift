//
//  TextLayer.swift
//  TPPlayer
//
//  Created by Truc Pham on 01/10/2021.
//

import Foundation
import Foundation
import UIKit
class TextLayer: CATextLayer {
    var arrowSize : CGSize = .init(width: 25, height: 7)
    weak var scrubber: Scrubber?
    override func draw(in ctx: CGContext) {
        
        guard let scrubber = scrubber else {
            return
        }
        self.fontSize = scrubber.displayTextFontSize
        self.foregroundColor = scrubber.textColor.cgColor
        self.alignmentMode = CATextLayerAlignmentMode.center
        let startPoint = CGPoint(x: 0, y: 0)
        ///box
        let rectBox : CGRect = .init(origin: startPoint, size: .init(width: self.bounds.width, height: self.bounds.height - arrowSize.height))
        
        let path = CGPath(roundedRect: rectBox, cornerWidth: 5, cornerHeight: 5, transform: nil)
        ctx.addPath(path)
        
        //arrow
        let endPoint = CGPoint(x:startPoint.x, y: startPoint.y + self.bounds.height - arrowSize.height)
        let arrowStartPoint = CGPoint(x: (self.bounds.width / 2) - (arrowSize.width / 2) , y: endPoint.y)
        ctx.move(to: arrowStartPoint)
        ctx.addLine(to: CGPoint(x:self.bounds.width/2, y: arrowStartPoint.y + self.arrowSize.height))
        ctx.addLine(to: CGPoint(x:arrowStartPoint.x + arrowSize.width, y: arrowStartPoint.y))
        ctx.addLine(to: arrowStartPoint)
        ctx.fillPath()
        
        // vertical text aligment
        let yDiff = (rectBox.height - fontSize)/2 - fontSize/10
        ctx.saveGState()
        ctx.translateBy(x: 0, y: yDiff)
        
        super.draw(in: ctx)
    }
    
    
}