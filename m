Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/10] GATT: Optimize discovery
Date: Tue,  9 May 2017 23:48:30 +0300
Message-Id: <20170509204840.3270-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reduces quite a bit the complexity of GATT discovery while
reducing the amount traffic, this is achieved by using breadth-first
like lookup.

Bellow is the traces with using Zephyr peripheral sample which
uses a somewhat small MTU (65 bytes), it probably has even better
results when using bigger MTU.

Luiz Augusto von Dentz (10):
  shared/gatt-db: Add gatt_db_get_service
  shared/gatt-db: Add gatt_db_service_insert_included
  shared/gatt-client: Insert included attribute with handle
  shared/gatt-db: Add gatt_db_insert_included
  shared/gatt-client: Simplify included discovery
  unit/test-gatt: Adjust the PDUs to the new behavior
  shared/gatt-db: Add gatt_db_insert_characteristic
  shared/gatt-db: Add gatt_db_insert_descriptor
  shared/gatt-client: Simplify characteristics discovery
  unit/test-gatt: Adjust the PDUs for characteristic discovery

 src/shared/gatt-client.c | 215 +++++++++++------------------------------------
 src/shared/gatt-db.c     | 116 ++++++++++++++++++++++---
 src/shared/gatt-db.h     |  30 +++++++
 unit/test-gatt.c         |  86 ++++++++-----------
 4 files changed, 220 insertions(+), 227 deletions(-)

=== Before (~5 seconds) ===

[NEW] Primary Service
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0006
	0000180d-0000-1000-8000-00805f9b34fb
	Heart Rate
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0006/char0007
	00002a37-0000-1000-8000-00805f9b34fb
	Heart Rate Measurement
[NEW] Descriptor
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0006/char0007/desc0009
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0006/char000a
	00002a38-0000-1000-8000-00805f9b34fb
	Body Sensor Location
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0006/char000c
	00002a39-0000-1000-8000-00805f9b34fb
	Heart Rate Control Point
[NEW] Primary Service
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service000e
	0000180f-0000-1000-8000-00805f9b34fb
	Battery Service
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service000e/char000f
	00002a19-0000-1000-8000-00805f9b34fb
	Battery Level
[NEW] Descriptor
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service000e/char000f/desc0011
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[NEW] Primary Service
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0012
	00001805-0000-1000-8000-00805f9b34fb
	Current Time Service
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0012/char0013
	00002a2b-0000-1000-8000-00805f9b34fb
	Current Time
[NEW] Descriptor
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0012/char0013/desc0015
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[NEW] Primary Service
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0016
	0000180a-0000-1000-8000-00805f9b34fb
	Device Information
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0016/char0017
	00002a24-0000-1000-8000-00805f9b34fb
	Model Number String
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0016/char0019
	00002a29-0000-1000-8000-00805f9b34fb
	Manufacturer Name String
[NEW] Primary Service
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b
	12345678-1234-5678-1234-56789abcdef0
	Vendor specific
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char001c
	12345678-1234-5678-1234-56789abcdef1
	Vendor specific
[NEW] Descriptor
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char001c/desc001e
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char001f
	12345678-1234-5678-1234-56789abcdef2
	Vendor specific
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char0021
	12345678-1234-5678-1234-56789abcdef3
	Vendor specific
[NEW] Descriptor
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char0021/desc0023
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char0024
	13345678-1234-5678-1334-56789abcdef3
	Vendor specific

