Return-Path: <cyrus@holtmann.org>
Message-ID: <59573.86.105.94.79.1414530902.squirrel@boosthardware.com>
In-Reply-To: <90788656-5735-477F-BDAD-005F7D35A241@holtmann.org>
References: <58517.86.105.94.79.1414160561.squirrel@boosthardware.com>
    <90788656-5735-477F-BDAD-005F7D35A241@holtmann.org>
Date: Wed, 29 Oct 2014 08:15:02 +1100 (EST)
Subject: Re: [bluetooth] btusb duplicate filtering
From: "Patrick Shirkey" <pshirkey@boosthardware.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>


On Wed, October 29, 2014 4:20 am, Marcel Holtmann wrote:
> Hi Patrick,
>
>> I am seeing the following behaviour with an android device running the
>> 8723au chipset with bluez + backports + btusb.c (new branch).
>>
>> Step 1:
>>
>> 1: enable BT via settings UI
>> 2: open BLE scanner app
>> 3: app finds all BLE devices
>>
>> Step 2:
>>
>> 4: close BLE scanner app
>> 5: open BLE scanner app
>> 6: app cannot find any BLE device
>>
>>
>> - Szymon has suggested it is related to duplicate filtering and may be
>> handled at the driver or chipset firmware level.
>>
>> - I found this post which might provide some useful background info.
>>
>> http://stackoverflow.com/questions/19502853/android-4-3-ble-filtering-behaviour-of-startlescan
>>
>> - My question is can I do anything at the driver/kernel/bluez level so
>> that BLE devices always show up?
>
> so we are always using the duplicate filtering of the controller. Not
> using it will cause an overflow of advertising reports in a busy
> environment.
>
> The difference between certain manufactures is that some filter strictly
> only on address, other filter on address + RSSI. Meaning that if the RSSI
> changes you get another event. What I know is that Broadcom is in the
> first camp and CSR/TI are in the second camp.
>
> This means that if you care about devices found on a constant basis and
> depend on the RSSI changing, you need to stop and restart the LE scan for
> at least Broadcom based controllers. I have no idea in what camp the
> Realtek one falls since I yet have to get one of these.
>

I have an app here that is designed to start a new scan via the android
API every time it checks for available BLE devices. The app runs well on
other devices with different chipsets. The results on the 8723au might be
useful information. I can see BLE devices have been found in the settings
UI but the test app is not getting anything useful from the Android layer.

Example output:

10-28 13:50:46.270 D/BluetoothAdapter(25700): startLeScan(): null
10-28 13:50:46.270 D/BtGatt.GattService(14120): registerClient() -
UUID=623b34f6-592b-4d61-9c7f-d6c124f470d1
10-28 13:50:46.270 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/gatt.c:handle_client_register()
10-28 13:50:46.270 D/BtGatt.GattService(14120): onClientRegistered() -
UUID=623b34f6-592b-4d61-9c7f-d6c124f470d1, clientIf=94
10-28 13:50:46.270 D/BluetoothAdapter(25700): onClientRegistered() -
status=0 clientIf=94
10-28 13:50:46.280 D/BtGatt.GattService(14120): startScan() - queue=0
10-28 13:50:46.280 D/BtGatt.GattService(14120): startScan() - adding
client=94
10-28 13:50:46.280 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/gatt.c:handle_client_scan() new state 1
10-28 13:50:46.280 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/bluetooth.c:start_discovery() type=0x6
10-28 13:50:46.280 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_discovering_event() type
6 discovering 1
10-28 13:50:46.280 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/bluetooth.c:check_discovery_state() 6 0
10-28 13:50:51.290 D/BluetoothAdapter(25700): stopLeScan()
10-28 13:50:51.290 D/BtGatt.GattService(14120): stopScan() - queue=1
10-28 13:50:51.290 D/BtGatt.GattService(14120): stopScan() - queue empty;
stopping scan
10-28 13:50:51.290 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/gatt.c:handle_client_scan() new state 0
10-28 13:50:51.290 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/gatt.c:handle_client_scan() Stopping LE
SCAN
10-28 13:50:51.290 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/bluetooth.c:stop_discovery() type=0x6
10-28 13:50:51.300 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_discovering_event() type
6 discovering 0
10-28 13:50:51.300 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/bluetooth.c:check_discovery_state() 0 6
10-28 13:50:51.300 D/BtGatt.GattService(14120): unregisterClient() -
clientIf=94
10-28 13:50:51.300 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/gatt.c:handle_client_unregister()
10-28 13:50:51.310 D/BluetoothAdapter(25700): startLeScan(): null
10-28 13:50:51.310 D/BtGatt.GattService(14120): registerClient() -
UUID=40001646-6658-4840-bf66-c6ebc5c0c718
10-28 13:50:51.310 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/gatt.c:handle_client_register()
10-28 13:50:51.320 D/BtGatt.GattService(14120): onClientRegistered() -
UUID=40001646-6658-4840-bf66-c6ebc5c0c718, clientIf=95
10-28 13:50:51.320 D/BluetoothAdapter(25700): onClientRegistered() -
status=0 clientIf=95
10-28 13:50:51.320 D/BtGatt.GattService(14120): startScan() - queue=0
10-28 13:50:51.320 D/BtGatt.GattService(14120): startScan() - adding
client=95
10-28 13:50:51.320 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/gatt.c:handle_client_scan() new state 1
10-28 13:50:51.320 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/bluetooth.c:start_discovery() type=0x6
10-28 13:50:51.330 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_discovering_event() type
6 discovering 1
10-28 13:50:51.330 I/bluetoothd(14150): bluetoothd[14151]:
external/bluetooth/bluez/android/bluetooth.c:check_discovery_state() 6 0

etc...

> On an independent thread we are talking about adding a quirk to our
> internal discovery handling to automatically restart scan for the
> controllers that do the strict filtering based on address only.
>

I'll try to follow the thread but feel free to ping me directly if/when
some code appears.




--
Patrick Shirkey
Boost Hardware Ltd
