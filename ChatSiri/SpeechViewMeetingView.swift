import SwiftUI
import AVFoundation

struct SpeechView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    var speechSynthesizer = SpeechSynthesizer()
    @State private var isRecording = false
    @State private var transcript = ""
    
    func start(){
        speechRecognizer.reset()
        speechRecognizer.transcribe()
        isRecording = true
    }
    func stop(){
        speechRecognizer.stopTranscribing()
        isRecording = false
        transcript = speechRecognizer.transcript
    }
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: true) {
                Text(transcript)
            }
            .frame(maxWidth: .infinity, maxHeight: 240.0)
            .background(Color.white)
            Spacer()
            Button (action:{
                start()
            }){
                Text("Start")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 64)
                    .padding(.horizontal, 32)
            }.background(Color.blue)
            Spacer().frame(height:16)
            if(transcript != ""){
                Button (action:{
                    speechSynthesizer.text2speech(transcript)
                }){
                    Text("Speech")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, minHeight: 64)
                        .padding(.horizontal, 32)
                }.background(Color.green)
                Spacer().frame(height:16)
            }
            Button (action:{
                stop()
            }){
                Text("Stop")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 64)
                    .padding(.horizontal, 32)
            }.background(Color.red)
            Spacer().frame(height:32)
        }
        .onAppear {
            //            start()
            guard let fileURL = Bundle.main.url(forResource: "sample", withExtension: "txt"),
                  let fileContents = try? String(contentsOf: fileURL, encoding: .utf8) else {
                fatalError("読み込み出来ません")
            }
            transcript = fileContents
        }
        .onDisappear {
            //            stop()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct SpeechView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechView()
    }
}
