//
//  BlueTitle.swift
//  GuessTheFlag
//
//  Created by RBS70 on 4/17/22.
//

import SwiftUI

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func setBlueTitle() -> some View {
        modifier(BlueTitle())
    }
}
