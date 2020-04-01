//
//  VGSCardTextField.swift
//  VGSFramework
//
//  Created by Vitalii Obertynskyi on 24.11.2019.
//  Copyright © 2019 Vitalii Obertynskyi. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

public class VGSCardTextField: VGSTextField {
    /// card brand icon width
    var iconWidth: CGFloat = 45
    
    /// callback for taking card brand icon
    public var cardsIconSource: ((SwiftLuhn.CardType) -> UIImage?)?
    
    internal lazy var cardIconView = self.makeCardIcon()
    
    // override textFieldDidChange
    override func textFieldValueChanged() {
        super.textFieldValueChanged()
        
        if let state = state as? CardState {
            if cardsIconSource != nil {
                let icon = cardsIconSource?(state.cardBrand)
                cardIconView.image = icon
                
            } else {
                cardIconView.image = state.cardBrand.brandIcon
            }
        }
    }
    
    // make image view for a card brand icon
    private func makeCardIcon() -> UIImageView {
        let result = UIImageView(frame: .zero)
        
        result.contentMode = .scaleAspectFit
        addSubview(result)
        
        // make constraints
        let views = ["view": result]
        result.translatesAutoresizingMaskIntoConstraints = false
        
        let width = NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==\(iconWidth))]",
                                                        options: .alignAllCenterY,
                                                        metrics: nil,
                                                        views: views)
        NSLayoutConstraint.activate(width)
        
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                      options: .alignAllCenterX,
                                                      metrics: nil,
                                                      views: views)
        NSLayoutConstraint.activate(vertical)
        
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:[view]-5-|",
                                                        options: .alignAllCenterY,
                                                        metrics: nil,
                                                        views: views)
        NSLayoutConstraint.activate(horizontal)
        
        return result
    }
}
