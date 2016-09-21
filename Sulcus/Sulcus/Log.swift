//
//  LOG.swift
//  Sulcus
//
//  Created by Wellington Moreno on 8/27/16.
//  Copyright © 2016 RedRoma, Inc. All rights reserved.
//


import Foundation

/**
    The Sulcus Logger class.
 
    The logger will print messages by default. To programmatically disable the Logger,
    change `Log.level`.
 */
public class LOG
{
    
    private init()
    {
        
    }
    
    /**
        Represents the level of log statements.
     */
    public enum LogLevel: Int
    {
        /** Useful for messages that assist with debugging*/
        case debug = 1
        /** Verboce information on normal application activity*/
        case info = 2
        /** Warns of a situation or condition that needs attention, but is not show-stopping. */
        case warn = 3
        /** Warns of a situation that impacted the user's experience. */
        case error = 4
    }
    
    /**
        This is the level enabled in the Logger.
        It can be changed to [debug, info, warn, error]
     */
    public static var level = LogLevel.info
    
    
    /**
        The Sulcus logger will only print messages if this flag is enabled.
     */
    #if DEBUG
        private static var debugEnabled = true
    #else
        private static var debugEnabled = false
    #endif
    
    /**
        Enables the Logger
     */
    public static func enable()
    {
        LOG.debugEnabled = true
    }
    
    /**
        Disables the Logger.
     */
    public static func disable()
    {
        LOG.debugEnabled = false
    }
    
    /**
        Check whether the Logger is enabled.
     */
    public static var isEnabled: Bool
    {
        return LOG.debugEnabled
    }
}

extension LOG
{

    /**
        Prints a Debug message.
     
        - Parameter message : The message to print
     */
    public static func debug(_ message: String, function: String = #function)
    {
        if canPrint(level: .debug)
        {
            let now = dateToString(date: Date())
            blue("\(now) - [DEBUG] - \(function) - \(message)")
        }

    }
    
    /**
        Prints an Info message.
     
        - Parameter message: The message to print
     */
    public static func info(_ message: String, function: String = #function)
    {
        if canPrint(level: .info)
        {
            let now = dateToString(date: Date())
            green("\(now) - [INFO] - \(function) - \(message)")
        }
    }
    
    /**
        Prints a Warn message.
     
        - Parameter message: The message to print
     */
    public static func warn(_ message: String, function: String = #function)
    {
        if canPrint(level: .warn)
        {
            let now = dateToString(date: Date())
            orange("\(now) - [WARN] - \(function) - \(message)")
        }
    }
    
    /**
        Prints an Error message.
     
        - Parameter message: The message to print
     */
    public static func error(_ message: String, function: String = #function)
    {
        if canPrint(level: .warn)
        {
            let now = dateToString(date: Date())
            red("\(now) - [ERROR] - \(function) - \(message)")
        }
    }
}

private extension LOG
{
    
    static func dateToString(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd HH:MM:ss.sss"
        return formatter.string(from: date)
    }
    
    static func canPrint(level: LogLevel) -> Bool
    {
        return (level.rawValue >= self.level.rawValue) && isEnabled
    }
    
}

private extension LOG
{
    
    private static let ESCAPE = "\u{001b}["
    
    private static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    private static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    private static let RESET = ESCAPE + ";"   // Clear any foreground or background color

    
    static func red<T>(_ object: T)
    {
        print("\(ESCAPE)fg255,0,0;\(object)\(RESET)")
    }
    
    static func green<T>(_ object: T)
    {
        print("\(ESCAPE)fg0,255,0;\(object)\(RESET)")
    }
    
    static func blue<T>(_ object: T)
    {
        print("\(ESCAPE)fg0,0,255;\(object)\(RESET)")
    }
    
    static func yellow<T>(_ object: T)
    {
        print("\(ESCAPE)fg255,255,0;\(object)\(RESET)")
    }
    
    static func purple<T>(_ object: T)
    {
        print("\(ESCAPE)fg255,0,255;\(object)\(RESET)")
    }
    
    static func cyan<T>(_ object: T)
    {
        print("\(ESCAPE)fg0,255,255;\(object)\(RESET)")
    }
    
    static func orange<T>(_ object: T)
    {
        print("\(ESCAPE)fg255,127,0;\(object)\(RESET)")
    }
}
