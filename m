Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Naveen Kaje <nckaje@gmail.com>
Date: Sat, 10 Sep 2016 21:06:34 -0600
Message-ID: <CAG=hFhL+OiRiwXLU5_9Yc03v8vOYhkfakp26871LU_AZdB2fmQ@mail.gmail.com>
Subject: Issue: Bluez: Bluetooth Mouse Disconnects Soon After Pairing
To: me <nckaje@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I am seeing a disconnection behavior with Bluetooth mouse (Microsoft
Desginer Mouse). Software Baseline 3.18 based kernel and Bluez 5.41.

The device is discovered with bluetoothctl. The mouse pairs briefly (for
about 30 seconds) and then the host disconnects.
Bluetoothctl error reads Failed to pair:
org.bluez.Error.AuthenticationCanceled

Observations:
1) The time it takes for the mouse to stop working is about 30 seconds
since the pair command. This time is consistent.

2) The btmon report says Reason: Remote User Terminated Connection (0x13),
which I found to be not entirely true.
I hacked the transfport layer (UART) in Kernel to skip sending
disconnection message which resulted in the Mouse device
continuing to send reports even after this point (Observed on btmon).

Bluetoothctl and btmon logs are shown below. What could I be missing?

Thanks in advance for the help.

******************** Bluetoothctl log begin ****************************
[bluetooth]# show
Controller 44:1C:A8:6C:8F:5E
        Name: BTHost
        Alias: BTHost
        Class: 0x000000
        Powered: yes
        Discoverable: no
        Pairable: yes
        UUID: Generic Attribute Profile
