Return-Path: <cyrus@holtmann.org>
Message-ID: <0d7093fac6855c30739a0c25ba009bd8.squirrel@iwavesystems.com>
In-Reply-To: <CABBYNZLfwjqL4aPDbVfJMBy88EgLrLZ5YH6gc6YWrdN=023riw@mail.gmail.com>
References: <237bbd312054ce6433af002f5e1213c7.squirrel@iwavesystems.com>
    <cc6ce416e935cb348f250e29710e1830.squirrel@iwavesystems.com>
    <ffcbfaab275d957cf387eb690b6a81ea.squirrel@iwavesystems.com>
    <2859057.ul7JxHffdl@leonov>
    <71b8da83b60d4739a7cf443599cf4b3f.squirrel@iwavesystems.com>
    <228494b5f37cbb0aa440a679c26c6e54.squirrel@iwavesystems.com>
    <CABBYNZLfwjqL4aPDbVfJMBy88EgLrLZ5YH6gc6YWrdN=023riw@mail.gmail.com>
Date: Tue, 22 Sep 2015 06:59:39 -0400
Subject: Re: GATT onWriteCharacteristic() returns status=1 (BT_STATUS_FAIL)
From: krishnaks@iwavesystems.com
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Szymon Janc" <ext.szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi,
>
> On Tue, Sep 22, 2015 at 8:13 AM,  <krishnaks@iwavesystems.com> wrote:
>>>> Hi,
>>>>
>>>> On Monday 21 of September 2015 06:43:20 krishnaks@iwavesystems.com
>>>> wrote:
>>>>> Hi,
>>>>>
>>>>> I am using Bluez 5.33 on Android kitkat 4.4.3.
>>>>> I am testing GATT functionality  and I found that sometime
>>>>> onWriteCharacteristic returns status 1 (BT_STATUS_FAIL). In android
>>>>> Application I am checking for success status (i.e. 0) which I am
>>>>> getting
>>>>> most of the time. But occasionally I am getting Status 1 because of
>>>>> which
>>>>> my application logic is failing.
>>>>>
>>>>> When Bluez will send Status 1 and on what basis? How to avoid this?
>>>>>
>>>>>
>>>>> -----------------------Working Log-------------------------------
>>>>> D/BluetoothGatt( 1359): writeCharacteristic() - uuid:
>>>>> 1d4de0a0-9f84-11e4-a042-0002a5d5c51b
>>>>> D/BtGatt.GattService( 1259): writeCharacteristic() -
>>>>> address=00:00:39:36:85:2F
>>>>> D/BtGatt.GattService( 1259): onWriteCharacteristic() -
>>>>> address=00:00:39:36:85:2F, status=0
>>>>> D/BluetoothGatt( 1359): onCharacteristicWrite() -
>>>>> Device=00:00:39:36:85:2F
>>>>> UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b Status=0
>>>>> ----------------------Log End-------------------------
>>>>>
>>>>>
>>>>> --------------------------Failure
>>>>> Log---------------------------------
>>>>> D/BluetoothGatt( 1359): writeCharacteristic() - uuid:
>>>>> 1d4de0a0-9f84-11e4-a042-0002a5d5c51b
>>>>> D/BtGatt.GattService( 1259): writeCharacteristic() -
>>>>> address=00:00:39:36:85:2F
>>>>> D/BtGatt.GattService( 1259): onWriteCharacteristic() -
>>>>> address=00:00:39:36:85:2F, status=1
>>>>> D/BluetoothGatt( 1359): onCharacteristicWrite() -
>>>>> Device=00:00:39:36:85:2F
>>>>> UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b Status=1
>>>>> --------------------------Log End-------------------------------
>>>>
>>>> Please enable debug logs for daemon (check android/README for how-to)
>>>> and
>>>> provide both debug logs and btmon HCI traces.
>>>>
>>>> --
>>>> BR
>>>> Szymon Janc
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-bluetooth"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> Hi,
>>>
>>> Attached Working and Failure logs with btmon HCI traces and with bluez
>>> debug logs
>>>
>>> Regards,
>>> KP
>>>
>>
>> Hi,
>>
>> From the log (attached in previous mail), From the btmon HCI traces,I am
>> getting "Error: Invalid Handle (0x01)" error. I hope this error is not
>> related to characteristics handle range.How to resolve this error/ find
>> the cause?
>>
>> Log--->
>>
>> < ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
>> 66.810476
>>       ATT: Find Information Request (0x04) len 4
>>         Handle range: 0x0633-0x0633
>
> I suspect the handle 0x0633 does not exist in the remote database, it
> is quite unusual to have an attribute with that big handle anyway.
>
>>> ACL Data RX: Handle 64 flags 0x02 dlen 10                    [hci0]
>> 66.944822
>>       ATT: Find Information Response (0x05) len 5
>>         Format: UUID-16 (0x01)
>>         Handle: 0x0633
>
> Probably something wrong with the remote stack, it seems the response
> is malformed as it should contain the UUID not just the handle.
>
>>> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
>> 67.078076
>>         Num handles: 1
>>         Handle: 64
>>         Count: 1
>>> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
>> 72.209941
>>       ATT: Error Response (0x01) len 4
>>         Write Request (0x12)
>>         Handle: 0x0241
>>         Error: Invalid Handle (0x01)
>
> This is also wrong, how come there is a second response in sequence
> without any request in between? Or the logs are not complete? Maybe
> Android API does not impose the limitation of only having one
> outstanding request per connection but you still have to follow that
> when using GATT otherwise you may get disconnected for invalid
> behavior.
>
>
>> D/BtGatt.GattService(  829): onWriteCharacteristic() -
>> address=00:00:39:36:85:2F, status=1
>> D/BluetoothGatt( 1073): onCharacteristicWrite() -
>> Device=00:00:39:36:85:2F
>> UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b Status=1
>> I/HCSDP_COLLECTORLIB( 1073): Fail characteristic write.
>>
>> Regards,
>> KP
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi,

Thanks for the reply.
Is this could be issue with remote device stack?
But this failure is happening sometime only..not always.

