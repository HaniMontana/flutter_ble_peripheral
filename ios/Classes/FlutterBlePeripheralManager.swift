/*
 * Copyright (c) 2020. Julian Steenbakker.
 * All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */


import Foundation
import CoreBluetooth
import CoreLocation

class FlutterBlePeripheralManager : NSObject {
    
    let stateChangedHandler: StateChangedHandler
    
    init(stateChangedHandler: StateChangedHandler) {
        self.stateChangedHandler = stateChangedHandler
    }
    
    lazy var peripheralManager: CBPeripheralManager  = CBPeripheralManager(delegate: self, queue: nil)
//    var peripheralData: NSDictionary!

    // min MTU before iOS 10
//    var mtu: Int = 158 {
//        didSet {
//          onMtuChanged?(mtu)
//        }
//    }
    
//    var dataToBeAdvertised: [String: Any]!
//
//    var txCharacteristic: CBMutableCharacteristic?
//    var txSubscribed = false {
//        didSet {
//            if txSubscribed {
//                state = .connected
//            } else if isAdvertising() {
//                state = .advertising
//            }
//        }
//    }
//    var rxCharacteristic: CBMutableCharacteristic?
//
//    var txSubscriptions = Set<UUID>()
    
    func start(advertiseData: PeripheralData) {
        
        peripheralManager.removeAllServices()

        var staticUUID = ("7ea44a84-3815-11ec-8d3d-AAAAAAAAAAAA")

        var dataToBeAdvertised: [String: Any]! = [:]
        if (advertiseData.uuid != nil) {

           // dataToBeAdvertised[CBAdvertisementDataServiceUUIDsKey] = [CBUUID(string: advertiseData.uuid!)]
           dataToBeAdvertised[CBAdvertisementDataServiceUUIDsKey] = [CBUUID(string: staticUUID)]
        }
        
        if (advertiseData.localName != nil) {
            dataToBeAdvertised[CBAdvertisementDataLocalNameKey] = advertiseData.localName
        }

        //Next 3 lines created by Hani for adding UUID into service data
        let transferService = CBMutableService(type: CBUUID(string: advertiseData.uuid!), primary: true)
        peripheralManager.removeAllServices();
        
        peripheralManager.add(transferService)
        
        peripheralManager.startAdvertising(dataToBeAdvertised)
        
//         TODO: Add service to advertise
//        if peripheralManager.state == .poweredOn {
//            addService()
//        }
    }
    
// TODO: Add service to advertise
//    private func addService() {
//        // Add service and characteristics if needed
//        if txCharacteristic == nil || rxCharacteristic == nil {
//
//            let mutableTxCharacteristic = CBMutableCharacteristic(type: CBUUID(string: PeripheralData.txCharacteristicUUID), properties: [.read, .write, .notify], value: nil, permissions: [.readable, .writeable])
//            let mutableRxCharacteristic = CBMutableCharacteristic(type: CBUUID(string: PeripheralData.rxCharacteristicUUID), properties: [.read, .write, .notify], value: nil, permissions: [.readable, .writeable])
//
//            let service = CBMutableService(type: CBUUID(string: PeripheralData.serviceUUID), primary: true)
//            service.characteristics = [mutableTxCharacteristic, mutableRxCharacteristic];
//
//            peripheralManager.add(service)
//
//            self.txCharacteristic = mutableTxCharacteristic
//            self.rxCharacteristic = mutableRxCharacteristic
//        }
//
//        peripheralManager.startAdvertising(dataToBeAdvertised)
//    }
//
//    func send(data: Data) {
//
//        print("[flutter_ble_peripheral] Send data: \(data)")
//
//        guard let characteristic = txCharacteristic else {
//            return
//        }
//
//        peripheralManager.updateValue(data, for: characteristic, onSubscribedCentrals: nil)
//    }
}
