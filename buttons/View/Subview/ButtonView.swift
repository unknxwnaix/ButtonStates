//
//  ButtonView.swift
//  buttons
//
//  Created by Maxim Dmitrochenko on 8/18/25.
//

import SwiftUI

struct ButtonView: View {
    private let config: Config
    private let action: () -> ()
    @State private var state: ButtonState? = nil
    @State private var isDisabled: Bool = false
    
    init(config: Config, action: @escaping () -> ()) {
        self.config = config
        self.action = action
    }
    
    var body: some View {
        ZStack {
            Button {
                Task {
                    try? await buttonAction()
                }
            } label: {
                Image(systemName: state == nil ? config.iconName ?? "" : state!.buttonConfig.iconName!)
                    .contentTransition(.symbolEffect)
                    .font(.title)
                
                Text(state == nil ? config.label ?? "" : state!.buttonConfig.label!)
                    .contentTransition(.numericText(countsDown: true))
                    .font(.title)
                
            }
            .buttonStyle(.glassProminent)
            .tint(state == nil ? config.tintColor.gradient : state!.buttonConfig.tintColor.gradient)
            .animation(.bouncy, value: state)
            .allowsHitTesting(!isDisabled)
            .onChange(of: state) { _, newValue in
                if newValue == nil {
                    isDisabled = false
                } else {
                    isDisabled = true
                }
            }
        }
    }
    
    func buttonAction() async throws {
        state = .loading
        
        try await Task.sleep(for: .seconds(2))
        
        let randomInt = Int.random(in: 1...2)
        
        if randomInt == 1 {
            state = .success
        } else {
            state = .error
        }
        
        try await Task.sleep(for: .seconds(2))
        state = nil
    }
    
    enum ButtonState {
        case loading, success, error
        
        var buttonConfig: Config {
            switch self {
                case .loading:
                    return Config(label: "Загрузка", iconName: "circle.dotted", tintColor: .yellow)
                case .success:
                    return Config(label: "Успешно", iconName: "checkmark.circle", tintColor: .green)
                case .error:
                    return Config(label: "Ошибка", iconName: "x.circle", tintColor: .red)
            }
        }
    }
}

struct Config {
    var label: String?
    var iconName: String?
    var tintColor: Color = .green
}

#Preview {
    ContentView()
}
