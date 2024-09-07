//
//  MusicPickerView.swift
//  TimeToRelax
//
//  Created by Людмила Долонтаева on 2024-09-05.
//

import SwiftUI

struct MusicPickerView: View {
    @Binding var selectedMusic: String
    @Environment(\.presentationMode) var presentationMode
    
    let musicOptions = ["Нет музыки", "Шум океана", "Лесные звуки", "Дождь", "Медитативная мелодия"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(musicOptions, id: \.self) { music in
                    Button(action: {
                        selectedMusic = music
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text(music)
                            Spacer()
                            if music == selectedMusic {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Выберите музыку", displayMode: .inline)
            .navigationBarItems(trailing: Button("Закрыть") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    MusicPickerView(selectedMusic: .constant("Нет музыки"))
}