< ACL Data TX: Handle 76 flags 0x00 dlen 7                                                                         #24 15:51:07.180686
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> ACL Data RX: Handle 76 flags 0x02 dlen 7                                                                         #26 15:51:07.295081
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 65
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #27 15:51:07.332810
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 76 flags 0x02 dlen 27                                                                        #29 15:51:07.435148
> ACL Data RX: Handle 76 flags 0x01 dlen 9                                                                         #30 15:51:07.435715
      ATT: Read By Group Type Response (0x11) len 31
        Attribute data length: 6
        Attribute group list: 5 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x000d
        UUID: Heart Rate (0x180d)
        Handle range: 0x000e-0x0011
        UUID: Battery Service (0x180f)
        Handle range: 0x0012-0x0015
        UUID: Current Time Service (0x1805)
        Handle range: 0x0016-0x001a
        UUID: Device Information (0x180a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #31 15:51:07.444516
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x001b-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 76 flags 0x02 dlen 26                                                                        #33 15:51:07.575218
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x001b-0x0025
        UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef0)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #34 15:51:07.577256
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0026-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #36 15:51:07.715060
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0026
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #37 15:51:07.733790
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Secondary Service (0x2801)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #39 15:51:07.861760
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #40 15:51:07.873951
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0005
        Attribute type: Include (0x2802)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #42 15:51:07.995639
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #43 15:51:07.998681
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0006-0x000d
        Attribute type: Include (0x2802)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #45 15:51:08.135117
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0006
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #46 15:51:08.137222
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0x0011
        Attribute type: Include (0x2802)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #48 15:51:08.281940
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000e
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #49 15:51:08.284618
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0012-0x0015
        Attribute type: Include (0x2802)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #51 15:51:08.415537
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0012
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #52 15:51:08.417313
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0016-0x001a
        Attribute type: Include (0x2802)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #54 15:51:08.555069
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0016
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #55 15:51:08.555910
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001b-0x0025
        Attribute type: Include (0x2802)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #57 15:51:08.695065
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x001b
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #58 15:51:08.700168
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0005
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 20                                                                        #60 15:51:08.835157
      ATT: Read By Type Response (0x09) len 15
        Attribute data length: 7
        Attribute data list: 2 entries
        Handle: 0x0002
        Value: 020300002a
        Handle: 0x0004
        Value: 020500012a
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #61 15:51:08.840512
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0005-0x0005
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #63 15:51:08.975572
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0005
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #64 15:51:09.011545
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0006-0x000d
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 27                                                                        #66 15:51:09.115727
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0007
        Value: 100800372a
        Handle: 0x000a
        Value: 020b00382a
        Handle: 0x000c
        Value: 080d00392a
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #67 15:51:09.118416
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000d-0x000d
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #69 15:51:09.255079
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000d
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 9                                                                         #70 15:51:09.260958
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0009-0x0009
> ACL Data RX: Handle 76 flags 0x02 dlen 10                                                                        #72 15:51:09.395088
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0009
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #73 15:51:09.412720
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0x0011
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 13                                                                        #75 15:51:09.535534
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: 121000192a
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #76 15:51:09.537262
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0x0011
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #78 15:51:09.745068
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 9                                                                         #79 15:51:09.747585
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0011-0x0011
> ACL Data RX: Handle 76 flags 0x02 dlen 10                                                                        #81 15:51:09.891777
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0011
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #82 15:51:09.894557
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0012-0x0015
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 13                                                                        #84 15:51:10.025331
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0013
        Value: 1a14002b2a
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #85 15:51:10.026486
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0014-0x0015
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #87 15:51:10.165084
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0014
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 9                                                                         #88 15:51:10.170516
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0015-0x0015
> ACL Data RX: Handle 76 flags 0x02 dlen 10                                                                        #90 15:51:10.305095
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0015
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #91 15:51:10.307514
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0016-0x001a
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 20                                                                        #93 15:51:10.445389
      ATT: Read By Type Response (0x09) len 15
        Attribute data length: 7
        Attribute data list: 2 entries
        Handle: 0x0017
        Value: 021800242a
        Handle: 0x0019
        Value: 021a00292a
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #94 15:51:10.445973
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001a-0x001a
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                         #96 15:51:10.585123
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x001a
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                        #97 15:51:10.594292
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001b-0x0025
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 27                                                                        #99 15:51:10.725259
> ACL Data RX: Handle 76 flags 0x01 dlen 21                                                                       #100 15:51:10.725896
      ATT: Read By Type Response (0x09) len 43
        Attribute data length: 21
        Attribute data list: 2 entries
        Handle: 0x001c
        Value: 2a1d00f1debc9a785634127856341278563412
        Handle: 0x001f
        Value: 0a2000f2debc9a785634127856341278563412
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                       #101 15:51:10.728654
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0020-0x0025
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 27                                                                       #103 15:51:10.865172
> ACL Data RX: Handle 76 flags 0x01 dlen 21                                                                       #104 15:51:10.866134
      ATT: Read By Type Response (0x09) len 43
        Attribute data length: 21
        Attribute data list: 2 entries
        Handle: 0x0021
        Value: 8a2200f3debc9a785634127856341278563412
        Handle: 0x0024
        Value: 4a2500f3debc9a785634137856341278563413
< ACL Data TX: Handle 76 flags 0x00 dlen 11                                                                       #105 15:51:10.867215
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0025-0x0025
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                                                                        #107 15:51:11.011665
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0025
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 9                                                                        #108 15:51:11.020693
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001e-0x001e
> ACL Data RX: Handle 76 flags 0x02 dlen 10                                                                       #110 15:51:11.145086
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x001e
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 76 flags 0x00 dlen 9                                                                        #111 15:51:11.147455
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0023-0x0023
> ACL Data RX: Handle 76 flags 0x02 dlen 10                                                                       #113 15:51:11.285087
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0023
        UUID: Characteristic Extended Properties (0x2900)
