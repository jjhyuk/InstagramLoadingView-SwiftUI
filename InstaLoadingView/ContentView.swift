//
//  ContentView.swift
//  InstaLoadingView
//
//  Created by jinhyuk on 2020/09/15.
//  Copyright © 2020 jinhyuk. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    var imageNames:[String] = ["image01","image02","image03","image04","image05","image06","image07"]
    
    @ObservedObject var storyTimer = StoryTimer(items: 7, interval: 2.0)
    
    private var rect: CGRect = CGRect()
    
    
    
    var body: some View {
        
        /// 부모뷰의 크기를 기준으로 View Frame 조절
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                
                Image(self.imageNames[Int(self.storyTimer.progress)])
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    .animation(.none)
                
                
                HStack(alignment: .center, spacing: 4) {
                    ForEach(self.imageNames.indices) { x in
                        LoadingRectangle(progress: min( max( (CGFloat(self.storyTimer.progress) - CGFloat(x)), 0.0) , 1.0))
                            .frame(width: nil, height: 4, alignment: .leading)
                            .animation(.default)
                    }
                }
                
                VStack(alignment: .leading, spacing: 3.0) {
                    Text("Image Name")
                        .bold()
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    
                    Text(": \(self.imageNames[Int(self.storyTimer.progress)])")
                        .bold()
                        .font(.system(size: 20))
                    
                }
                .offset(x: 8, y: 12)
                
                
                
                /// 터치 제스쳐를 위해 생성
                HStack(alignment: .center, spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.storyTimer.advance(by: -1)
                    }
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.storyTimer.advance(by: 1)
                    }
                }
            }
                
                
                
                
            .onAppear(perform: {
                self.storyTimer.start()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
