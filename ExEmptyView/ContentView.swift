//
//  ContentView.swift
//  ExEmptyView
//
//  Created by 김종권 on 2022/08/31.
//

import SwiftUI

struct ContentView: View {
  @State var isOn = false
  @State var state = false
  @State private var n = 3
  
  var body: some View {
    VStack {
      Text("Text1")
      EmptyView()
        .frame(height: 20)
        .foregroundColor(.blue)
      Text("Text2")
      Spacer()
        .frame(height: 20)
      Text("Text3")
      Toggle(isOn: $isOn, label: { EmptyView() } )
      
      // 1번 방법 - EquatableView 사용
//      EquatableView(content: NumberParity(number: n))
      
      // 2번 방법 - .equatable() 호출
      NumberParity(number: n)
        .equatable()
      Button("New Random Number") {
        self.n = Int.random(in: 1...1000)
      }.padding(.top, 80)
      
      Text("\(n)")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

extension Int {
  var isEven: Bool { return self % 2 == 0 }
  var isOdd: Bool { return self % 2 != 0 }
}

struct NumberParity: View, Equatable {
  let number: Int
  @State private var flag = false
  
  var body: some View {
    let animation = Animation.linear(duration: 3.0).repeatForever(autoreverses: false)
    print("init 호출")
    return VStack {
      if number.isOdd {
        Text("ODD")
      } else {
        Text("EVEN")
      }
    }
    .foregroundColor(.white)
    .padding(20)
    .background(RoundedRectangle(cornerRadius: 10).fill(self.number.isOdd ? Color.red : Color.green))
    .rotationEffect(self.flag ? Angle(degrees: 0) : Angle(degrees: 360))
    .onAppear { withAnimation(animation) { self.flag.toggle() } }
  }
  
  static func == (lhs: NumberParity, rhs: NumberParity) -> Bool {
      lhs.number.isOdd == rhs.number.isOdd
  }
}