< ACL Data TX: Handle 76 flags 0x00 dlen 7                                                                        #114 15:51:11.292722
      ATT: Read Request (0x0a) len 2
        Handle: 0x0023
> ACL Data RX: Handle 76 flags 0x02 dlen 7                                                                        #116 15:51:11.432110
      ATT: Read Response (0x0b) len 2
        Value: 0100
< ACL Data TX: Handle 76 flags 0x00 dlen 7                                                                        #117 15:51:11.568202
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
> ACL Data RX: Handle 76 flags 0x02 dlen 20                                                                       #119 15:51:11.705683
      ATT: Read Response (0x0b) len 15
        Value: 54657374207065726970686572616c
< ACL Data TX: Handle 76 flags 0x00 dlen 7                                                                        #120 15:51:11.712575
      ATT: Read Request (0x0a) len 2
        Handle: 0x0005
> ACL Data RX: Handle 76 flags 0x02 dlen 7                                                                        #122 15:51:11.851670
      ATT: Read Response (0x0b) len 2
        Value: 4103

=== After (~3 seconds) ===

[NEW] Primary Service
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0006
	0000180d-0000-1000-8000-00805f9b34fb
	Heart Rate
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0006/char0007
	00002a37-0000-1000-8000-00805f9b34fb
	Heart Rate Measurement
[NEW] Descriptor
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0006/char0007/desc0009
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0006/char000a
	00002a38-0000-1000-8000-00805f9b34fb
	Body Sensor Location
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0006/char000c
	00002a39-0000-1000-8000-00805f9b34fb
	Heart Rate Control Point
[NEW] Primary Service
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service000e
	0000180f-0000-1000-8000-00805f9b34fb
	Battery Service
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service000e/char000f
	00002a19-0000-1000-8000-00805f9b34fb
	Battery Level
[NEW] Descriptor
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service000e/char000f/desc0011
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[NEW] Primary Service
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0012
	00001805-0000-1000-8000-00805f9b34fb
	Current Time Service
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0012/char0013
	00002a2b-0000-1000-8000-00805f9b34fb
	Current Time
[NEW] Descriptor
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0012/char0013/desc0015
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[NEW] Primary Service
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0016
	0000180a-0000-1000-8000-00805f9b34fb
	Device Information
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0016/char0017
	00002a24-0000-1000-8000-00805f9b34fb
	Model Number String
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service0016/char0019
	00002a29-0000-1000-8000-00805f9b34fb
	Manufacturer Name String
[NEW] Primary Service
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b
	12345678-1234-5678-1234-56789abcdef0
	Vendor specific
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char001c
	12345678-1234-5678-1234-56789abcdef1
	Vendor specific
[NEW] Descriptor
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char001c/desc001e
	00002902-0000-1000-8000-00805f9b34fb
	Client Characteristic Configuration
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char001f
	12345678-1234-5678-1234-56789abcdef2
	Vendor specific
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char0021
	12345678-1234-5678-1234-56789abcdef3
	Vendor specific
[NEW] Descriptor
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char0021/desc0023
	00002900-0000-1000-8000-00805f9b34fb
	Characteristic Extended Properties
[NEW] Characteristic
	/org/bluez/hci0/dev_5A_7F_DE_51_75_60/service001b/char0024
	13345678-1234-5678-1334-56789abcdef3
	Vendor specific

