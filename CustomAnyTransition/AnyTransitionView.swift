//
//  ContentView.swift
//  CustomAnyTransition
//
//  Created by Skorobogatow, Christian on 2/8/22.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                    y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    
    static var rotating: AnyTransition {
        return AnyTransition.modifier(active: RotateViewModifier(rotation: 180),
                                      identity: RotateViewModifier(rotation: 0))
    }
    
    static func rotatingWithAmount(roation: Double) -> AnyTransition {
        return AnyTransition.modifier(active: RotateViewModifier(rotation: 180),
                                      identity: RotateViewModifier(rotation: 0))
    }
    
    static var rotationOn: AnyTransition {
        return AnyTransition.asymmetric(insertion: .rotating,
                           removal: .move(edge: .leading))
    }
}

struct AnyTransitionView: View {
    
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250,
                           height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.rotationOn)
            }
            
    
            Spacer()
                
            Text("Click me!")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10)
                .padding()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showRectangle.toggle()
                    }
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitionView()
    }
}
