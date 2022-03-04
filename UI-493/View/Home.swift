//
//  Home.swift
//  UI-493
//
//  Created by nyannyan0328 on 2022/03/04.
//

import SwiftUI

struct Home: View {
    @State var offset : CGFloat = 0
    
    @State var widht : CGFloat = 1
    
    @State var height : CGFloat = UIScreen.main.bounds.height
    
    @State var cardOffset : [CGFloat] = [0,0,0,0]
    var body: some View {
        VStack(spacing:0){
            
            
            
            topNavBar()
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                
                let leftValue : CGFloat = (2.3 / (widht / (widht - 390)))
                let value : CGFloat = 2.3 + (leftValue < -5 ? 0 : leftValue)
                
                let maxHeight : CGFloat = (height + (180 - 65) * (value + 1))
                
                
                VStack{
                    
                    
                    Text("Wallet")
                        .font(.system(size: 70, weight: .black))
                        .foregroundColor(.black)
                        .frame(height:getScrrenBounds().height / 4)
                    
                    
                    wallet(content: {
                        
                        
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            
                            
                            Text("Carry\nonething.\nEverything.")
                                .font(.system(size: 50, weight: .bold))
                                .padding(.leading,15)
                            
                            Text("The Wallet app lives right on your iPhone. It’s where you securely keep your credit and debit cards, driver’s license or state ID, transit cards, event tickets, keys, and more — all in one place. And it all works with iPhone or Apple Watch, so you can take less with you but always bring more.")
                                .font(.title.weight(.semibold))
                                .frame(height:400,alignment: .top)
                                .padding(15)
                            
                            
                            sampleCard(color: Color("Green"))
                            sampleCard(color: Color("Yellow"),index: 1)
                            sampleCard(color: Color("Green"),index: 2)
                            sampleCard(color: Color("Orange"),index: 3)
                            
                         
                        }
                        .frame(maxWidth:.infinity,alignment: .leading)
                        
                        
                    })
                       
                    
                }
                .frame(maxWidth:.infinity)
                .mask({
                    
                    Rectangle()
                        .padding(.horizontal,-offset > (maxHeight + (widht < 390 ? 8 : 4)) ? 15 : 0)
                })
                .modifier(OffsetModifier(coordinateSpace: "SCROLL", rect: { rect in
                    
                    self.offset = (rect.minY < 0 ? rect.minY : 0)
                    
                    
                    if widht == 1{
                        
                        self.widht = rect.width
                    }
                    
                
                    
                    
                }))
                .padding(.bottom,getScrrenBounds().width)
                
                
            }
            .coordinateSpace(name: "SCROLL")
            
            
            
        }
        .background(Color("BG"))
        
    }
    @ViewBuilder
    func topNavBar()->some View{
        
        
        HStack{
            
            
            Button {
                
            } label: {
                
                
                Image(systemName: "chevron.left")
                    
            }
            
            Spacer()
            
            Button {
                
            } label: {
                
                
                Image(systemName: "bag.fill")
                    
            }

        }
        .font(.system(size: 20, weight: .bold))
        .padding()
        .overlay(Image(systemName: "applelogo").font(.title))
        .foregroundColor(.white)
        .background(Color("TopBar"))
        
        
    }
    
    @ViewBuilder
    func wallet<Content : View>(@ViewBuilder content : @escaping()->Content)->some View{
        
   
        
        let leftValue : CGFloat = (2.3 / (widht / (widht - 390)))
        let value : CGFloat = 2.3 + (leftValue < -5 ? 0 : leftValue)
        
        let scale : CGFloat = -(offset / 200) < value ? (offset / 200) : -(value + (widht > 390 ? 0.1 : 0.001))
        
        
        let scaleOffset : CGFloat = (offset + (200 * value))
        
        let maxHeight : CGFloat = (height + (180 - 65) * (value + 1))
        
        
        let exhaustHeight : CGFloat = -(200 * value)
        
        
        VStack{
        GeometryReader{proxy in
            
            
            
            ZStack{
                RoundedRectangle(cornerRadius: 35, style: .continuous)
                    .offset(y: -scale > value ? -scaleOffset / 6 : 0)
                
                RoundedRectangle(cornerRadius: 35, style: .continuous)
                    .fill(Color("BG"))
                    .padding(.vertical,35)
                    .padding(.horizontal,25)
                    .offset(y: -scale > value ? -scaleOffset / 10 : 0)
                
                
                ZStack{
                    
                    watchCard(color: Color("Blue"), hPadding: 35, Vpadding: 45)
                    watchCard(color: Color("Green"), hPadding: 35, Vpadding: 55,index:1)
                    watchCard(color: Color("Yellow"), hPadding: 35, Vpadding: 65,index : 2)
                    watchCard(color: Color("Orange"), hPadding: 35, Vpadding: 75,index:3)
                   
                    Rectangle()
                        .fill(Color("BG"))
                        .padding(.horizontal,35)
                        .padding(.vertical,65)
                        .offset(y: 20)
                    
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .fill(Color("Orange"))
                        .frame(width: 45, height: 45)
                        .offset(y: -10)
                    
                }
            }
            .onAppear {
                self.height -= proxy.frame(in: .global).minY
            }
            
            
        }
        .frame(width: 190, height: 180)
        .scaleEffect(1 - scale)
      
        .offset(y: -offset)
        .offset(y: -offset < maxHeight ? (-scale > value ? -scaleOffset : 0) : maxHeight + exhaustHeight)
        .zIndex(100)
        
        content()
            .padding(.top,maxHeight)
        
        
    }
        
        
    }
    
    @ViewBuilder
    func watchCard(color : Color,hPadding : CGFloat,Vpadding : CGFloat,index : Int = 0)->some View{
        
        GeometryReader{proxy in
            
            let minY = proxy.frame(in: .named("SCROLL")).minY - 20
            let paddleWidth  = proxy.frame(in: .named("SCROLL")).width
            
            let scale = paddleWidth / widht
            
            let leftValue : CGFloat = (2.3 / (widht / (widht - 390)))
            let value : CGFloat = 2.3 + (leftValue < -5 ? 0 : leftValue)
            
            let maxHeight : CGFloat = (height + (180 - 65) * (value + 1))
            
            RoundedRectangle(cornerRadius: -offset > maxHeight ? 15 : 8, style: .continuous)
                .fill(color)
                .opacity(cardOffset[index] < minY ? 0 : 1)
                .scaleEffect(-offset > maxHeight ? scale : 1)
              
            
            
        }
        .padding(.vertical,Vpadding)
        .padding(.horizontal,hPadding)
    
        
        
    }
    
    @ViewBuilder
    func sampleCard(color : Color,index : Int = 0) -> some View{
        
        
        GeometryReader{proxy in
            
            
            
            Text("Travel\nYoure Even more\nMobile Device")
                .font(.system(size: 38, weight: .bold))
                .padding(.bottom,20)
                .padding(.horizontal,15)
                .padding(.top,20)
                .frame(maxWidth:.infinity,alignment: .leading)
                .modifier(OffsetModifier(coordinateSpace: "SCROLL", rect: { rect in
                    
                    
                    cardOffset[index] = rect.minY
                }))
                
        }
        
        .frame(height:250,alignment: .top)
        .background(color,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal,15)
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    
    func getScrrenBounds() -> CGRect{
        
        return UIScreen.main.bounds
        
        
    }
}