I tried with the gattool and looks like 0x633 is valid handle.
I have reattached the btmon complete log down for your reference.

-----------------------------GAT tool log --------

root# gatttool -i hci0 -b 00:00:39:36:85:2F -I
[   ][00:00:39:36:85:2F][LE]> connect
Connecting... [CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]> primary
[CON][00:00:39:36:85:2F][LE]>
attr handle: 0x0001, end grp handle: 0x0021 uuid:
00001800-0000-1000-8000-00805f9b34fb
attr handle: 0x0100, end grp handle: 0x0141 uuid:
0000180a-0000-1000-8000-00805f9b34fb
attr handle: 0x0200, end grp handle: 0x0241 uuid:
0000180d-0000-1000-8000-00805f9b34fb
attr handle: 0x0300, end grp handle: 0x0331 uuid:
c18da6e0-485a-11e4-8caa-0002a5d5c51b
attr handle: 0x0400, end grp handle: 0x0413 uuid:
db9e5200-485a-11e4-b4bd-0002a5d5c51b
attr handle: 0x0500, end grp handle: 0x0531 uuid:
eca95120-f940-11e4-9ed0-0002a5d5c51b
attr handle: 0x0600, end grp handle: 0x0633 uuid:
68cfc940-e3f8-11e4-93a7-0002a5d5c51b
attr handle: 0x0700, end grp handle: 0x0711 uuid:
ceb23700-485a-11e4-9823-0002a5d5c51b
[CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]> primaryconnectprimarycharc     help
help                                           Show this help
exit                                           Exit interactive mode
quit                                           Exit interactive mode
connect         [address [address type]]       Connect to a remote device
disconnect                                     Disconnect from a remote
device
primary         [UUID]                         Primary Service Discovery
characteristics [start hnd [end hnd [UUID]]]   Characteristics Discovery
char-desc       [start hnd] [end hnd]          Characteristics Descriptor
Discovery
char-read-hnd   <handle> [offset]              Characteristics
Value/Descriptor Read by handle
char-read-uuid  <UUID> [start hnd] [end hnd]   Characteristics
Value/Descriptor Read by UUID
char-write-req  <handle> <new value>           Characteristic Value Write
(Write Request)
char-write-cmd  <handle> <new value>           Characteristic Value Write
(No response)
sec-level       [low | medium | high]          Set security level.
Default: low
mtu             <value>                        Exchange MTU for GATT/ATT
[CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]> characteristics
[CON][00:00:39:36:85:2F][LE]>
handle: 0x0010, char properties: 0x02, char value handle: 0x0011, uuid:
00002a00-0000-1000-8000-00805f9b34fb
handle: 0x0020, char properties: 0x02, char value handle: 0x0021, uuid:
00002a01-0000-1000-8000-00805f9b34fb
handle: 0x0110, char properties: 0x02, char value handle: 0x0111, uuid:
00002a29-0000-1000-8000-00805f9b34fb
handle: 0x0120, char properties: 0x02, char value handle: 0x0121, uuid:
00002a26-0000-1000-8000-00805f9b34fb
handle: 0x0130, char properties: 0x02, char value handle: 0x0131, uuid:
00002a28-0000-1000-8000-00805f9b34fb
handle: 0x0140, char properties: 0x02, char value handle: 0x0141, uuid:
00002a24-0000-1000-8000-00805f9b34fb
handle: 0x0210, char properties: 0x10, char value handle: 0x0211, uuid:
00002a37-0000-1000-8000-00805f9b34fb
handle: 0x0220, char properties: 0x02, char value handle: 0x0221, uuid:
00002a38-0000-1000-8000-00805f9b34fb
handle: 0x0230, char properties: 0x08, char value handle: 0x0231, uuid:
00002a39-0000-1000-8000-00805f9b34fb
handle: 0x0240, char properties: 0x0a, char value handle: 0x0241, uuid:
1d4de0a0-9f84-11e4-a042-0002a5d5c51b
handle: 0x0310, char properties: 0x10, char value handle: 0x0311, uuid:
e9ac57c0-485a-11e4-9974-0002a5d5c51b
handle: 0x0320, char properties: 0x02, char value handle: 0x0321, uuid:
00002a38-0000-1000-8000-00805f9b34fb
handle: 0x0330, char properties: 0x08, char value handle: 0x0331, uuid:
f03c55e0-485a-11e4-84b4-0002a5d5c51b
handle: 0x0410, char properties: 0x30, char value handle: 0x0411, uuid:
1d11ff20-485b-11e4-8add-0002a5d5c51b
handle: 0x0510, char properties: 0x0a, char value handle: 0x0511, uuid:
4d294be0-f941-11e4-bcce-0002a5d5c51b
handle: 0x0520, char properties: 0x08, char value handle: 0x0521, uuid:
c1c8a4a0-f941-11e4-a534-0002a5d5c51b
handle: 0x0530, char properties: 0x08, char value handle: 0x0531, uuid:
173710c0-f942-11e4-9b99-0002a5d5c51b
handle: 0x0610, char properties: 0x0a, char value handle: 0x0611, uuid:
0afb4b20-e4d7-11e4-8b18-0002a5d5c51b
handle: 0x0620, char properties: 0x30, char value handle: 0x0621, uuid:
77164420-e3f8-11e4-ad67-0002a5d5c51b
handle: 0x0630, char properties: 0x30, char value handle: 0x0631, uuid:
7528bc00-e4a8-11e4-b3f1-0002a5d5c51b
handle: 0x0710, char properties: 0x0a, char value handle: 0x0711, uuid:
397ee9c0-485b-11e4-ae57-0002a5d5c51b
[CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]> char-desc 63 2 33
[CON][00:00:39:36:85:2F][LE]>
handle: 0x0633, uuid: 2902
handle: 0x0700, uuid: 2800
handle: 0x0710, uuid: 2803
[CON][00:00:39:36:85:2F][LE]> char-write-req 0x241 00
[CON][00:00:39:36:85:2F][LE]> Characteristic value was written successfully

[CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]>
[CON][00:00:39:36:85:2F][LE]>
-------------------------------End -------------



