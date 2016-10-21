//
//  ComplicationController.swift
//  MyComplication WatchKit Extension
//
//  Created by Derek Jensen on 10/21/16.
//  Copyright © 2016 Derek Jensen. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    let timeLineText = ["Grab some Breakfast", "Drive to Work", "Meet with Boss", "Get a big Raise!"]
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        
        let currentDate = Date()
        
        handler(currentDate)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        
        let currentDate = Date()
        let endDate = currentDate.addingTimeInterval(4 * 60 * 60)
        
        handler(endDate)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        
        let timeString = dateFormatter.string(from: Date())
        let entry = createTimeEntry(headerText: timeString, bodyText: timeLineText[0], date: Date())
        
        handler(entry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        
        var timeLineEntryArray = [CLKComplicationTimelineEntry]()
        var nextDate = Date(timeIntervalSinceNow: 1 * 60 * 60)
        
        for index in 1...3 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            
            let timeString = dateFormatter.string(from: nextDate)
            let entry = createTimeEntry(headerText: timeString, bodyText: timeLineText[index], date: nextDate)
            
            timeLineEntryArray.append(entry)
            
            nextDate = nextDate.addingTimeInterval(1 * 60 * 60)
        }
        
        
        handler(timeLineEntryArray)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
    
    func createTimeEntry(headerText: String, bodyText: String, date: Date) -> CLKComplicationTimelineEntry {
        let template = CLKComplicationTemplateModularLargeStandardBody()
        template.headerTextProvider = CLKSimpleTextProvider(text: headerText)
        template.body1TextProvider = CLKSimpleTextProvider(text: bodyText)
        
        let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
        
        return entry
    }
    
    
    
    
    
    
}
