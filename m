Return-Path: <cyrus@holtmann.org>
Message-ID: <58517.86.105.94.79.1414160561.squirrel@boosthardware.com>
Date: Sat, 25 Oct 2014 01:22:41 +1100 (EST)
Subject: [bluetooth] btusb duplicate filtering
From: "Patrick Shirkey" <pshirkey@boosthardware.com>
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am seeing the following behaviour with an android device running the
8723au chipset with bluez + backports + btusb.c (new branch).

Step 1:

1: enable BT via settings UI
2: open BLE scanner app
3: app finds all BLE devices

Step 2:

4: close BLE scanner app
5: open BLE scanner app
6: app cannot find any BLE device


- Szymon has suggested it is related to duplicate filtering and may be
handled at the driver or chipset firmware level.

- I found this post which might provide some useful background info.

http://stackoverflow.com/questions/19502853/android-4-3-ble-filtering-behaviour-of-startlescan

- My question is can I do anything at the driver/kernel/bluez level so
that BLE devices always show up?


LOGS

- I see the following output in logcat:

Step 1:


10-24 07:06:27.450 D/TAG     (13289): ~ Starting Scan
10-24 07:06:27.450 D/BluetoothAdapter(13289): startLeScan(): null
10-24 07:06:27.450 D/BtGatt.GattService(13351): registerClient() -
UUID=3ed977cb-dddb-4518-af26-eb41adb97c38
10-24 07:06:27.450 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/gatt.c:handle_client_register()
10-24 07:06:27.460 D/BtGatt.GattService(13351): onClientRegistered() -
UUID=3ed977cb-dddb-4518-af26-eb41adb97c38, clientIf=1
10-24 07:06:27.460 D/BluetoothAdapter(13289): onClientRegistered() -
status=0 clientIf=1
10-24 07:06:27.460 D/BtGatt.GattService(13351): startScan() - queue=0
10-24 07:06:27.460 D/BtGatt.GattService(13351): startScan() - adding client=1
10-24 07:06:27.470 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/gatt.c:handle_client_scan() new state 1
10-24 07:06:27.470 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:start_discovery() type=0x6
10-24 07:06:27.470 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_discovering_event() type
6 discovering 1
10-24 07:06:27.480 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:check_discovery_state() 6 0
10-24 07:06:27.510 W/InputMethodManagerService( 1612): Window already
focused, ignoring focus gain of:
com.android.internal.view.IInputMethodClient$Stub$Proxy@41a51080
attribute=null, token = android.os.BinderProxy@41aa49c0
10-24 07:06:27.530 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_device_found_event()
hci0 addr BC:6A:29:AB:2C:AA, rssi -36 flags 0x0000 eir_len 25
10-24 07:06:27.530 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/gatt.c:le_device_found_handler() LE
Device found: BC:6A:29:AB:2C:AA, rssi: -36, adv_data: 1
10-24 07:06:27.540 D/BlueZ   (13351):
external/bluetooth/bluez/android/hal-bluetooth.c:handle_device_found()
10-24 07:06:27.550 D/BlueZ   (13351):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[0]: type=BT_PROPERTY_BDADDR len=6 val=bc:6a:29:ab:2c:aa
10-24 07:06:27.550 D/BlueZ   (13351):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[1]: type=BT_PROPERTY_TYPE_OF_DEVICE len=4 val=BT_DEVICE_DEVTYPE_BLE
10-24 07:06:27.550 D/BlueZ   (13351):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[2]: type=BT_PROPERTY_REMOTE_RSSI len=4 val=220
10-24 07:06:27.550 D/BlueZ   (13351):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[3]: type=BT_PROPERTY_BDNAME len=17 val=BC:6A:29:AB:2C:AA
10-24 07:06:27.580 D/BtGatt.GattService(13351): onScanResult() -
address=BC:6A:29:AB:2C:AA, rssi=-36
10-24 07:06:27.580 D/BluetoothAdapter(13289): onScanResult() -
Device=BC:6A:29:AB:2C:AA RSSI=-36
10-24 07:06:27.690 D/BluetoothEventManager( 1767): DeviceFoundHandler
created new CachedBluetoothDevice: BC:6A:29:AB:2C:AA
10-24 07:06:27.730 D/android.widget.GridLayout(13289): horizontal
constraints: x2-x0>=376, x2-x1<=187, x1-x0<=81 are inconsistent;
permanently removing: x2-x1<=187.
10-24 07:06:37.720 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_device_found_event()
hci0 addr BC:6A:29:AB:2D:17, rssi -48 flags 0x0000 eir_len 25
10-24 07:06:37.720 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/gatt.c:le_device_found_handler() LE
Device found: BC:6A:29:AB:2D:17, rssi: -48, adv_data: 1
10-24 07:06:37.730 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_discovering_event() type
6 discovering 0
10-24 07:06:37.730 D/BlueZ   (13351):
external/bluetooth/bluez/android/hal-bluetooth.c:handle_device_found()
10-24 07:06:37.730 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:check_discovery_state() 0 6
10-24 07:06:37.730 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:start_discovery() type=0x6
10-24 07:06:37.740 D/BlueZ   (13351):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[0]: type=BT_PROPERTY_BDADDR len=6 val=bc:6a:29:ab:2d:17
10-24 07:06:37.740 D/BlueZ   (13351):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[1]: type=BT_PROPERTY_TYPE_OF_DEVICE len=4 val=BT_DEVICE_DEVTYPE_BLE
10-24 07:06:37.740 D/BlueZ   (13351):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[2]: type=BT_PROPERTY_REMOTE_RSSI len=4 val=208
10-24 07:06:37.740 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_discovering_event() type
6 discovering 1
10-24 07:06:37.740 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:check_discovery_state() 6 0
10-24 07:06:37.750 D/BlueZ   (13351):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[3]: type=BT_PROPERTY_BDNAME len=17 val=BC:6A:29:AB:2D:17
10-24 07:06:37.770 D/BtGatt.GattService(13351): onScanResult() -
address=BC:6A:29:AB:2D:17, rssi=-48
10-24 07:06:37.780 D/BluetoothAdapter(13289): onScanResult() -
Device=BC:6A:29:AB:2D:17 RSSI=-48
10-24 07:06:37.870 D/android.widget.GridLayout(13289): horizontal
constraints: x2-x0>=376, x2-x1<=187, x1-x0<=81 are inconsistent;
permanently removing: x2-x1<=187.
10-24 07:06:37.870 D/BluetoothEventManager( 1767): DeviceFoundHandler
created new CachedBluetoothDevice: BC:6A:29:AB:2D:17



