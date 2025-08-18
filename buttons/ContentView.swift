//
//  ContentView.swift
//  buttons
//
//  Created by Maxim Dmitrochenko on 8/18/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ButtonView(config: Config(label: "Запустить", iconName: "hand.tap", tintColor: .purple)) {
                print("Hello World!")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