In one of the previous mail, I have attached the complete log.
Sharing the log again
----------------------------Log---------------------
D/HCSDP_COLLECTORLIB( 1073): scanSensorDevice() is called
I/HCSDP_COLLECTORLIB( 1073): Start scanning sensor device
D/HCSDP_COLLECTORLIB( 1073): scanDevice() is called.
D/BluetoothAdapter( 1073): startLeScan(): null
I/audio_hw_primary(  189): start_output_stream... 2016783120, device 2
W/audio_hw_primary(  189): card 1, port 0 device 0x2
W/audio_hw_primary(  189): rate 48000, channel 2 period_size 0xc0
D/BtGatt.GattService(  829): registerClient() -
UUID=7be053d5-688d-43dd-9e83-9ef9fa9ed6c9
D/BtGatt.GattService(  829): onClientRegistered() -
UUID=7be053d5-688d-43dd-9e83-9ef9fa9ed6c9, clientIf=1
D/BluetoothAdapter( 1073): onClientRegistered() - status=0 clientIf=1
D/BtGatt.GattService(  829): startScan() - queue=0
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
51.801504
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
D/BtGatt.GattService(  829): startScan() - adding client=1
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
51.803059
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
51.803141
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
51.804056
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x01 (6)
I/HCSDP_COLLECTORLIB( 1073): START BLE SCAN.
> HCI Event: LE Meta Event (0x3e) plen 27                      [hci0]
52.286065
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 00:00:39:36:85:2F (OUI 00-00-39)
        Data length: 15
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Name (short): HR
        16-bit Service UUIDs (complete): 3 entries
          Generic Access Profile (0x1800)
          Device Information (0x180a)
          Heart Rate (0x180d)
        RSSI: -68 dBm (0xbc)
@ Device Found: 00:00:39:36:85:2F (1) rssi -68 flags 0x0000
        02 01 06 03 08 48 52 07 03 00 18 0a 18 0d 18     .....HR........
D/BlueZ   (  829):
external/bluetooth/bluez/android/hal-bluetooth.c:handle_device_found()
D/BlueZ   (  829):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[0]: type=BT_PROPERTY_BDADDR len=6 val=00:00:39:36:85:2f
D/BlueZ   (  829):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[1]: type=BT_PROPERTY_TYPE_OF_DEVICE len=4 val=BT_DEVICE_DEVTYPE_BLE
D/BlueZ   (  829):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[2]: type=BT_PROPERTY_REMOTE_RSSI len=4 val=188
> HCI Event: LE Meta Event (0x3e) plen 31                      [hci0]
52.290617
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Public (0x00)
        Address: 00:00:39:36:85:2F (OUI 00-00-39)
        Data length: 19
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        TX power: 0 dBm
        Name (complete): BRIGHTON_HR
        RSSI: -59 dBm (0xc5)
@ Device Found: 00:00:39:36:85:2F (1) rssi -59 flags 0x0000
        02 01 06 02 0a 00 0c 09 42 52 49 47 48 54 4f 4e  ........BRIGHTON
        5f 48 52                                         _HR