(00001801-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control
 (0000110e-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information
(00001200-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile
 (00001800-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target
(0000110c-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v1D6Bp0246d0529
[bluetooth]# discoverable on
Changing discoverable on succeeded
[bluetooth]# pairable on
Changing pairable on succeeded
[bluetooth]# scan on
Discovery started
[CHG] Controller 44:1C:A8:6C:8F:5E Discovering: yes
[NEW] Device F5:95:EC:5D:0F:D3 Designer Mouse
[bluetooth]# pair F5:95:EC:5D:0F:D3
Attempting to pair with F5:95:EC:5D:0F:D3
[CHG] Device F5:95:EC:5D:0F:D3 Connected: yes
[CHG] Device F5:95:EC:5D:0F:D3 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device F5:95:EC:5D:0F:D3 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device F5:95:EC:5D:0F:D3 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
[CHG] Device F5:95:EC:5D:0F:D3 UUIDs: 0000180f-0000-1000-8000-00805f9b34fb
[CHG] Device F5:95:EC:5D:0F:D3 UUIDs: 00001812-0000-1000-8000-00805f9b34fb
[CHG] Device F5:95:EC:5D:0F:D3 Modalias: usb:v045Ep0805d0110
[Designer Mouse]# info
Device F5:95:EC:5D:0F:D3
        Name: Designer Mouse
        Alias: Designer Mouse
        Appearance: 0x03c2
        Icon: input-mouse
        Paired: no
        Trusted: no
        Blocked: no
        Connected: yes
        LegacyPairing: no
        UUID: Generic Access Profile
 (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile
(00001801-0000-1000-8000-00805f9b34fb)
        UUID: Device Information
 (0000180a-0000-1000-8000-00805f9b34fb)
        UUID: Battery Service
(0000180f-0000-1000-8000-00805f9b34fb)
        UUID: Human Interface Device
 (00001812-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v045Ep0805d0110
        RSSI: -91
Failed to pair: org.bluez.Error.AuthenticationCanceled
[CHG] Controller 44:1C:A8:6C:8F:5E Discoverable: no

********************* Bluetoothctl log end *****************************

********************* btmon log begin **********************************
... snip ...
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1    [hci0]
59.630036
        Advertising: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
59.636835
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     [hci0]
59.636902
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
59.641740
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
59.641816
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
59.646217
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x01 (7)
> HCI Event: LE Meta Event (0x3e) plen 39                      [hci0]
59.725430
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: F5:95:EC:5D:0F:D3 (Static)
        Data length: 27
        Name (complete): Designer Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
        RSSI: -91 dBm (0xa5)
> HCI Event: LE Meta Event (0x3e) plen 12                      [hci0]
59.725446
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: F5:95:EC:5D:0F:D3 (Static)
        Data length: 0
        RSSI: -91 dBm (0xa5)
@ Device Found: F5:95:EC:5D:0F:D3 (2) rssi -91 flags 0x0000
        0f 09 44 65 73 69 67 6e 65 72 20 4d 6f 75 73 65  ..Designer Mouse
        03 19 c2 03 02 01 05 03 03 12 18                 ...........
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         [hci0]
64.768705
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
64.775294
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: Inquiry (0x01|0x0001) plen 5                    [hci0]
64.775373
        Access code: 0x9e8b33 (General Inquiry)
        Length: 5.12s (0x04)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                      [hci0]
64.780135
      Inquiry (0x01|0x0001) ncmd 1
        Status: Success (0x00)
< HCI Command: Inquiry Cancel (0x01|0x0002) plen 0             [hci0]
68.459476
> HCI Event: Command Complete (0x0e) plen 4                    [hci0]
68.466205
      Inquiry Cancel (0x01|0x0002) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x00 (7)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25      [hci0]
68.466479
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: F5:95:EC:5D:0F:D3 (Static)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                      [hci0]
68.473054
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                      [hci0]
68.488954
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 1
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: F5:95:EC:5D:0F:D3 (Static)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Device Connected: F5:95:EC:5D:0F:D3 (2) flags 0x0000
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
68.489272
      SMP: Pairing Request (0x01) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses
(0x01)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey IdKey Sign (0x07)
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
68.493087
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
68.527412
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 11                     [hci0]
68.595889
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses
(0x01)
        Max encryption key size: 16
        Initiator key distribution: Sign (0x04)
        Responder key distribution: EncKey IdKey (0x03)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
68.595909
        Num handles: 1
        Handle: 1
        Count: 1
< ACL Data TX: Handle 1 flags 0x00 dlen 21                     [hci0]
68.596024
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 707320123462a854e5cd118b1a00f1c1
> ACL Data RX: Handle 1 flags 0x02 dlen 7                      [hci0]
68.663066
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 23
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
68.663082
        Num handles: 1
        Handle: 1
        Count: 1
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
68.663439
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 1 flags 0x02 dlen 21                     [hci0]
68.731850
      SMP: Pairing Confirm (0x03) len 16
        Confim value: e6f1f687ecc8c45a249ecbc6f0785a40
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
68.731868
        Num handles: 1
        Handle: 1
        Count: 1
< ACL Data TX: Handle 1 flags 0x00 dlen 21                     [hci0]
68.732015
      SMP: Pairing Random (0x04) len 16
        Random value: 5467954ff3f0295156090e71e844e49f
> ACL Data RX: Handle 1 flags 0x02 dlen 24                     [hci0]
68.799826
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0007
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0008-0x0008
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0009-0x000d
        UUID: Device Information (0x180a)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
68.799845
        Num handles: 1
        Handle: 1
        Count: 1
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
68.800186
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000e-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 1 flags 0x02 dlen 21                     [hci0]
68.866793
      SMP: Pairing Random (0x04) len 16
        Random value: 337c2f5aef77c869bfdb794a7bb7822d
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
68.866814
        Num handles: 1
        Handle: 1
        Count: 1
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28       [hci0]
68.866977
        Handle: 1
        Random number: 0x0000000000000000
        Encrypted diversifier: 0x0000
        Long term key: a1230fff3c4a7f9cfb937bcc4105bf36
> HCI Event: Command Status (0x0f) plen 4                      [hci0]
68.873480
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 1 flags 0x02 dlen 18                     [hci0]
68.933300
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x000e-0x0011
        UUID: Battery Service (0x180f)
        Handle range: 0x0012-0xffff
        UUID: Human Interface Device (0x1812)
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
68.934710
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Secondary Service (0x2801)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
68.999515
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
69.067411
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
69.067732
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0007
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
69.134511
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
69.202622
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
69.202972
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0009-0x000d
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
69.269695
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
69.337568
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0009
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
69.337909
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0x0011
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
69.404491
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
69.472447
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000e
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
69.472738
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0012-0xffff
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
69.539509
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
69.607424
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0012
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
69.607734
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0007
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
69.674436
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
69.744145
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0002
        Value: 0a0300002a
        Handle: 0x0004
        Value: 020500012a
        Handle: 0x0006
        Value: 020700042a
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
69.744447
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0007-0x0007
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
69.809365
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
69.877367
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0007
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
69.877711
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0009-0x000d
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
69.944414
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 20                     [hci0]
70.013493
      ATT: Read By Type Response (0x09) len 15
        Attribute data length: 7
        Attribute data list: 2 entries
        Handle: 0x000a
        Value: 020b00292a
        Handle: 0x000c
        Value: 020d00502a
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
70.013807
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000d-0x000d
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
70.079454
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
70.147597
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000d
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
70.147935
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0x0011
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
70.214503
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 13                     [hci0]
70.282728
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: 121000192a
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
70.283063
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0x0011
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
70.349702
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
70.417446
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
70.417802
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0011-0x0011
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
70.484463
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 10                     [hci0]
70.552541
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0011
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
70.552907
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0012-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
70.619445
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
70.689192
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0013
        Value: 0614004e2a
        Handle: 0x0015
        Value: 1a16004d2a
        Handle: 0x0019
        Value: 1a1a004d2a
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
70.689497
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001a-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
70.754566
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
70.824156
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x001d
        Value: 0a1e004d2a
        Handle: 0x0020
        Value: 0a21004d2a
        Handle: 0x0023
        Value: 0224004b2a
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
70.824470
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0024-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
70.889443
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
70.959020
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0025
        Value: 1a2600332a
        Handle: 0x0028
        Value: 0229004a2a
        Handle: 0x002a
        Value: 042b004c2a
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
70.959445
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002b-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
71.092121
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
71.159885
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x002b
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
71.160381
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0017-0x0018
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
71.227106
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 14                     [hci0]
71.295425
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x0017
        UUID: Client Characteristic Configuration (0x2902)
        Handle: 0x0018
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
71.295840
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001b-0x001c
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
71.362129
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 14                     [hci0]
71.430411
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x001b
        UUID: Client Characteristic Configuration (0x2902)
        Handle: 0x001c
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
71.430819
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001f-0x001f
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
71.496863
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 10                     [hci0]
71.565376
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x001f
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
71.565662
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0022-0x0022
> ACL Data RX: Handle 1 flags 0x02 dlen 21                     [hci0]
71.971916
      SMP: Encryption Information (0x06) len 16
        Long term key: b3e6dfedf5ac5f3f4da735acb21005ab
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
71.971932
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 10                     [hci0]
72.037591
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0022
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
72.037895
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0027-0x0027
> ACL Data RX: Handle 1 flags 0x02 dlen 15                     [hci0]
72.106366
      SMP: Master Identification (0x07) len 10
        EDIV: 0xd974
        Rand: 0xd06f95a7d5f1a6aa
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
72.106381
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 10                     [hci0]
72.172715
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0027
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
72.173101
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x002c-0xffff
> ACL Data RX: Handle 1 flags 0x02 dlen 21                     [hci0]
72.241881
      SMP: Identity Information (0x08) len 16
        Identity resolving key: ea7102bac3d692626259c72b1613a1ca
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
72.241896
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
72.307467
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x002c
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
72.323193
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
> ACL Data RX: Handle 1 flags 0x02 dlen 12                     [hci0]
72.375939
      SMP: Identity Address Information (0x09) len 7
        Address type: Random (0x01)
        Address: F5:95:EC:5D:0F:D3 (Static)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
72.375954
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 19                     [hci0]
72.443348
      ATT: Read Response (0x0b) len 14
        Value: 44657369676e6572204d6f757365
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
72.443709
      ATT: Read Request (0x0a) len 2
        Handle: 0x0005
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
72.509421
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 7                      [hci0]
72.577327
      ATT: Read Response (0x0b) len 2
        Value: c203
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
72.577664
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
72.644640
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 12                     [hci0]
72.712766
      ATT: Read Response (0x0b) len 7
        Value: 025e0405081001
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
72.713149
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0012-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
72.779410
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
72.849315
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0013
        Value: 0614004e2a
        Handle: 0x0015
        Value: 1a16004d2a
        Handle: 0x0019
        Value: 1a1a004d2a
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
72.849718
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001a-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
72.914521
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
72.984203
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x001d
        Value: 0a1e004d2a
        Handle: 0x0020
        Value: 0a21004d2a
        Handle: 0x0023
        Value: 0224004b2a
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
72.984591
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0024-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
73.049409
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
73.119009
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0025
        Value: 1a2600332a
        Handle: 0x0028
        Value: 0229004a2a
        Handle: 0x002a
        Value: 042b004c2a
< ACL Data TX: Handle 1 flags 0x00 dlen 11                     [hci0]
73.119396
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002b-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
73.184528
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
73.252330
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x002b
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
73.252799
      ATT: Read Request (0x0a) len 2
        Handle: 0x0016
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
73.319491
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 5                      [hci0]
73.387062
      ATT: Read Response (0x0b) len 0
        Value:
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
73.387421
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0017-0x0018
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
73.454437
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 14                     [hci0]
73.522949
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x0017
        UUID: Client Characteristic Configuration (0x2902)
        Handle: 0x0018
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
73.523309
      ATT: Read Request (0x0a) len 2
        Handle: 0x001a
> ACL Data RX: Handle 1 flags 0x02 dlen 16                     [hci0]
73.591406
      LE L2CAP: Connection Parameter Update Request (0x12) ident 2 len 8
        Min interval: 6
        Max interval: 6
        Slave latency: 60
        Timeout multiplier: 300
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
73.591424
        Num handles: 1
        Handle: 1
        Count: 1
< ACL Data TX: Handle 1 flags 0x00 dlen 10                     [hci0]
73.591512
      LE L2CAP: Connection Parameter Update Response (0x13) ident 2 len 2
        Result: Connection Parameters accepted (0x0000)
< HCI Command: LE Connection Update (0x08|0x0013) plen 14      [hci0]
73.591525
        Handle: 1
        Min connection interval: 7.50 msec (0x0006)
        Max connection interval: 7.50 msec (0x0006)
        Connection latency: 0x003c
        Supervision timeout: 3000 msec (0x012c)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
@ New Conn Param: F5:95:EC:5D:0F:D3 (2) hint 1 min 0x0006 max 0x0006
latency 0x003c timeout 0x012c
> HCI Event: Command Status (0x0f) plen 4                      [hci0]
73.599539
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 1 flags 0x02 dlen 5                      [hci0]
73.724738
      ATT: Read Response (0x0b) len 0
        Value:
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
73.725072
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001b-0x001c
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
73.792598
        Num handles: 1
        Handle: 1
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
73.859373
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 14                     [hci0]
73.927886
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x001b
        UUID: Client Characteristic Configuration (0x2902)
        Handle: 0x001c
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
73.928248
      ATT: Read Request (0x0a) len 2
        Handle: 0x001e
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
73.995803
        Num handles: 1
        Handle: 1
        Count: 1
> HCI Event: LE Meta Event (0x3e) plen 10                      [hci0]
73.995817
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 1
        Connection interval: 7.50 msec (0x0006)
        Connection latency: 75.00 msec (0x003c)
        Supervision timeout: 3000 msec (0x012c)
> ACL Data RX: Handle 1 flags 0x02 dlen 5                      [hci0]
74.069660
      ATT: Read Response (0x0b) len 0
        Value:
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
74.070064
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001f-0x001f
> ACL Data RX: Handle 1 flags 0x02 dlen 10                     [hci0]
74.542546
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x001f
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
74.542973
      ATT: Read Request (0x0a) len 2
        Handle: 0x0021
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
74.549640
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 5                      [hci0]
74.557107
      ATT: Read Response (0x0b) len 0
        Value:
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
74.557465
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0022-0x0022
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
74.564356
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 10                     [hci0]
74.572608
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0022
        UUID: Report Reference (0x2908)
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
74.572968
      ATT: Read Request (0x0a) len 2
        Handle: 0x0024
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
74.579593
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
74.589327
      ATT: Read Response (0x0b) len 22
        Value: 05010902a10105010902a102851a0901a10005091901
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
74.589688
      ATT: Read Request (0x0a) len 2
        Handle: 0x0014
> ACL Data RX: Handle 1 flags 0x02 dlen 6                      [hci0]
75.059972
      ATT: Read Response (0x0b) len 1
        Value: 01
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
75.060353
      ATT: Read Request (0x0a) len 2
        Handle: 0x0029
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
75.066971
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      [hci0]
75.074901
      ATT: Read Response (0x0b) len 4
        Value: 01010003
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
75.075257
      ATT: Read Request (0x0a) len 2
        Handle: 0x0018
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
75.082131
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 7                      [hci0]
75.090148
      ATT: Read Response (0x0b) len 2
        Value: 1a01
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
75.090513
      ATT: Read Request (0x0a) len 2
        Handle: 0x001c
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
75.096994
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 7                      [hci0]
75.104749
      ATT: Read Response (0x0b) len 2
        Value: 2701
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
75.105121
      ATT: Read Request (0x0a) len 2
        Handle: 0x001f
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
75.111899
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 7                      [hci0]
75.119756
      ATT: Read Response (0x0b) len 2
        Value: 2203
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
75.120156
      ATT: Read Request (0x0a) len 2
        Handle: 0x0022
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
75.127135
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 7                      [hci0]
75.134857
      ATT: Read Response (0x0b) len 2
        Value: 2403
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
75.135229
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0024
        Offset: 0x0016
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
75.149659
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
75.159073
      ATT: Read Blob Response (0x0d) len 22
        29 05 95 05 75 01 15 00 25 01 81 02 75 03 95 01  )...u...%...u...
        81 01 05 01 09 30                                .....0
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
75.159485
      ATT: Read Request (0x0a) len 2
        Handle: 0x0017
> ACL Data RX: Handle 1 flags 0x02 dlen 7                      [hci0]
75.629710
      ATT: Read Response (0x0b) len 2
        Value: 0000
< ACL Data TX: Handle 1 flags 0x00 dlen 7                      [hci0]
75.630157
      ATT: Read Request (0x0a) len 2
        Handle: 0x001b
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
75.636845
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 7                      [hci0]
75.644908
      ATT: Read Response (0x0b) len 2
        Value: 0000
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
75.645224
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0024
        Offset: 0x002c
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
75.651910
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
75.661587
      ATT: Read Blob Response (0x0d) len 22
        09 31 95 02 75 10 16 01 80 26 ff 7f 81 06 a1 02  .1..u....&......
        85 1a 09 38 35 00                                ...85.
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
75.661866
      ATT: Write Request (0x12) len 4
        Handle: 0x0017
          Data: 0100
> ACL Data RX: Handle 1 flags 0x02 dlen 5                      [hci0]
76.132205
      ATT: Write Response (0x13) len 0
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
76.132488
      ATT: Write Request (0x12) len 4
        Handle: 0x001b
          Data: 0100
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
76.139397
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 5                      [hci0]
76.147080
      ATT: Write Response (0x13) len 0
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
76.147363
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0024
        Offset: 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
76.154433
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
76.164326
      ATT: Read Blob Response (0x0d) len 22
        45 00 95 01 75 10 16 01 80 26 ff 7f 81 06 c0 a1  E...u....&......
        02 85 1a 05 0c 95                                ......
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
76.164618
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0024
        Offset: 0x0058
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
76.636564
      ATT: Read Blob Response (0x0d) len 22
        01 75 10 16 01 80 26 ff 7f 0a 38 02 81 06 c0 c0  .u....&...8.....
        c0 c0 06 bc ff 09                                ......
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
76.636864
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0024
        Offset: 0x006e
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     [hci0]
77.109219
      ATT: Read Blob Response (0x0d) len 22
        88 a1 01 85 22 06 00 ff 15 00 26 ff 00 75 08 95  ....".....&..u..
        13 0a 0a fa b1 02                                ......
< ACL Data TX: Handle 1 flags 0x00 dlen 9                      [hci0]
77.109532
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0024
        Offset: 0x0084
> ACL Data RX: Handle 1 flags 0x02 dlen 26                     [hci0]
77.581736
      ATT: Read Blob Response (0x0d) len 21
        85 24 06 00 ff 0a 0a fa b1 02 85 27 06 00 ff 0a  .$.........'....
        0a fa 81 02 c0                                   .....
> ACL Data RX: Handle 1 flags 0x02 dlen 16                     [hci0]
91.897992
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100000000000000
... ( snip Mouse movement reports continue)...
> ACL Data RX: Handle 1 flags 0x02 dlen 16                     [hci0]
93.113028
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000500030000000000
> ACL Data RX: Handle 1 flags 0x02 dlen 16                     [hci0]
93.120639
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000200010000000000
> ACL Data RX: Handle 1 flags 0x02 dlen 16                     [hci0]
93.127978
      ATT: Handle Value Notification (0x1b) len 11
        Handle: 0x0016
          Data: 000100010000000000
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0]
98.788720
        Handle: 1
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0]
98.795175
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Add Device To White.. (0x08|0x0011) plen 7  [hci0]
188.669226
        Address type: Random (0x01)
        Address: F5:95:EC:5D:0F:D3 (Static)
@ Device Added: F5:95:EC:5D:0F:D3 (2) 2
> HCI Event: Command Complete (0x0e) plen 4                   [hci0]
188.676819
      LE Add Device To White List (0x08|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7    [hci0]
188.676888
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0]
188.681718
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        [hci0]
188.681782
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                   [hci0]
188.686100
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2        [hci0]
193.634834
************************** btmon logs end
**************************************

Thanks,
Naveen
