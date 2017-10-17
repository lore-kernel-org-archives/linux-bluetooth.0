Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1508258502.5910.68.camel@hadess.net>
Subject: Surface 3 Pen (BLE HID) not sending events
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 17 Oct 2017 18:41:42 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

The Surface 3 pen (part of the 2nd generation of Surface pens[1]) uses
Bluetooth LE for its top button, which one can assign to a function,
usually a note taking application on Windows.

After pairing, bluez throws away all the characteristics, UUIDs and
other properties it gathered[2].

Subsequent attempts at pressing the pen button just throws a wobbly[3].

Any ideas? This apparently used to work, and there's some very hacky
solutions for those devices:
https://github.com/frebib/surface-scripts/blob/master/pend

Cheers

[1]: https://en.wikipedia.org/wiki/Surface_Pen#Second_generation
[2]:

# pair C5:2A:C6:5C:CC:BD
Attempting to pair with C5:2A:C6:5C:CC:BD
[CHG] Device C5:2A:C6:5C:CC:BD Connected: yes
[CHG] Device C5:2A:C6:5C:CC:BD UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device C5:2A:C6:5C:CC:BD UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device C5:2A:C6:5C:CC:BD UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
[CHG] Device C5:2A:C6:5C:CC:BD UUIDs: 00001812-0000-1000-8000-00805f9b34fb
[CHG] Device C5:2A:C6:5C:CC:BD ServicesResolved: yes
[CHG] Device C5:2A:C6:5C:CC:BD Paired: yes
[NEW] Primary Service
	/org/bluez/hci0/dev_C5_2A_C6_5C_CC_BD/service0008
	00001801-0000-1000-8000-00805f9b34fb
	Generic Attribute Profile
[NEW] Characteristic
	/org/bluez/hci0/dev_C5_2A_C6_5C_CC_BD/service0008/char0009
	00002a05-0000-1000-8000-00805f9b34fb
	Service Changed
[NEW] Descriptor
	/org/bluez/hci0/dev_C5_2A_C6_5C_CC_BD/service0008/char0009/desc000b
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[NEW] Primary Service
	/org/bluez/hci0/dev_C5_2A_C6_5C_CC_BD/service000c
	0000180a-0000-1000-8000-00805f9b34fb
	Device Information
[NEW] Characteristic
	/org/bluez/hci0/dev_C5_2A_C6_5C_CC_BD/service000c/char000d
	00002a29-0000-1000-8000-00805f9b34fb
	Manufacturer Name String
[NEW] Characteristic
	/org/bluez/hci0/dev_C5_2A_C6_5C_CC_BD/service000c/char000f
	00002a27-0000-1000-8000-00805f9b34fb
	Hardware Revision String
[NEW] Characteristic
	/org/bluez/hci0/dev_C5_2A_C6_5C_CC_BD/service000c/char0011
	00002a26-0000-1000-8000-00805f9b34fb
	Firmware Revision String
[NEW] Characteristic
	/org/bluez/hci0/dev_C5_2A_C6_5C_CC_BD/service000c/char0013
	00002a50-0000-1000-8000-00805f9b34fb
	PnP ID
Pairing successful
[CHG] Device C5:2A:C6:5C:CC:BD Modalias: usb:v045Ep07C5d0001
[CHG] Device C5:2A:C6:5C:CC:BD ServicesResolved: no
[CHG] Device C5:2A:C6:5C:CC:BD Connected: no

[3]:

