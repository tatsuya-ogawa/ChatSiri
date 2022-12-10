//
//  ContentView.swift
//  ChatSiri
//
//  Created by Tatsuya Ogawa on 2022/12/06.
//

import SwiftUI
import Speech

struct ContentView: View {
    @State var recognizedText: String?
        @State var message: String = ""
        private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))

    var body: some View {
        SpeechView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
