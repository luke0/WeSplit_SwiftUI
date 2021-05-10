//
//  ContentView.swift
//  WeSplit
//
//  Created by Luke Inger on 22/02/2021.
//

import SwiftUI

struct ContentView: View {

    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2
    
    var tipPercentages = ["10","15","20","25","0"]
    
    var totalCheckAmount:Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection!
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson:Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let amountPerPerson = totalCheckAmount / peopleCount
        
        return amountPerPerson
    }
    
    var tipPercentageValue:Double {
        return Double(tipPercentages[tipPercentage]) ?? 0
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", text:$checkAmount)
                        .keyboardType(.decimalPad)
//                    Picker("Number of people", selection:$numberOfPeople){
//                        ForEach(2..<100){
//                            Text("\($0) people")
//                        }
//                    }
                    TextField("Number of people", text:$numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip percentage", selection:$tipPercentage){
                        ForEach(0..<tipPercentages.count){
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total check amount")){
                    Text("£\(totalCheckAmount)")
                        .foregroundColor(tipPercentageValue==0 ? .red : .black)
                }
                Section(header: Text("Amount per person")){
                    Text("£\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
