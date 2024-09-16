//
//  TapListenerView.swift
//  ShortestPathVisualize
//
//  Created by Ayush Rajpal on 5/09/24.
//


import Foundation
import SwiftUI

struct TapListenerView: UIViewRepresentable {
    var tappedCallback: ((CGPoint) -> Void)
    var blockedCallback: ((CGPoint) -> Void)

    func makeUIView(context: UIViewRepresentableContext<TapListenerView>) -> UIView {
        let v = UIView(frame: .zero)
        
        let gesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.tapped)
        )
        let longPress = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.blocked)
        )
        
        longPress.minimumPressDuration = 0.25
        v.addGestureRecognizer(gesture)
        v.addGestureRecognizer(longPress)
        
        return v
    }

    class Coordinator: NSObject {
        var tappedCallback: ((CGPoint) -> Void)
        var blockedCallback: ((CGPoint) -> Void)
        
        init(tappedCallback: @escaping ((CGPoint) -> Void), blockedCallback: @escaping ((CGPoint) -> Void)) {
            self.tappedCallback = tappedCallback
            self.blockedCallback = blockedCallback
        }
        
        @objc
        func tapped(gesture :UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            self.tappedCallback(point)
        }
        
        @objc
        func blocked(gesture: UILongPressGestureRecognizer) {
            switch gesture.state {
            case .began, .changed:
                guard let view = gesture.view else {
                    return
                }
                let location = gesture.location(in: view)
                self.blockedCallback(location)
            default:
                break
            }
        }
    }

    func makeCoordinator() -> TapListenerView.Coordinator {
        return Coordinator(tappedCallback: self.tappedCallback, blockedCallback: self.blockedCallback)
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<TapListenerView>) { }
}
