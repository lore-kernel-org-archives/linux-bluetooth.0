Return-Path: <cyrus@holtmann.org>
From: Dick <dick@mrns.nl>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-p6RcFi5mNI/f7iu9z9nB"
Date: Mon, 12 May 2008 18:45:29 +0200
Message-Id: <1210610729.3700.4.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] bug report: trouble reconnecting keyboard after
	timeout
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-p6RcFi5mNI/f7iu9z9nB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I still have some trouble after a connection timeout with my Logitech
diNovo keyboard. Please look at the attached file for details.

greetings,
Dick


--=-p6RcFi5mNI/f7iu9z9nB
Content-Disposition: attachment; filename=logfile.000
Content-Type: text/x-patch; name=logfile.000; charset=UTF-8
Content-Transfer-Encoding: 7bit

=== hcitool con ===
Connections:
	> ACL 00:07:61:69:27:DF handle 49 state 1 lm MASTER 
	> ACL 00:07:61:68:CA:3F handle 46 state 1 lm MASTER AUTH ENCRYPT 
=== hcitool info 00:07:61:69:27:DF ===
Requesting information ...
	BD Address:  00:07:61:69:27:DF
	OUI Company: Logitech SA (00-07-61)
	Device Name: Logitech MX1000 mouse
	LMP Version: 1.2 (0x2) LMP Subversion: 0x545
	Manufacturer: Cambridge Silicon Radio (10)
	Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
		<encryption> <slot offset> <timing accuracy> <role switch> 
		<hold mode> <sniff mode> <park state> <RSSI> <channel quality> 
		<SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
		<CVSD> <paging scheme> <power control> <transparent SCO> 
		<AFH cap. slave> <AFH cap. master> 
=== hcitool info 00:07:61:68:CA:3F ===
Requesting information ...
	BD Address:  00:07:61:68:CA:3F
	OUI Company: Logitech SA (00-07-61)
	Device Name: Logitech diNovo Keyboard
	LMP Version: 1.2 (0x2) LMP Subversion: 0x545
	Manufacturer: Cambridge Silicon Radio (10)
	Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
		<encryption> <slot offset> <timing accuracy> <role switch> 
		<hold mode> <sniff mode> <park state> <RSSI> <channel quality> 
		<SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log> 
		<CVSD> <paging scheme> <power control> <transparent SCO> 
		<AFH cap. slave> <AFH cap. master> 
=== /usr/sbin/hciconfig -a ===
hci0:	Type: USB
	BD Address: 00:16:41:92:9E:44 ACL MTU: 384:8 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:1614376 acl:93662 sco:0 events:1192 errors:0
	TX bytes:39469 acl:341 sco:0 commands:113 errors:0
	Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'latitude'
	Class: 0x00010c
	Service Classes: Unspecified
	Device Class: Computer, Laptop
	HCI Ver: 2.0 (0x3) HCI Rev: 0x976 LMP Ver: 2.0 (0x3) LMP Subver: 0x976
	Manufacturer: Cambridge Silicon Radio (10)

=== /sbin/lsusb -d 413c:8103 -v ===

Bus 001 Device 005: ID 413c:8103 Dell Computer Corp. Wireless 350 Bluetooth
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x413c Dell Computer Corp.
  idProduct          0x8103 Wireless 350 Bluetooth
  bcdDevice           24.22
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          193
    bNumInterfaces          3
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
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
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
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
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
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
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
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0 
      iInterface              0 
Device Status:     0x0001
  Self Powered