D/BlueZ   (  829):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[3]: type=BT_PROPERTY_BDNAME len=2 val=HR
D/BtGatt.GattService(  829): onScanResult() - address=00:00:39:36:85:2F,
rssi=-68
I/HCSDP_COLLECTORLIB( 1073): BLE DEVICE HR is detected.
I/HCSDP_COLLECTORLIB( 1073): DEVICE ADDRESS:00:00:39:36:85:2F
I/HCSDP_COLLECTORLIB( 1073): Callback for SensorDevice detected.
I/HCSDP_SAMPLE_APP( 1073): SensorDevice detected! Callback method is called.
D/BluetoothEventManager(  769): DeviceFoundHandler created new
CachedBluetoothDevice: 00:00:39:36:85:2F
D/BlueZ   (  829):
external/bluetooth/bluez/android/hal-bluetooth.c:handle_device_state_changed()
D/BlueZ   (  829):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[0]: type=BT_PROPERTY_REMOTE_RSSI len=4 val=197
D/BlueZ   (  829):
external/bluetooth/bluez/android/hal-bluetooth.c:device_props_to_hal()
prop[1]: type=BT_PROPERTY_BDNAME len=11 val=BRIGHTON_HR
D/BtGatt.GattService(  829): onScanResult() - address=00:00:39:36:85:2F,
rssi=-59
I/HCSDP_COLLECTORLIB( 1073): BLE DEVICE BRIGHTON_HR is detected.
I/HCSDP_COLLECTORLIB( 1073): DEVICE ADDRESS:00:00:39:36:85:2F
I/HCSDP_COLLECTORLIB( 1073): Callback for SensorDevice detected.
I/HCSDP_SAMPLE_APP( 1073): SensorDevice detected! Callback method is called.
I/Choreographer( 1073): Skipped 151 frames!  The application may be doing
too much work on its main thread.
I/InputDispatcher(  529): Window 'Window{2d0d0cc8 u0
test.sampleapp/test.sampleapp.MainActivity}' spent 2587.3ms processing the
last input event: MotionEvent(deviceId=1, source=0x00002002, action=7,
flags=0x00000000, metaState=0x00000000, buttonState=0x00000000,
edgeFlags=0x00000000, xPrecision=1.0, yPrecision=1.0, displayId=0,
pointers=[0: (38.5, 111.5)]), policyFlags=0x42000000
E/BufferQueue(  186): [test.sampleapp/test.sampleapp.MainActivity]
dequeueBuffer: can't dequeue multiple buffers without setting the buffer
count
W/audio_hw_primary(  189): do_out_standby... 2016783120
D/HCSDP_COLLECTORLIB( 1073): selectSensorDevice() is called
I/HCSDP_COLLECTORLIB( 1073): SET CONNECT SENSOR DEVICE.
I/HCSDP_COLLECTORLIB( 1073): STOP BLE DEVICE SCAN.
D/BluetoothAdapter( 1073): stopLeScan()
D/BtGatt.GattService(  829): stopScan() - queue=1
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
57.216374
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
D/BtGatt.GattService(  829): stopScan() - queue empty; stopping scan
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
57.219067
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x00 (6)
D/BtGatt.GattService(  829): unregisterClient() - clientIf=1
I/audio_hw_primary(  189): start_output_stream... 2016783120, device 2
W/audio_hw_primary(  189): card 1, port 0 device 0x2
W/audio_hw_primary(  189): rate 48000, channel 2 period_size 0xc0
W/InputMethodManagerService(  529): Window already focused, ignoring focus
gain of: com.android.internal.view.IInputMethodClient$Stub$Proxy@2d0658d0
attribute=null, token = android.os.BinderProxy@2d0eddd0
W/SurfaceFlinger(  186): couldn't log to binary event log: overflow.
D/HCSDP_COLLECTORLIB( 1073): connectSensorDevice() is called
D/HCSDP_COLLECTORLIB( 1073): connect() is called.
I/HCSDP_COLLECTORLIB( 1073): START CONNECT WITH GATT PROFILE.
D/BluetoothGatt( 1073): connect() - device: 00:00:39:36:85:2F, auto: false
D/BluetoothGatt( 1073): registerApp()
D/BluetoothGatt( 1073): registerApp() -
UUID=e387766b-58af-4059-8966-0c2313c89e62
D/BtGatt.GattService(  829): registerClient() -
UUID=e387766b-58af-4059-8966-0c2313c89e62
D/BtGatt.GattService(  829): onClientRegistered() -
UUID=e387766b-58af-4059-8966-0c2313c89e62, clientIf=2
D/BluetoothGatt( 1073): onClientRegistered() - status=0 clientIf=2
< HCI Command: LE Create Connection (0x08|0x000d) plen 25      [hci0]
59.482096
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:00:39:36:85:2F (OUI 00-00-39)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                      [hci0]
59.483067
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
D/BtGatt.GattService(  829): clientConnect() - address=00:00:39:36:85:2F,
isDirect=true
D/dalvikvm( 1073): GC_CONCURRENT freed 156K, 7% free 3347K/3588K, paused
1ms+2ms, total 17ms
> HCI Event: LE Meta Event (0x3e) plen 19                      [hci0]
59.849061
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 64
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:00:39:36:85:2F (OUI 00-00-39)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x05
@ Device Connected: 00:00:39:36:85:2F (1) flags 0x0000
< ACL Data TX: Handle 64 flags 0x00 dlen 7                     [hci0]
59.869241
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 672
D/BlueZ   (  829):
external/bluetooth/bluez/android/hal-bluetooth.c:handle_acl_state_changed()
state 0
D/BtGatt.GattService(  829): onConnected() - clientIf=2, connId=1,
address=00:00:39:36:85:2F
D/BluetoothGatt( 1073): onClientConnectionState() - status=0 clientIf=2
device=00:00:39:36:85:2F
I/HCSDP_COLLECTORLIB( 1073): BLE DEVICE CONNECTED.
D/BluetoothGatt( 1073): discoverServices() - device: 00:00:39:36:85:2F
D/BtGatt.GattService(  829): discoverServices() -
address=00:00:39:36:85:2F, connId=1
> ACL Data RX: Handle 64 flags 0x02 dlen 11                    [hci0]
59.924579
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 24                    [hci0]
59.925239
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0007
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0008-0x0018
        UUID: Device Information (0x180a)
        Handle range: 0x0019-0x001c
        UUID: Generic Attribute Profile (0x1801)
> ACL Data RX: Handle 64 flags 0x02 dlen 16                    [hci0]
59.925324
      LE L2CAP: Connection Parameter Update Request (0x12) ident 6 len 8
        Min interval: 6
        Max interval: 9
        Slave latency: 0
        Timeout multiplier: 400
< ACL Data TX: Handle 64 flags 0x00 dlen 10                    [hci0]
59.925456
      LE L2CAP: Connection Parameter Update Response (0x13) ident 6 len 2
        Result: Connection Parameters accepted (0x0000)
< HCI Command: LE Connection Update (0x08|0x0013) plen 14      [hci0]
59.925494
        Handle: 64
        Min connection interval: 7.50 msec (0x0006)
        Max connection interval: 11.25 msec (0x0009)
        Connection latency: 0x0000
        Supervision timeout: 4000 msec (0x0190)
        Min connection length: 0.625 msec (0x0001)
        Max connection length: 0.625 msec (0x0001)
> HCI Event: Command Status (0x0f) plen 4                      [hci0]
59.929071
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 64 flags 0x02 dlen 7                     [hci0]
59.992199
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 72
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
59.992827
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
60.060072
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 11                    [hci0]
60.127074
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x001d-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
60.127717
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0000
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
60.195072
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 24                    [hci0]
60.262325
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0021
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0100-0x0141
        UUID: Device Information (0x180a)
        Handle range: 0x0200-0x0241
        UUID: Heart Rate (0x180d)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
60.262984
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0242-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 64 flags 0x02 dlen 7                     [hci0]
60.329698
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 72
< ACL Data TX: Handle 64 flags 0x00 dlen 7                     [hci0]
60.330279
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 672
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
60.331071
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
60.397198
> ACL Data RX: Handle 64 flags 0x01 dlen 27                    [hci0]
60.464698
> ACL Data RX: Handle 64 flags 0x01 dlen 12                    [hci0]
60.532076
      ATT: Read By Group Type Response (0x11) len 61
        Attribute data length: 20
        Attribute group list: 3 entries
        Handle range: 0x0300-0x0331
        UUID: Unknown (c18da6e0-485a-11e4-8caa-0002a5d5c51b)
        Handle range: 0x0400-0x0413
        UUID: Unknown (db9e5200-485a-11e4-b4bd-0002a5d5c51b)
        Handle range: 0x0500-0x0531
        UUID: Unknown (eca95120-f940-11e4-9ed0-0002a5d5c51b)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
60.532668
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0532-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
60.577070
        Num handles: 1
        Handle: 64
        Count: 1
