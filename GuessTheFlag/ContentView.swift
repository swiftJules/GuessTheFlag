//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by RBS70 on 4/13/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var scoreTitle = ""
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var score = 0
    @State var turnCount = 0
    
    var body: some View {
        ZStack {
            //LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }//:inner VStack
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            turnCount += 1
                        } label: {
                            FlagImage(country: countries[number])
                        }
                    }//:ForEach
                }//:mid VStack
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }//:outer VStack
            .padding()
        }//:ZStack
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(scoreTitle, isPresented: $gameOver) {
            Button("New game", action: reset)
        } message: {
            Text("Final score: \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        if turnCount < 8 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        } else {
            gameOver = true
        }
    }
    
    func reset() {
        gameOver = false
        showingScore = false
        score = 0
        turnCount = 0
    }
}