=== conary q bluez-utils ===
bluez-utils=3.25-0.3-1
=== modinfo hidp ===
filename:       /lib/modules/2.6.23.17-0.0.1.smp.gcc4.1.x86.i686/kernel/net/bluetooth/hidp/hidp.ko
alias:          bt-proto-6
license:        GPL
version:        1.2
description:    Bluetooth HIDP ver 1.2
author:         Marcel Holtmann <marcel@holtmann.org>
srcversion:     6B60B501497B81398FDFEF5
depends:        bluetooth,l2cap
vermagic:       2.6.23.17-0.0.1.smp.gcc4.1.x86.i686 SMP mod_unload 686 
=== modinfo hci_usb ===
filename:       /lib/modules/2.6.23.17-0.0.1.smp.gcc4.1.x86.i686/kernel/drivers/bluetooth/hci_usb.ko
license:        GPL
version:        2.9
description:    Bluetooth HCI USB driver ver 2.9
author:         Maxim Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann <marcel@holtmann.org>
srcversion:     45A049889B0B161CC6D42E7
alias:          usb:v0C10p0000d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0BDBp1002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v04BFp030Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v057Cp3800d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dcE0dsc01dp01ic*isc*ip*
depends:        bluetooth
vermagic:       2.6.23.17-0.0.1.smp.gcc4.1.x86.i686 SMP mod_unload 686 
parm:           ignore:Ignore devices from the matching table (bool)
parm:           ignore_dga:Ignore devices with id 08fd:0001 (bool)
parm:           ignore_csr:Ignore devices with id 0a12:0001 (bool)
parm:           ignore_sniffer:Ignore devices with id 0a12:0002 (bool)
parm:           disable_scofix:Disable fixup of wrong SCO buffer size (bool)
parm:           force_scofix:Force fixup of wrong SCO buffers size (bool)
parm:           reset:Send HCI reset command on initialization (bool)
parm:           isoc:Set isochronous transfers for SCO over HCI support (int)
=== dmesg|egrep "diNovo|MX1000" ===
input: Logitech diNovo Keyboard as /class/input/input12
input: Logitech MX1000 mouse as /class/input/input13
input: Logitech MX1000 mouse as /class/input/input14
input: Logitech MX1000 mouse as /class/input/input15
input: Logitech MX1000 mouse as /class/input/input16
input: Logitech MX1000 mouse as /class/input/input19
=== uname -a ===
Linux latitude 2.6.23.17-0.0.1.smp.gcc4.1.x86.i686 #1 SMP Fri Mar 14 14:19:36 EDT 2008 i686 GNU/Linux
=== hidd --show ===
00:07:61:69:27:DF Logitech MX1000 mouse [046d:b003] connected 
=== cat /sys/class/bluetooth/l2cap ===
44:9E:92:41:16:00 DF:27:69:61:07:00 1 19 0x0041 0x0043 672 48 0x0
44:9E:92:41:16:00 DF:27:69:61:07:00 1 17 0x0040 0x0042 672 48 0x0
44:9E:92:41:16:00 3F:CA:68:61:07:00 1 19 0x0041 0x07a6 672 48 0x0
44:9E:92:41:16:00 3F:CA:68:61:07:00 1 17 0x0040 0x07a5 672 48 0x0
00:00:00:00:00:00 00:00:00:00:00:00 4 19 0x0000 0x0000 672 0 0x0
00:00:00:00:00:00 00:00:00:00:00:00 4 17 0x0000 0x0000 672 0 0x0
00:00:00:00:00:00 00:00:00:00:00:00 4 3 0x0000 0x0000 1013 0 0x0
00:00:00:00:00:00 00:00:00:00:00:00 4 1 0x0000 0x0000 672 0 0x0
=== hcidump -X -V ===
HCI sniffer - Bluetooth packet analyzer ver 1.41
device: hci0 snap_len: 1028 filter: 0xffffffff
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 28 00 00 00  00 00                    ....(.....
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 46 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 46 mode 0x02 interval 32
    Mode: Sniff
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 28 00 00 00  00 00                    ....(.....
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 46 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 46 mode 0x02 interval 162
    Mode: Sniff
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 49 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 49 mode 0x02 interval 126
    Mode: Sniff
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 28 00 00 00  00 00                    ....(.....
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 46 mode 0x00 interval 0
    Mode: Active
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 46 mode 0x02 interval 32
    Mode: Sniff
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 28 00 00 00  00 00                    ....(.....
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 05 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 01 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 05 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 05 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 05 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 05 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 05 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 05 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 05 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 05 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 05 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 05 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 04 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 01 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 01 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 01 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 01 00 06 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 01 00 00 00 00 00  00 00                    ..........
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 0]
      0000: a1 01 00 00 00 00 00 00  00 00                    ..........
====
Keyboard didn't work, pressed some keys.
Fixed by restarting input service



--=-p6RcFi5mNI/f7iu9z9nB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--=-p6RcFi5mNI/f7iu9z9nB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-p6RcFi5mNI/f7iu9z9nB--