HCI sniffer - Bluetooth packet analyzer ver 5.47
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      ADV_DIRECT_IND - Connectable directed advertising (1)
      bdaddr C5:2A:C6:5C:CC:BD (Random)
      RSSI: -67
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x00 (disabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 2
    status 0x00
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr C5:2A:C6:5C:CC:BD type 1
    interval 96 window 96 initiator_filter 0
    own_bdaddr_type 0 min_interval 6 max_interval 6
    latency 0 supervision_to 50 min_ce 0 max_ce 0
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 2
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 3585, role master
      bdaddr C5:2A:C6:5C:CC:BD (Random)
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
  0000: 01 0e                                             ..
> HCI Event: Command Status (0x0f) plen 4
    LE Read Remote Used Features (0x08|0x0016) status 0x00 ncmd 1
< HCI Command: LE Remove Device From White List (0x08|0x0012) plen 7
  0000: 01 bd cc 5c c6 2a c5                              ...\.*.
> HCI Event: Command Complete (0x0e) plen 4
    LE Remove Device From White List (0x08|0x0012) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
    type 0x00 (passive)
    interval 60.000ms window 30.000ms
    own address: 0x00 (Public) policy: white list only
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x01 (scanning enabled)
    filter duplicates 0x01 (enabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 2
    status 0x00
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Read Remote Used Features Complete
      status 0x00 handle 3585
      Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
  0000: 01 0e 89 54 5e 69 a3 8e  13 1a 0d 3e 31 df c1
e7  ...T^i.....>1...
  0010: a2 a4 ab a1 f9 b2 54 35  dc 20 36 2b              ......T5. 6+
> HCI Event: Command Status (0x0f) plen 4
    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 3585 encrypt 0x01
< ACL data: handle 3585 flags 0x00 dlen 7
    ATT: MTU req (0x02)
      client rx mtu 517
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 3585 packets 1
> ACL data: handle 3585 flags 0x02 dlen 7
    ATT: MTU resp (0x03)
      server rx mtu 23
< ACL data: handle 3585 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0001, end 0xffff
      type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 3585 packets 1
> ACL data: handle 3585 flags 0x02 dlen 24
    ATT: Read By Group resp (0x11)
      attr handle 0x0001, end group handle 0x0007
      value 0x00 0x18
      attr handle 0x0008, end group handle 0x000b
      value 0x01 0x18
      attr handle 0x000c, end group handle 0x0014
      value 0x0a 0x18
< ACL data: handle 3585 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0015, end 0xffff
      type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 3585 packets 1
> ACL data: handle 3585 flags 0x02 dlen 12
    ATT: Read By Group resp (0x11)
      attr handle 0x0015, end group handle 0xffff
      value 0x12 0x18
< ACL data: handle 3585 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0001, end 0xffff
      type-uuid 0x2801
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 3585 packets 1
> ACL data: handle 3585 flags 0x02 dlen 9
    ATT: Error (0x01)
      Error: Attribute not found (10)
      Read By Group req (0x10) on handle 0x0001
< ACL data: handle 3585 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0001, end 0xffff
      type-uuid 0x2802
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 3585 packets 1
> ACL data: handle 3585 flags 0x02 dlen 9
    ATT: Error (0x01)
      Error: Attribute not found (10)
      Read By Type req (0x08) on handle 0x0001
< ACL data: handle 3585 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0001, end 0xffff
      type-uuid 0x2803
> ACL data: handle 3585 flags 0x02 dlen 15
    ATT: Handle notify (0x1b)
      handle 0x0019
      value 0x08 0x00 0x6f 0x00 0x00 0x00 0x00 0x00 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 3585 packets 1
> ACL data: handle 3585 flags 0x02 dlen 15
    ATT: Handle notify (0x1b)
      handle 0x0019
      value 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
> ACL data: handle 3585 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 7
        handle 0x0002, value 0x0a 0x03 0x00 0x00 0x2a 
        handle 0x0004, value 0x02 0x05 0x00 0x01 0x2a 
        handle 0x0006, value 0x02 0x07 0x00 0x04 0x2a 
< ACL data: handle 3585 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0007, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 3585 packets 1
> ACL data: handle 3585 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 7
        handle 0x0009, value 0x20 0x0a 0x00 0x05 0x2a 
        handle 0x000d, value 0x02 0x0e 0x00 0x29 0x2a 
        handle 0x000f, value 0x02 0x10 0x00 0x27 0x2a 
< ACL data: handle 3585 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0010, end 0xffff
      type-uuid 0x2803
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 3585 reason 0x08
    Reason: Connection Timeout
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x00 (disabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 2
    status 0x00
< HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
  0000: 01 bd cc 5c c6 2a c5                              ...\.*.
> HCI Event: Command Complete (0x0e) plen 4
    LE Add Device To White List (0x08|0x0011) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
    type 0x00 (passive)
    interval 60.000ms window 30.000ms
    own address: 0x00 (Public) policy: white list only
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x01 (scanning enabled)
    filter duplicates 0x01 (enabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 2
    status 0x00
