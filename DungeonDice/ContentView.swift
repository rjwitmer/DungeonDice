//
//  ContentView.swift
//  DungeonDice
//
//  Created by Bob Witmer on 2023-07-19.
//

import SwiftUI

struct ContentView: View {
    
    enum Dice: Int, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var rollMessage = ""
    @State private var overflowButtons = 0  // # of buttons in a less than full row
    
    let horizontalPadding: CGFloat = 16     // default padding size of '.padding()'
    let spacing: CGFloat = 0                // between buttons
    let buttonWidth: CGFloat = 102          // width of button
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                titleView
                
                Spacer()
                
                resultMessageView
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: buttonWidth), spacing: spacing)]) {
                    ForEach(Dice.allCases.dropLast(overflowButtons), id: \.self) { dice in
                        Button("\(dice.rawValue)-sided") {
                            rollMessage = "You rolled a \(dice.roll()) on a\n \(dice.rawValue)-sided dice"
                        }
                        .frame(width: buttonWidth)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }

                HStack {
                    ForEach(Dice.allCases.suffix(overflowButtons), id: \.self) { dice in
                        Button("\(dice.rawValue)-sided") {
                            rollMessage = "You rolled a \(dice.roll()) on a\n \(dice.rawValue)-sided dice"
                        }
                        .frame(width: buttonWidth)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
                
                
            }
            .padding()
            .onChange(of: geo.size.width, perform: { newValue in
                arrangeGridItems(deviceWidth: geo.size.width)
            })
            .onAppear {
                arrangeGridItems(deviceWidth: geo.size.width)
            }
        }

    }
    func arrangeGridItems(deviceWidth: CGFloat) {
        var screenWidth = deviceWidth - (horizontalPadding * 2)  // padding on both sides
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        
        // calculate the number of buttons in each row
        let numberOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        overflowButtons = Dice.allCases.count % numberOfButtonsPerRow

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
