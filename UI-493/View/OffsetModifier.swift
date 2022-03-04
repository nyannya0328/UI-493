//
//  OffsetModifier.swift
//  UI-493
//
//  Created by nyannyan0328 on 2022/03/04.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    var coordinateSpace : String = ""
    
    var rect : (CGRect) -> ()
       
    
    func body(content: Content) -> some View {
        
        content
            .overlay {
                
                
                GeometryReader{proxy in
                    
                    Color.clear
                       
                        .preference(key: Offsetkey.self, value: proxy.frame(in: .named(coordinateSpace)))
                        
                    
                }
            }
            .onPreferenceChange(Offsetkey.self) { rect in
                
                self.rect(rect)
            }
    }
}

struct Offsetkey : PreferenceKey{
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        
        value = nextValue()
    }
}

