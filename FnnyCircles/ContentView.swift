//
//  ContentView.swift
//  FnnyCircles
//
//  Created by Vladimir Dvornikov on 23/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var delay = 16.0
    @State private var size = 30.0
    
    @State private var colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ForEach(0..<6) {num in
                    Circle()
                        .fill(colors[num])
                        .frame(width: size * CGFloat(num + 1))
                        .zIndex(Double(-num))
                        .offset(dragAmount)
                        .animation(.default.delay(Double(num) / delay), value: dragAmount)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        dragAmount = .zero
                        enabled.toggle()
                    }
            )
            Spacer()
            Button {
                colors.shuffle()
            } label: {
                Text("-=RNDM=-")
                    .foregroundColor(.blue)
            }

            HStack {
                Text("size")
                    .frame(width: 50)
                    .foregroundColor(.white)
                Slider(value: $size, in: 10...50)
                    .tint(.yellow)
                Text(String(format: "%.f", size))
                    .frame(width: 30)
                    .foregroundColor(.white)
            }
            .padding()
            
            HStack {
                Text("delay")
                    .frame(width: 50)
                    .foregroundColor(.white)
                Slider(value: $delay, in: 1...30)
                    .tint(.green)
                Text(String(format: "%.f", delay))
                    .frame(width: 30)
                    .foregroundColor(.white)
            }
                .padding()
        }
        .background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