> ACL Data RX: Handle 64 flags 0x02 dlen 16                    [hci0]
60.599571
      LE L2CAP: Connection Parameter Update Request (0x12) ident 7 len 8
        Min interval: 6
        Max interval: 9
        Slave latency: 0
        Timeout multiplier: 400
< ACL Data TX: Handle 64 flags 0x00 dlen 10                    [hci0]
60.599704
      LE L2CAP: Connection Parameter Update Response (0x13) ident 7 len 2
        Result: Connection Parameters accepted (0x0000)
< HCI Command: LE Connection Update (0x08|0x0013) plen 14      [hci0]
60.599743
        Handle: 64
        Min connection interval: 7.50 msec (0x0006)
        Max connection interval: 11.25 msec (0x0009)
        Connection latency: 0x0000
        Supervision timeout: 4000 msec (0x0190)
        Min connection length: 0.625 msec (0x0001)
        Max connection length: 0.625 msec (0x0001)
> HCI Event: Command Status (0x0f) plen 4                      [hci0]
60.601066
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Command Disallowed (0x0c)
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
60.734825
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
60.736066
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x01 dlen 19                    [hci0]
60.802198
      ATT: Read By Group Type Response (0x11) len 41
        Attribute data length: 20
        Attribute group list: 2 entries
        Handle range: 0x0600-0x0633
        UUID: Unknown (68cfc940-e3f8-11e4-93a7-0002a5d5c51b)
        Handle range: 0x0700-0x0711
        UUID: Unknown (ceb23700-485a-11e4-9823-0002a5d5c51b)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
60.802913
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0712-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
60.937074
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0712
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onSearchResult() - address=00:00:39:36:85:2F,
uuid=00001800-0000-1000-8000-00805f9b34fb
D/BluetoothGatt( 1073): onGetService() - Device=00:00:39:36:85:2F
UUID=00001800-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onSearchResult() - address=00:00:39:36:85:2F,
uuid=0000180a-0000-1000-8000-00805f9b34fb
D/BluetoothGatt( 1073): onGetService() - Device=00:00:39:36:85:2F
UUID=0000180a-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onSearchResult() - address=00:00:39:36:85:2F,
uuid=0000180d-0000-1000-8000-00805f9b34fb
D/BluetoothGatt( 1073): onGetService() - Device=00:00:39:36:85:2F
UUID=0000180d-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onSearchResult() - address=00:00:39:36:85:2F,
uuid=c18da6e0-485a-11e4-8caa-0002a5d5c51b
D/BluetoothGatt( 1073): onGetService() - Device=00:00:39:36:85:2F
UUID=c18da6e0-485a-11e4-8caa-0002a5d5c51b
D/BtGatt.GattService(  829): onSearchResult() - address=00:00:39:36:85:2F,
uuid=db9e5200-485a-11e4-b4bd-0002a5d5c51b
D/BluetoothGatt( 1073): onGetService() - Device=00:00:39:36:85:2F
UUID=db9e5200-485a-11e4-b4bd-0002a5d5c51b
D/BtGatt.GattService(  829): onSearchResult() - address=00:00:39:36:85:2F,
uuid=eca95120-f940-11e4-9ed0-0002a5d5c51b
D/BluetoothGatt( 1073): onGetService() - Device=00:00:39:36:85:2F
UUID=eca95120-f940-11e4-9ed0-0002a5d5c51b
D/BtGatt.GattService(  829): onSearchResult() - address=00:00:39:36:85:2F,
uuid=68cfc940-e3f8-11e4-93a7-0002a5d5c51b
D/BluetoothGatt( 1073): onGetService() - Device=00:00:39:36:85:2F
UUID=68cfc940-e3f8-11e4-93a7-0002a5d5c51b
D/BtGatt.GattService(  829): onSearchResult() - address=00:00:39:36:85:2F,
uuid=ceb23700-485a-11e4-9823-0002a5d5c51b
D/BluetoothGatt( 1073): onGetService() - Device=00:00:39:36:85:2F
UUID=ceb23700-485a-11e4-9823-0002a5d5c51b
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
60.951909
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0021
        Attribute type: Characteristic (0x2803)
D/BtGatt.GattService(  829): onSearchCompleted() - connId=1, status=0
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
61.005073
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 20                    [hci0]
61.072198
      ATT: Read By Type Response (0x09) len 15
        Attribute data length: 7
        Attribute data list: 2 entries
        Handle: 0x0010
        Value: 021100002a
        Handle: 0x0020
        Value: 022100012a
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=00002a00-0000-1000-8000-00805f9b34fb, prop=2
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=00002a00-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=00002a01-0000-1000-8000-00805f9b34fb, prop=2
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=00002a01-0000-1000-8000-00805f9b34fb
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
61.078188
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0021
        Attribute type: Include (0x2802)
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=257,
charUuid=00000000-0000-0000-0000-000000000000, prop=0
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
61.207212
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
61.208833
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0100-0x0141
        Attribute type: Characteristic (0x2803)
D/BtGatt.GattService(  829): onGetIncludedService() -
address=00:00:39:36:85:2F, status=257,
uuid=00001800-0000-1000-8000-00805f9b34fb,
inclUuid=00000000-0000-0000-0000-000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
61.275074
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
61.342196
> ACL Data RX: Handle 64 flags 0x01 dlen 7                     [hci0]
61.409573
      ATT: Read By Type Response (0x09) len 29
        Attribute data length: 7
        Attribute data list: 4 entries
        Handle: 0x0110
        Value: 021101292a
        Handle: 0x0120
        Value: 022101262a
        Handle: 0x0130
        Value: 023101282a
        Handle: 0x0140
        Value: 024101242a
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=00002a29-0000-1000-8000-00805f9b34fb, prop=2
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=00002a29-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=00002a26-0000-1000-8000-00805f9b34fb, prop=2
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=00002a26-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=00002a28-0000-1000-8000-00805f9b34fb, prop=2
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=00002a28-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=00002a24-0000-1000-8000-00805f9b34fb, prop=2
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=00002a24-0000-1000-8000-00805f9b34fb
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
61.419041
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0100-0x0141
        Attribute type: Include (0x2802)
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=257,
charUuid=00000000-0000-0000-0000-000000000000, prop=0
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
61.544698
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0100
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
61.547534
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0200-0x0241
        Attribute type: Characteristic (0x2803)
