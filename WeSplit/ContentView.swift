//
//  ContentView.swift
//  WeSplit
//
//  Created by Nkululeko Jonas on 10/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var tipPercentage = 0
    @State private var numberOfPeople = 0
    
    @FocusState private var amountIsFocus: Bool
    
    private let tipPercentages = [1..<101]
    private var userLocation = Locale.current.currency?.identifier ?? "USD"
    
    private var checkTotal: Double {
        checkAmount + (checkAmount / 100 * Double(tipPercentage))
    }
    
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipValue = (checkAmount / 100) * Double(tipPercentage)

        return (checkAmount + tipValue) / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "AUD"))
                        .keyboardType( .decimalPad)
                        .focused($amountIsFocus)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<99) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.wheel)
                } header: {
                    Text("How much would you like to tip:")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: userLocation))
                } footer: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(checkTotal, format: .currency(code: userLocation))
                } footer: {
                    Text("Total including tip.")
                }

            }
            .navigationTitle("We.Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
