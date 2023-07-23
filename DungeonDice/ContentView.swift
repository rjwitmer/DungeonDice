//
//  ContentView.swift
//  DungeonDice
//
//  Created by Bob Witmer on 2023-07-19.
//

import SwiftUI

struct ContentView: View {
    
    @State private var rollMessage = ""
    
    var body: some View {
        
        VStack {
            
            titleView
            
            Spacer()
            
            resultMessageView
            
            Spacer()
            
            ButtonLayout(rollMessage: $rollMessage)
            
        }
        .padding()
        
    }
    
}

extension ContentView {
    private var titleView: some View {
        Text("Dungeon Dice")
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.red)
    }
    private var resultMessageView: some View {
        Text(rollMessage)
            .font(.largeTitle)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .frame(height: 150)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
