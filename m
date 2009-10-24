Return-Path: <cyrus@holtmann.org>
Subject: Unexpected Discovering=True after StopDiscovery()
From: Valmantas =?UTF-8?Q?Palik=C5=A1a?= <walmis@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 24 Oct 2009 12:22:34 +0300
Message-ID: <1256376154.6667.8.camel@walmis-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm getting this strange behaviour with my laptop's internal bluetooth.
I've observed the same issue on my friend's eeepc too. But it doesn't
happen with external dongles (i only have CSR ones), maybe some issue
with broadcom chipsets?

As seen from the logs i get a Discovering=True immediately after False,
and it's stuck there, no more signals will arrive.

Output from dbus-monitor:

signal sender=:1.20 -> dest=(null destination) serial=498
path=/org/bluez/2395/hci0; interface=org.bluez.Adapter;
member=PropertyChanged
   string "Discovering"
   variant       boolean true
   
-- Stop discovery called here --

signal sender=:1.20 -> dest=(null destination) serial=502
path=/org/bluez/2395/hci0; interface=org.bluez.Adapter;
member=PropertyChanged
   string "Discovering"
   variant       boolean false
signal sender=:1.20 -> dest=(null destination) serial=504
path=/org/bluez/2395/hci0; interface=org.bluez.Adapter;
member=PropertyChanged
   string "Discovering"
   variant       boolean true

output from hcidump:

-- discovery activated --

< HCI Command: Periodic Inquiry Mode (0x01|0x0003) plen 9
> HCI Event: Command Complete (0x0e) plen 4

-- StopDiscovery() called --

< HCI Command: Exit Periodic Inquiry Mode (0x01|0x0004) plen 0
> HCI Event: Command Complete (0x0e) plen 4
> HCI Event: Command Complete (0x0e) plen 4

hcitool -a:
hci0:	Type: USB
	BD Address: 00:1E:4C:DB:8B:84 ACL MTU: 1017:8 SCO MTU: 64:8
	UP RUNNING PSCAN 
	RX bytes:242521 acl:14390 sco:0 events:1233 errors:0
	TX bytes:5861 acl:38 sco:0 commands:923 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'walmis-laptop-0'
	Class: 0x5e010c
	Service Classes: Networking, Rendering, Capturing, Object Transfer,
Telephony
	Device Class: Computer, Laptop
	HCI Ver: 2.0 (0x3) HCI Rev: 0x213b LMP Ver: 2.0 (0x3) LMP Subver:
0x41d3
	Manufacturer: Broadcom Corporation (15)