D/BtGatt.GattService(  829): onGetIncludedService() -
address=00:00:39:36:85:2F, status=257,
uuid=0000180a-0000-1000-8000-00805f9b34fb,
inclUuid=00000000-0000-0000-0000-000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
61.613073
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
61.679699
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0210
        Value: 101102372a
        Handle: 0x0220
        Value: 022102382a
        Handle: 0x0230
        Value: 083102392a
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
61.680835
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0231-0x0241
        Attribute type: Characteristic (0x2803)
I/HCSDP_COLLECTORLIB( 1073): BLE DEVICE SCAN TIMEOUT!
D/BluetoothAdapter( 1073): stopLeScan()
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
61.814824
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 21
        Attribute data list: 1 entry
        Handle: 0x0240
        Value: 0a41021bc5d5a5020042a0e411849fa0e04d1d
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=00002a37-0000-1000-8000-00805f9b34fb, prop=16
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=00002a37-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=00002a38-0000-1000-8000-00805f9b34fb, prop=2
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=00002a38-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=00002a39-0000-1000-8000-00805f9b34fb, prop=8
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=00002a39-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=1d4de0a0-9f84-11e4-a042-0002a5d5c51b, prop=10
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
61.825082
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0200-0x0241
        Attribute type: Include (0x2802)
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=257,
charUuid=00000000-0000-0000-0000-000000000000, prop=0
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
61.883071
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
61.949697
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0200
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
61.951771
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0300-0x0331
        Attribute type: Characteristic (0x2803)
D/BtGatt.GattService(  829): onGetIncludedService() -
address=00:00:39:36:85:2F, status=257,
uuid=0000180d-0000-1000-8000-00805f9b34fb,
inclUuid=00000000-0000-0000-0000-000000000000
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
62.084824
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 21
        Attribute data list: 1 entry
        Handle: 0x0310
        Value: 1011031bc5d5a502007499e4115a48c057ace9
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
62.085797
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0311-0x0331
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
62.153070
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 13                    [hci0]
62.219706
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0320
        Value: 022103382a
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
62.220745
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0321-0x0331
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
62.354830
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 21
        Attribute data list: 1 entry
        Handle: 0x0330
        Value: 0831031bc5d5a50200b484e4115a48e0553cf0
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=e9ac57c0-485a-11e4-9974-0002a5d5c51b, prop=16
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=e9ac57c0-485a-11e4-9974-0002a5d5c51b
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=00002a38-0000-1000-8000-00805f9b34fb, prop=2
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=00002a38-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=f03c55e0-485a-11e4-84b4-0002a5d5c51b, prop=8
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=f03c55e0-485a-11e4-84b4-0002a5d5c51b
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
62.363273
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0300-0x0331
        Attribute type: Include (0x2802)
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=257,
charUuid=00000000-0000-0000-0000-000000000000, prop=0
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
62.423076
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
62.489700
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0300
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
62.491686
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0400-0x0413
        Attribute type: Characteristic (0x2803)
D/BtGatt.GattService(  829): onGetIncludedService() -
address=00:00:39:36:85:2F, status=257,
uuid=c18da6e0-485a-11e4-8caa-0002a5d5c51b,
inclUuid=00000000-0000-0000-0000-000000000000
W/audio_hw_primary(  189): do_out_standby... 2016783120
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
62.624824
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 21
        Attribute data list: 1 entry
        Handle: 0x0410
        Value: 3011041bc5d5a50200dd8ae4115b4820ff111d
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
62.625844
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0411-0x0413
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
62.693069
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
62.759696
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0411
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=1d11ff20-485b-11e4-8add-0002a5d5c51b, prop=48
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=1d11ff20-485b-11e4-8add-0002a5d5c51b
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
62.763622
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0400-0x0413
        Attribute type: Include (0x2802)
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=257,
charUuid=00000000-0000-0000-0000-000000000000, prop=0
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
62.894699
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0400
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
62.896585
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0500-0x0531
        Attribute type: Characteristic (0x2803)
D/BtGatt.GattService(  829): onGetIncludedService() -
address=00:00:39:36:85:2F, status=257,
uuid=db9e5200-485a-11e4-b4bd-0002a5d5c51b,
inclUuid=00000000-0000-0000-0000-000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
62.963070
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
63.029699
> ACL Data RX: Handle 64 flags 0x01 dlen 27                    [hci0]
63.097197
> ACL Data RX: Handle 64 flags 0x01 dlen 15                    [hci0]
63.164696
      ATT: Read By Type Response (0x09) len 64
        Attribute data length: 21
        Attribute data list: 3 entries
        Handle: 0x0510
        Value: 0a11051bc5d5a50200cebce41141f9e04b294d
        Handle: 0x0520
        Value: 0821051bc5d5a5020034a5e41141f9a0a4c8c1
        Handle: 0x0530
        Value: 0831051bc5d5a50200999be41142f9c0103717
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=4d294be0-f941-11e4-bcce-0002a5d5c51b, prop=10
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=4d294be0-f941-11e4-bcce-0002a5d5c51b
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=c1c8a4a0-f941-11e4-a534-0002a5d5c51b, prop=8
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=c1c8a4a0-f941-11e4-a534-0002a5d5c51b
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=173710c0-f942-11e4-9b99-0002a5d5c51b, prop=8
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=173710c0-f942-11e4-9b99-0002a5d5c51b
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
63.172720
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0500-0x0531
        Attribute type: Include (0x2802)
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=257,
charUuid=00000000-0000-0000-0000-000000000000, prop=0
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
63.299699
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0500
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
63.302175
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0600-0x0633
        Attribute type: Characteristic (0x2803)