Step 2:



10-24 07:15:09.150 D/TAG     (13289): ~ Starting Scan
10-24 07:15:09.150 D/BluetoothAdapter(13289): startLeScan(): null
10-24 07:15:09.170 D/BtGatt.GattService(13351): registerClient() -
UUID=e423968e-1bfe-4822-a62b-83804fb6998d
10-24 07:15:09.170 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/gatt.c:handle_client_register()
10-24 07:15:09.170 D/BtGatt.GattService(13351): onClientRegistered() -
UUID=e423968e-1bfe-4822-a62b-83804fb6998d, clientIf=2
10-24 07:15:09.170 D/BluetoothAdapter(13289): onClientRegistered() -
status=0 clientIf=2
10-24 07:15:09.170 D/BtGatt.GattService(13351): startScan() - queue=0
10-24 07:15:09.180 D/BtGatt.GattService(13351): startScan() - adding client=2
10-24 07:15:09.180 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/gatt.c:handle_client_scan() new state 1
10-24 07:15:09.180 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:start_discovery() type=0x6
10-24 07:15:09.190 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_discovering_event() type
6 discovering 1
10-24 07:15:09.190 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:check_discovery_state() 6 0
10-24 07:15:09.250 W/InputMethodManagerService( 1612): Window already
focused, ignoring focus gain of:
com.android.internal.view.IInputMethodClient$Stub$Proxy@41b85ab8
attribute=null, token = android.os.BinderProxy@41afac00
10-24 07:15:19.440 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_discovering_event() type
6 discovering 0
10-24 07:15:19.440 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:check_discovery_state() 0 6
10-24 07:15:19.450 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:start_discovery() type=0x6
10-24 07:15:19.460 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:mgmt_discovering_event() type
6 discovering 1
10-24 07:15:19.460 I/bluetoothd(13365): bluetoothd[13366]:
external/bluetooth/bluez/android/bluetooth.c:check_discovery_state() 6 0


