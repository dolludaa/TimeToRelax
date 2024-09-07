//
//  ContentView.swift
//  TimeToRelax
//
//  Created by Людмила Долонтаева on 2024-09-05.
//

import SwiftUI

struct MeditationTimerView: View {
    @State private var selectedMinutes = 3
    @State private var timeRemaining = 0
    @State private var totalTime = 0
    @State private var timerRunning = false
    @State private var timer: Timer? = nil
    @State private var showMusicPicker = false
    @State private var selectedMusic: String = "Нет музыки"
    
    let timeOptions = [1, 3, 5, 10, 15]

    var body: some View {
        ZStack {
            Image("meditationBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    ForEach(timeOptions, id: \.self) { minute in
                        Button(action: {
                            selectedMinutes = minute
                        }) {
                            Text("\(minute) мин")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .background(selectedMinutes == minute ? Color.white : Color.white.opacity(0.3))
                                .foregroundColor(selectedMinutes == minute ? .black : .white)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding()
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundColor(.white)
                    
                    Circle()
                        .trim(from: 0, to: progress())
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.white)
                        .rotationEffect(Angle(degrees: -90))
                        .animation(.linear, value: timeRemaining)
                    
                    Text("\(timeRemaining) сек")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(width: 200, height: 200)
                .padding()
                
                // Music Selection Button
                Button(action: {
                    showMusicPicker = true
                }) {
                    HStack {
                        Image(systemName: "music.note")
                        Text(selectedMusic)
                    }
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.bottom)
                
                Button(action: {
                    if timerRunning {
                        stopTimer()
                    } else {
                        startTimer()
                    }
                }) {
                    Text(timerRunning ? "Стоп" : "Старт")
                        .font(.title)
                        .padding()
                        .background(timerRunning ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .sheet(isPresented: $showMusicPicker) {
            MusicPickerView(selectedMusic: $selectedMusic)
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    func startTimer() {
        totalTime = selectedMinutes * 60
        timeRemaining = totalTime
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                // Add sound alert here
            }
        }
    }
    
    func stopTimer() {
        timerRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func progress() -> CGFloat {
        guard totalTime > 0 else { return 1 }
        return CGFloat(timeRemaining) / CGFloat(totalTime)
    }
}

#Preview {
    MeditationTimerView()
}