D/BtGatt.GattService(  829): onGetIncludedService() -
address=00:00:39:36:85:2F, status=257,
uuid=eca95120-f940-11e4-9ed0-0002a5d5c51b,
inclUuid=00000000-0000-0000-0000-000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
63.368071
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
63.434697
> ACL Data RX: Handle 64 flags 0x01 dlen 27                    [hci0]
63.502196
> ACL Data RX: Handle 64 flags 0x01 dlen 15                    [hci0]
63.569697
      ATT: Read By Type Response (0x09) len 64
        Attribute data length: 21
        Attribute data list: 3 entries
        Handle: 0x0610
        Value: 0a11061bc5d5a50200188be411d7e4204bfb0a
        Handle: 0x0620
        Value: 3021061bc5d5a5020067ade411f8e320441677
        Handle: 0x0630
        Value: 3031061bc5d5a50200f1b3e411a8e400bc2875
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
63.570890
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0631-0x0633
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
63.704697
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0631
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=0afb4b20-e4d7-11e4-8b18-0002a5d5c51b, prop=10
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=0afb4b20-e4d7-11e4-8b18-0002a5d5c51b
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=77164420-e3f8-11e4-ad67-0002a5d5c51b, prop=48
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=77164420-e3f8-11e4-ad67-0002a5d5c51b
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=7528bc00-e4a8-11e4-b3f1-0002a5d5c51b, prop=48
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=7528bc00-e4a8-11e4-b3f1-0002a5d5c51b
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
63.713083
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0600-0x0633
        Attribute type: Include (0x2802)
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=257,
charUuid=00000000-0000-0000-0000-000000000000, prop=0
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
63.773070
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
63.839820
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0600
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
63.841149
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0700-0x0711
        Attribute type: Characteristic (0x2803)
D/BtGatt.GattService(  829): onGetIncludedService() -
address=00:00:39:36:85:2F, status=257,
uuid=68cfc940-e3f8-11e4-93a7-0002a5d5c51b,
inclUuid=00000000-0000-0000-0000-000000000000
> ACL Data RX: Handle 64 flags 0x02 dlen 27                    [hci0]
63.974822
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 21
        Attribute data list: 1 entry
        Handle: 0x0710
        Value: 0a11071bc5d5a5020057aee4115b48c0e97e39
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=0,
charUuid=397ee9c0-485b-11e4-ae57-0002a5d5c51b, prop=10
D/BluetoothGatt( 1073): onGetCharacteristic() - Device=00:00:39:36:85:2F
UUID=397ee9c0-485b-11e4-ae57-0002a5d5c51b
< ACL Data TX: Handle 64 flags 0x00 dlen 11                    [hci0]
63.978634
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0700-0x0711
        Attribute type: Include (0x2802)
D/BtGatt.GattService(  829): onGetCharacteristic() -
address=00:00:39:36:85:2F, status=257,
charUuid=00000000-0000-0000-0000-000000000000, prop=0
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
64.043069
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
64.109702
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0700
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
64.111687
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0012-0x001f
D/BtGatt.GattService(  829): onGetIncludedService() -
address=00:00:39:36:85:2F, status=257,
uuid=ceb23700-485a-11e4-9823-0002a5d5c51b,
inclUuid=00000000-0000-0000-0000-000000000000
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
64.244698
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0012
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
64.247299
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0112-0x011f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
E/bluetoothd(  861): Discover all characteristic descriptors failed
[00002a00-0000-1000-8000-00805f9b34fb]: No attribute found within the
given range
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
64.313069
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
64.379697
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0112
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
64.381330
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0122-0x012f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
E/bluetoothd(  861): Discover all characteristic descriptors failed
[00002a29-0000-1000-8000-00805f9b34fb]: No attribute found within the
given range
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
64.514707
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0122
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
64.517293
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0132-0x013f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
E/bluetoothd(  861): Discover all characteristic descriptors failed
[00002a26-0000-1000-8000-00805f9b34fb]: No attribute found within the
given range
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
64.578074
        Num handles: 1
        Handle: 64
        Count: 1
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
64.649701
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0132
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
64.652048
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0212-0x021f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
E/bluetoothd(  861): Discover all characteristic descriptors failed
[00002a28-0000-1000-8000-00805f9b34fb]: No attribute found within the
given range
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
64.718074
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 10                    [hci0]
64.784697
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0212
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
64.785588
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0213-0x021f
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
64.919698
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0213
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=0,
descUuid=00002902-0000-1000-8000-00805f9b34fb
D/BluetoothGatt( 1073): onGetDescriptor() - Device=00:00:39:36:85:2F
UUID=00002902-0000-1000-8000-00805f9b34fb
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
64.924004
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0222-0x022f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
64.988075
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
65.054696
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0222
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
65.056351
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0232-0x023f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
E/bluetoothd(  861): Discover all characteristic descriptors failed
[00002a38-0000-1000-8000-00805f9b34fb]: No attribute found within the
given range
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
65.189699
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0232
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
65.192028
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0312-0x031f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
E/bluetoothd(  861): Discover all characteristic descriptors failed
[00002a39-0000-1000-8000-00805f9b34fb]: No attribute found within the
given range
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
65.258074
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 10                    [hci0]
65.324822
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0312
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
65.325715
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0313-0x031f
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
65.459824
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0313
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=0,
descUuid=00002902-0000-1000-8000-00805f9b34fb
D/BluetoothGatt( 1073): onGetDescriptor() - Device=00:00:39:36:85:2F
UUID=00002902-0000-1000-8000-00805f9b34fb
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
65.463727
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0322-0x032f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
65.528071
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
65.594822
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0322
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
65.597533
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0412-0x0413
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
E/bluetoothd(  861): Discover all characteristic descriptors failed
[00002a38-0000-1000-8000-00805f9b34fb]: No attribute found within the
given range
> ACL Data RX: Handle 64 flags 0x02 dlen 24                    [hci0]
65.729823
      ATT: Find Information Response (0x05) len 19
        Format: UUID-128 (0x02)
        Handle: 0x0412
        UUID: Unknown (2c851320-485b-11e4-96b6-0002a5d5c51b)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
