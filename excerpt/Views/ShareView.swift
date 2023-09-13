//
//  ShareView.swift
//  excerpt
//
//  Created by Richard on 2023/9/13.
//

import SwiftUI

func round(_ value: Double, toNearest: Double) -> Double {
    return round(value / toNearest) * toNearest
}

struct Card: View {
    var excerpt: Excerpt
    var width: CGFloat

    private let fontName = "SourceHanSerifSC-Regular"
    private let fontSizeContent: CGFloat = 18
    private let fontSizeFrom: CGFloat = 15
    private let colorBackground = Color("F9F9FB")!
    private let colorContent = Color("272220")!
    private let colorFrom = Color("514A48")!
    private let colorBorder = Color("D0CDCF")!

    private let rectOuterPadding: CGFloat = 15

    private var rectInnerWidth: CGFloat {
        self.width - self.rectOuterPadding * 2
    }

    private var contentWidth: CGFloat {
        round(self.rectInnerWidth - self.fontSizeContent * 4, toNearest: self.fontSizeContent)
    }

    private var contentVertOuterPadding: CGFloat {
        (self.rectInnerWidth - self.contentWidth) / 2
    }

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(self.excerpt.content)
                        .font(.custom(self.fontName, size: self.fontSizeContent))
                        .foregroundColor(self.colorContent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, self.fontSizeContent)

                    if !self.excerpt.author.isEmpty {
                        Text("— \(self.excerpt.author)")
                            .font(.custom(self.fontName, size: self.fontSizeFrom))
                            .foregroundColor(self.colorFrom)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .multilineTextAlignment(.trailing)
                    }
                    if !self.excerpt.book.isEmpty {
                        Text(self.excerpt.book)
                            .font(.custom(self.fontName, size: self.fontSizeFrom))
                            .foregroundColor(self.colorFrom)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding([.leading, .trailing], self.contentVertOuterPadding)
                .padding([.top, .bottom], self.contentVertOuterPadding * 1.6)
                .border(self.colorBorder, width: 0.7)
                .overlay {
                    Rectangle()
                        .fill(Color.clear)
                        .border(self.colorBorder, width: 0.5)
                        .padding(2)
                }
            }
            .padding(self.rectOuterPadding)
        }
        .background(self.colorBackground)
    }
}

struct ShareView: View {
    @Binding var isPresented: Bool

    var excerpt: Excerpt

    func dismiss() {
        self.isPresented = false
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    Card(excerpt: self.excerpt, width: geometry.size.width - 15 * 2)
                        .padding(15)
                        .frame(width: geometry.size.width)
                        .frame(minHeight: geometry.size.height)
                }
                .onTapGesture {
                    self.dismiss()
                }

//                HStack {
//                    Text("Btn1")
//                        .background(Color.purple)
//
//                    Text("Btn2")
//                        .background(Color.yellow)
//                }
//                .frame(width: geometry.size.width, height: 40)
//                .background(Color.green)
            }
            .padding(0)
        }
    }
}

#Preview("Share Dark") {
    MainView(excerpts[0], sharing: true)
        .environment(\.locale, .init(identifier: "zh-Hans"))
        .preferredColorScheme(.dark)
}

#Preview("Share Short Light") {
    MainView(Excerpt(id: UUID(), content: "你好。", book: "一本书", author: "谁"), sharing: true)
        .environment(\.locale, .init(identifier: "zh-Hans"))
}

#Preview("Share Long") {
    MainView(Excerpt(id: UUID(), content: excerpts[0].content + "\n" + excerpts[0].content + "\n" + excerpts[0].content, book: "这是一本名字超长的书：甚至还有副标题", author: "名字超长的作者·甚至还有 Last Name·以及更多"), sharing: true)
        .environment(\.locale, .init(identifier: "zh-Hans"))
}

#Preview("Share English") {
    MainView(Excerpt(id: UUID(), content: "Do not feel envious of the happiness of those who live in a fool's paradise, for only a fool will think that it is happiness.", book: "The Ten Commandments", author: "Bertrand Russell"), sharing: true)
        .environment(\.locale, .init(identifier: "en"))
}
