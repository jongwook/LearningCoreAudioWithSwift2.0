//
//  main.swift
//  CAMetadata
//
//  Created by Ales Tsurko on 23.08.15.
//

import Foundation
import AudioToolbox

func main() {
    let argc = CommandLine.argc
    let argv = CommandLine.arguments
    
    guard argc > 1 else {
        print("Usage: \(argv[0]) /full/path/to/audiofile\n")
        return
    }
    
    let audiofilePath = NSString(string: argv[1]).expandingTildeInPath
    let audioURL = NSURL(fileURLWithPath: audiofilePath)
    var audiofile: AudioFileID? = nil
    var theErr = noErr
    
    theErr = AudioFileOpenURL(audioURL, AudioFilePermissions.readPermission, 0, &audiofile)
    
    assert(theErr == noErr)
    
    var dictionarySize: UInt32 = 0
    var isWritable: UInt32 = 0
    theErr = AudioFileGetPropertyInfo(audiofile!, kAudioFilePropertyInfoDictionary, &dictionarySize, &isWritable)
    
    assert(theErr == noErr)
    
    print("dictionarySize: \(dictionarySize)")
    print("isWritable: \(isWritable)")
    
    var dictionary: CFDictionary? = nil
    theErr = AudioFileGetProperty(audiofile!, kAudioFilePropertyInfoDictionary, &dictionarySize, &dictionary)
    assert(theErr == noErr)
    
    let dict = dictionary! as NSDictionary
    print("dictionary: \(dict)")
    
    theErr = AudioFileClose(audiofile!)
    
    assert(theErr == noErr)
}

main()