- I see the following output in btmon:

Step 1:

# btmon
Bluetooth monitor ver 5.23
= New Index: CC:D2:9C:73:CB:45 (BR/EDR,USB,hci0)                [hci0]
0.921673
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2          [hci0]
6.885250
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                     [hci0]
6.886777
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x00 (6)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6       [hci0]
6.891384
        Address: 33:31:38:D9:1B:2E (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                     [hci0]
6.892774
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7      [hci0]
6.892944
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                     [hci0]
6.894777
      LE Set Scan Parameters (0x08|0x000b) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2          [hci0]
6.895268
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                     [hci0]
6.896768
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x01 (6)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
17.165233
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
17.166804
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x00 (6)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0]
17.172436
        Address: 30:D0:1B:39:11:67 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
17.173779
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
17.173957
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
17.175784
      LE Set Scan Parameters (0x08|0x000b) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
17.175969
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
17.182437
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x01 (6)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
27.445182
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
27.446769
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x00 (6)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0]
27.452355
        Address: 1F:D8:B6:3C:C6:59 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
27.453758
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
27.453928
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
27.461737
      LE Set Scan Parameters (0x08|0x000b) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
27.462099
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
27.464075
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x01 (6)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
37.725179
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
37.726766
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x00 (6)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0]
37.732082
        Address: 26:B7:AE:E6:75:57 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
37.733782
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
37.734090
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
37.735758
      LE Set Scan Parameters (0x08|0x000b) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
37.735871
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
37.736753
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x01 (6)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
48.005204
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
48.006786
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x00 (6)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0]
48.016702
        Address: 06:D6:55:3D:29:5F (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
48.017777
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
48.018674
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
48.019771
      LE Set Scan Parameters (0x08|0x000b) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
48.019967
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
48.021775
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x01 (6)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
58.290259
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
58.291852
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x00 (6)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0]
58.297162
        Address: 06:E6:71:FF:BA:41 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
58.298778
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
58.299040
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
58.300779
      LE Set Scan Parameters (0x08|0x000b) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
58.301042
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
58.302784
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x01 (6)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
68.565182
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
68.566772
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x00 (6)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0]
68.573095
        Address: 25:42:7A:0D:BF:7D (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
68.574788
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
68.575193
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
68.576785
      LE Set Scan Parameters (0x08|0x000b) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
68.577027
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
68.584697
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x01 (6)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
78.845191
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
78.846780
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x00 (6)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0]
78.853717
        Address: 3A:B8:26:AA:9B:12 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
78.854825
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
78.856067
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
78.857777
      LE Set Scan Parameters (0x08|0x000b) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
78.859335
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
78.864484
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x01 (6)


///  Step 2:


< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      [hci0]
99.375289
        Address: 25:61:0F:37:30:99 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
99.378071
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
99.379701
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
99.380778
      LE Set Scan Parameters (0x08|0x000b) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
99.380939
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
99.382768
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x01 (6)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        [hci0]
109.645175
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0]
109.646778
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x00 (6)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6     [hci0]
109.652523
        Address: 3F:4D:C3:01:6A:72 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0]
109.653782
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7    [hci0]
109.654052
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0]
109.655774
      LE Set Scan Parameters (0x08|0x000b) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        [hci0]
109.656344
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0]
109.657769
      LE Set Scan Enable (0x08|0x000c) ncmd 2
        Status: Success (0x00)
@ Discovering: 0x01 (6)




--
Patrick Shirkey
Boost Hardware Ltd