< ACL Data TX: Handle 76 flags 0x00 dlen 7                          #380 15:42:10.341758
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> ACL Data RX: Handle 76 flags 0x02 dlen 7                          #382 15:42:10.473974
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 65
< ACL Data TX: Handle 76 flags 0x00 dlen 11                         #383 15:42:10.517274
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 76 flags 0x02 dlen 27                         #385 15:42:10.614040
> ACL Data RX: Handle 76 flags 0x01 dlen 9                          #386 15:42:10.614164
      ATT: Read By Group Type Response (0x11) len 31
        Attribute data length: 6
        Attribute group list: 5 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x000d
        UUID: Heart Rate (0x180d)
        Handle range: 0x000e-0x0011
        UUID: Battery Service (0x180f)
        Handle range: 0x0012-0x0015
        UUID: Current Time Service (0x1805)
        Handle range: 0x0016-0x001a
        UUID: Device Information (0x180a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                         #387 15:42:10.621084
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x001b-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 76 flags 0x02 dlen 26                         #389 15:42:10.754092
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x001b-0x0025
        UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef0)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                         #390 15:42:10.758998
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0026-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                          #392 15:42:10.893951
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0026
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                         #393 15:42:10.940594
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Secondary Service (0x2801)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                          #395 15:42:11.033493
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                         #396 15:42:11.038975
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Include (0x2802)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                          #398 15:42:11.173677
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 11                         #399 15:42:11.192954
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 27                         #401 15:42:11.313573
> ACL Data RX: Handle 76 flags 0x01 dlen 27                         #402 15:42:11.314233
> ACL Data RX: Handle 76 flags 0x01 dlen 8                          #403 15:42:11.321496
      ATT: Read By Type Response (0x09) len 57
        Attribute data length: 7
        Attribute data list: 8 entries
        Handle: 0x0002
        Value: 020300002a
        Handle: 0x0004
        Value: 020500012a
        Handle: 0x0007
        Value: 100800372a
        Handle: 0x000a
        Value: 020b00382a
        Handle: 0x000c
        Value: 080d00392a
        Handle: 0x000f
        Value: 121000192a
        Handle: 0x0013
        Value: 1a14002b2a
        Handle: 0x0017
        Value: 021800242a
< ACL Data TX: Handle 76 flags 0x00 dlen 11                         #404 15:42:11.329596
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0018-0xffff
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 13                         #406 15:42:11.453695
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0019
        Value: 021a00292a
< ACL Data TX: Handle 76 flags 0x00 dlen 11                         #407 15:42:11.456347
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001a-0xffff
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 27                         #409 15:42:11.593920
> ACL Data RX: Handle 76 flags 0x01 dlen 21                         #410 15:42:11.594382
      ATT: Read By Type Response (0x09) len 43
        Attribute data length: 21
        Attribute data list: 2 entries
        Handle: 0x001c
        Value: 2a1d00f1debc9a785634127856341278563412
        Handle: 0x001f
        Value: 0a2000f2debc9a785634127856341278563412
< ACL Data TX: Handle 76 flags 0x00 dlen 11                         #411 15:42:11.598132
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0020-0xffff
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 27                         #413 15:42:11.733813
> ACL Data RX: Handle 76 flags 0x01 dlen 21                         #414 15:42:11.734279
      ATT: Read By Type Response (0x09) len 43
        Attribute data length: 21
        Attribute data list: 2 entries
        Handle: 0x0021
        Value: 8a2200f3debc9a785634127856341278563412
        Handle: 0x0024
        Value: 4a2500f3debc9a785634137856341278563413
< ACL Data TX: Handle 76 flags 0x00 dlen 11                         #415 15:42:11.737344
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0025-0xffff
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 76 flags 0x02 dlen 9                          #417 15:42:11.880388
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0025
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 76 flags 0x00 dlen 9                          #418 15:42:11.933241
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0009-0x0009
> ACL Data RX: Handle 76 flags 0x02 dlen 10                         #420 15:42:12.013704
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0009
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 76 flags 0x00 dlen 9                          #421 15:42:12.030887
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0011-0x0011
> ACL Data RX: Handle 76 flags 0x02 dlen 10                         #423 15:42:12.153980
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0011
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 76 flags 0x00 dlen 9                          #424 15:42:12.161328
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0015-0x0015
> ACL Data RX: Handle 76 flags 0x02 dlen 10                         #426 15:42:12.293534
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0015
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 76 flags 0x00 dlen 9                          #427 15:42:12.295493
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x001e-0x001e
> ACL Data RX: Handle 76 flags 0x02 dlen 10                         #429 15:42:12.433681
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x001e
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 76 flags 0x00 dlen 9                          #430 15:42:12.437015
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0023-0x0023
> ACL Data RX: Handle 76 flags 0x02 dlen 10                         #432 15:42:12.643547
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0023
        UUID: Characteristic Extended Properties (0x2900)
< ACL Data TX: Handle 76 flags 0x00 dlen 7                          #433 15:42:12.668272
      ATT: Read Request (0x0a) len 2
        Handle: 0x0023
> ACL Data RX: Handle 76 flags 0x02 dlen 7                          #435 15:42:12.783946
      ATT: Read Response (0x0b) len 2
        Value: 0100
< ACL Data TX: Handle 76 flags 0x00 dlen 7                          #436 15:42:12.941349
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
> ACL Data RX: Handle 76 flags 0x02 dlen 20                         #438 15:42:13.064155
      ATT: Read Response (0x0b) len 15
        Value: 54657374207065726970686572616c

-- 
2.9.3

