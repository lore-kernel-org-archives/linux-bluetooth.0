Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 22:48:03 +0200
From: "B. K. Lohse" <lolium@gmx.net>
To: linux-bluetooth@vger.kernel.org
Subject: [REGRESSION] btusb: no pairing possible (link tx timeout / killing
 stalled connection)
Message-Id: <20120405224803.9df36850.lolium@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all, 

there is a problem with recent linux+bluez and "Broadcom Corp.
IBM Integrated Bluetooth IV" host adapter (USB ID: 0a5c:201e). 
Though i can scan for devices successfully its not possible to pair
with them (a mouse in my case). This mouse works flawlessly with other
btusb-based dongles and the same setup:

Gentoo Linux 3.3.1 i686
Bluez 4.99
Blueman 1.21 (blueman-project.org)

Latest known working linux kernel with that dongle was 2.6.29 
(and quite old bluez of course).
So for now the pairing process just times out with a dbus-error 
(did not receive a reply ...) and most obvious message from
dmesg:

[14411.464739] Bluetooth: hci0 link tx timeout
[14411.464750] Bluetooth: hci0 killing stalled
connection 00:60:D1:00:10:01 
[14582.338025] Bluetooth: hci0 command tx timeout

I can see incoming and outgoing traffic via hciconfig, but the
notebook's BT-indicator-LED doesnt blink, which is
probably not a good sign.

Below i attached some debug information and a
hcidump session while pairing fails.

I will provide you any further information that hopefully helps tracking
this issue down.

Regards
Burkhard

---
# lsusb: (snipped)
Bus 004 Device 012: ID 0a5c:201e Broadcom Corp. IBM Integrated
Bluetooth IV

# lsusb -v -d 0a5c:201e
Bus 004 Device 012: ID 0a5c:201e Broadcom Corp. IBM Integrated
Bluetooth IV Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0a5c Broadcom Corp.
  idProduct          0x201e IBM Integrated Bluetooth IV
  bcdDevice            0.09
  iManufacturer           1 Broadcom
  iProduct                2 IBM Bluetooth Module
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          216
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes


Bluetooth IV Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0a5c Broadcom Corp.
  idProduct          0x201e IBM Integrated Bluetooth IV
  bcdDevice            0.09
  iManufacturer           1 Broadcom
  iProduct                2 IBM Bluetooth Module
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          216
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes

#hciconfig -a
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:0E:9B:D9:4A:71  ACL MTU: 377:10  SCO MTU: 64:8
	UP RUNNING PSCAN 
	RX bytes:1839 acl:0 sco:0 events:56 errors:0
	TX bytes:509 acl:0 sco:0 commands:56 errors:0
	Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: 
	Link mode: SLAVE ACCEPT 
	Name: 'horus'
	Class: 0x420100
	Service Classes: Networking, Telephony
	Device Class: Computer, Uncategorized
	HCI Version: 1.2 (0x2)  Revision: 0x9
	LMP Version: 1.2 (0x2)  Subversion: 0x6963
	Manufacturer: Broadcom Corporation (15)

#hcidump
HCI sniffer - Bluetooth packet analyzer ver 2.2
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8d class 0x002580
rssi 43
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8d class 0x002580
rssi 50
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8e class 0x002580
rssi 42
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8d class 0x002580
rssi 50
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8d class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8f class 0x002580
rssi 33
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8f class 0x002580
rssi 34
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8e class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8f class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8f class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c8f class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c90 class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c90 class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c90 class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c91 class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c90 class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c91 class 0x002580
rssi 36
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:60:D1:00:10:01 mode 1 clkoffset 0x4c92 class 0x002580
rssi 36
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:60:D1:00:10:01 ptype 0xcc18 rswitch 0x01 clkoffset 0x4c92
(valid) Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:60:D1:00:10:01 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 6
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 6
    Features: 0xaf 0x00 0x00 0x38 0x08 0x08 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:60:D1:00:10:01 mode 2 clkoffset 0x0000
< ACL data: handle 6 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0050 flags 0x00 clen 0
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:60:D1:00:10:01 name 'BT Optical Mou09'
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 48  
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48  
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0050 flags 0x00 result 0 clen 4
      MTU 48  
< ACL data: handle 6 flags 0x02 dlen 24
    L2CAP(d): cid 0x0050 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 6 rssi 4
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 6 lq 255
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 6 type 0 (current)
> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 6 level 0
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          count 38
          cont 02 00 26
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0050 len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 26
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2b
          count 38
          cont 02 00 4C
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0050 len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 4C
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x2b
          count 38
          cont 02 00 72
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0050 len 22 [psm 1]
        SDP SSA Req: tid 0x3 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 72
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x3 len 0x2b
          count 38
          cont 02 00 98
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0050 len 22 [psm 1]
        SDP SSA Req: tid 0x4 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 98
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x4 len 0x2b
          count 38
          cont 02 00 BE
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0050 len 22 [psm 1]
        SDP SSA Req: tid 0x5 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 BE
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x5 len 0x2b
        SDP SSA Rsp: tid 0x5 len 0x2b
          count 38
          cont 02 00 E4
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 6 rssi 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 6 lq 255
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 6 type 0 (current)
> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 6 level 0
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 6 rssi 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 6 lq 255
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 6 type 0 (current)
> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 6 level 0
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 6 rssi 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 6 lq 255
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 6 type 0 (current)
> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 6 level 0
< HCI Command: Read RSSI (0x05|0x0005) plen 2
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 6 rssi 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 6 lq 255
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 6 type 0 (current)
> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 6 level 0
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 6 rssi 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 6 lq 255
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 6 type 0 (current)
> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 6 level 0
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 6 rssi 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 6 lq 255
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 6 type 0 (current)
> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 6 level 0
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
tatus 0x00 handle 6 rssi 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 6 lq 255
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 6 type 0 (current)
> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 6 level 0
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 6 rssi 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 6 lq 255
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 6 type 0 (current)
> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 6 level 0
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 6 rssi 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read Link Quality (0x05|0x0003) ncmd 1
    status 0x00 handle 6 lq 255
< HCI Command: Read Transmit Power Level (0x03|0x002d) plen 3
    handle 6 type 0 (current)
> HCI Event: Command Complete (0x0e) plen 7
    Read Transmit Power Level (0x03|0x002d) ncmd 1
    status 0x00 handle 6 level 0
< HCI Command: Read RSSI (0x05|0x0005) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00 handle 6 rssi 7
< HCI Command: Read Link Quality (0x05|0x0003) plen 2
    handle 6  
> HCI Event: Command Complete (0x0e) plen 7


<snip>
--
EOF
