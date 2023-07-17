//
//  ContentView.swift
//  Temp Calculator
//
//  Created by Arman Akash on 1/14/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var input = 100.0
    
    @State private var selectedUnits = 0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers
    @FocusState private var inputIsFocused : Bool
    
    let conversion = ["Distance","Mass","Temperature","Time"]
    
    let untitTypes = [
        [UnitLength.feet, UnitLength.kilometers, UnitLength.meters, UnitLength.miles, UnitLength.yards],[UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],[UnitTemperature.celsius, UnitTemperature.fahrenheit,  UnitTemperature.kelvin],[UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    
   
    
    let formatter : MeasurementFormatter
    
    var result : String{
        let inputMeasurment = Measurement(value: input, unit: inputUnit)
        
        let outputMeasurment = inputMeasurment.converted(to: outputUnit)
        
        return formatter.string(from: outputMeasurment)
    }
    
    //    let uniteType = [
    //        [UnitLength.feet,UnitLength.kilometers,UnitLength.meters,UnitLength.miles,UnitLength.yards],
    //        [UnitMass.grams,UnitMass.grams,UnitMass.kilograms,UnitMass.ounces,UnitMass.pounds],
    //        [UnitTemperature.celsius,UnitTemperature.fahrenheit,UnitTemperature.kelvin]
    //    ]
    
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } //: Section
            header:{
                Text("Amount to convert")
            }
                Picker("Conversion", selection: $selectedUnits){
                    ForEach(0..<conversion.count, id: \.self){
                        unitItem in
                        Text(conversion[unitItem])
                    }
                }.pickerStyle(.segmented)
                
                Section {
                    Picker("Convert from:",selection: $inputUnit){
                        ForEach(untitTypes[selectedUnits], id: \.self){ item in
                            Text(formatter.string(from: item).capitalized)
                        }
                        
                        
                    }  //: picker
                    
                    Picker("Convert to", selection: $outputUnit){
                        ForEach(untitTypes[selectedUnits], id: \.self){ item in
                            Text(formatter.string(from: item).capitalized)
                        }
                    }
                } //: Section
                
                Section {
                    Text(result)
                } //: Section
            header: {
                Text("Result")
            }
            } //: Form
            .navigationTitle("Converter")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        inputIsFocused = false
                    }
                }
            } .onChange(of: selectedUnits){
                newSelection in
                let units = untitTypes[newSelection]
                inputUnit = units[0]
                outputUnit = units[1]
            }
        } //: NAVIGATIONVIEW
    }
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}
// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