65.730342
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0413-0x0413
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
65.798071
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 10                    [hci0]
65.864822
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0413
        UUID: Client Characteristic Configuration (0x2902)
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=0,
descUuid=2c851320-485b-11e4-96b6-0002a5d5c51b
D/BluetoothGatt( 1073): onGetDescriptor() - Device=00:00:39:36:85:2F
UUID=2c851320-485b-11e4-96b6-0002a5d5c51b
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=0,
descUuid=00002902-0000-1000-8000-00805f9b34fb
D/BluetoothGatt( 1073): onGetDescriptor() - Device=00:00:39:36:85:2F
UUID=00002902-0000-1000-8000-00805f9b34fb
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
65.870048
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0512-0x051f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
65.999824
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0512
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
66.001671
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0522-0x052f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
E/bluetoothd(  861): Discover all characteristic descriptors failed
[4d294be0-f941-11e4-bcce-0002a5d5c51b]: No attribute found within the
given range
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
66.068075
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
66.134820
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0522
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
66.137190
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0612-0x061f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
E/bluetoothd(  861): Discover all characteristic descriptors failed
[c1c8a4a0-f941-11e4-a534-0002a5d5c51b]: No attribute found within the
given range
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
66.269821
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0612
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
66.271434
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0622-0x062f
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
E/bluetoothd(  861): Discover all characteristic descriptors failed
[0afb4b20-e4d7-11e4-8b18-0002a5d5c51b]: No attribute found within the
given range
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
66.328069
        Num handles: 1
        Handle: 64
        Count: 1
> ACL Data RX: Handle 64 flags 0x02 dlen 24                    [hci0]
66.404946
      ATT: Find Information Response (0x05) len 19
        Format: UUID-128 (0x02)
        Handle: 0x0622
        UUID: Unknown (3afdbd60-e4a2-11e4-9235-0002a5d5c51b)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
66.405468
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0623-0x062f
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
66.473069
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 10                    [hci0]
66.539822
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0623
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
66.540321
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0624-0x062f
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
66.674822
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x0624
        Error: Attribute Not Found (0x0a)
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=0,
descUuid=3afdbd60-e4a2-11e4-9235-0002a5d5c51b
D/BluetoothGatt( 1073): onGetDescriptor() - Device=00:00:39:36:85:2F
UUID=3afdbd60-e4a2-11e4-9235-0002a5d5c51b
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=0,
descUuid=00002902-0000-1000-8000-00805f9b34fb
D/BluetoothGatt( 1073): onGetDescriptor() - Device=00:00:39:36:85:2F
UUID=00002902-0000-1000-8000-00805f9b34fb
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
66.680105
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0632-0x0633
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
66.743071
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 24                    [hci0]
66.809951
      ATT: Find Information Response (0x05) len 19
        Format: UUID-128 (0x02)
        Handle: 0x0632
        UUID: Unknown (3afdbd60-e4a2-11e4-9235-0002a5d5c51b)
< ACL Data TX: Handle 64 flags 0x00 dlen 9                     [hci0]
66.810476
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0633-0x0633
> ACL Data RX: Handle 64 flags 0x02 dlen 10                    [hci0]
66.944822
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0633
        UUID: Client Characteristic Configuration (0x2902)
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=0,
descUuid=3afdbd60-e4a2-11e4-9235-0002a5d5c51b
D/BluetoothGatt( 1073): onGetDescriptor() - Device=00:00:39:36:85:2F
UUID=3afdbd60-e4a2-11e4-9235-0002a5d5c51b
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=0,
descUuid=00002902-0000-1000-8000-00805f9b34fb
D/BluetoothGatt( 1073): onGetDescriptor() - Device=00:00:39:36:85:2F
UUID=00002902-0000-1000-8000-00805f9b34fb
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
D/BtGatt.GattService(  829): onGetDescriptor() -
address=00:00:39:36:85:2F, status=257,
descUuid=00000000-0000-0000-0000-000000000000
D/BluetoothGatt( 1073): onSearchComplete() = Device=00:00:39:36:85:2F
Status=0
I/HCSDP_COLLECTORLIB( 1073): HR SERVICE FOUND.
I/HCSDP_COLLECTORLIB( 1073): AM SERVICE FOUND.
I/HCSDP_COLLECTORLIB( 1073): WAVE SERVICE FOUND.
I/HCSDP_COLLECTORLIB( 1073): DEVICE INFORMATION SERVICE FOUND.
I/HCSDP_SAMPLE_APP( 1073): BLE is connected.
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
67.078076
        Num handles: 1
        Handle: 64
        Count: 1
D/HCSDP_COLLECTORLIB( 1073): setMeasurementType() is called
I/HCSDP_COLLECTORLIB( 1073): HR MEASUREMENT CONTROL CHARACTERISTIC
FOUND.(PULSE)
D/BluetoothGatt( 1073): writeCharacteristic() - uuid:
1d4de0a0-9f84-11e4-a042-0002a5d5c51b
< ACL Data TX: Handle 64 flags 0x00 dlen 8                     [hci0]
72.124696
      ATT: Write Request (0x12) len 3
        Handle: 0x0241
          Data: 00
D/BtGatt.GattService(  829): writeCharacteristic() -
address=00:00:39:36:85:2F
I/audio_hw_primary(  189): start_output_stream... 2016783120, device 2
W/audio_hw_primary(  189): card 1, port 0 device 0x2
W/audio_hw_primary(  189): rate 48000, channel 2 period_size 0xc0
> ACL Data RX: Handle 64 flags 0x02 dlen 9                     [hci0]
72.209941
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0241
        Error: Invalid Handle (0x01)
D/BtGatt.GattService(  829): onWriteCharacteristic() -
address=00:00:39:36:85:2F, status=1
D/BluetoothGatt( 1073): onCharacteristicWrite() - Device=00:00:39:36:85:2F
UUID=1d4de0a0-9f84-11e4-a042-0002a5d5c51b Status=1
I/HCSDP_COLLECTORLIB( 1073): Fail characteristic write.
I/HCSDP_COLLECTORLIB( 1073): operation queue element is null
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
72.329078
        Num handles: 1
        Handle: 64
        Count: 1
---------------------------Log End------------------
Regards,
KP



