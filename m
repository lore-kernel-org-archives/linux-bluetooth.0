Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 11 Jul 2012 13:43:01 -0400
Message-ID: <CACEkAT6ci30WTSFX8CsiNPJhH1Y6VCE+dmXKCNJ7CfjsNnocRQ@mail.gmail.com>
Subject: How to force EDR l2cap connections
From: Andy Pyles <andy.pyles@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have two bluetooth devices (Linux PC and  Android Phone). Both support BR/EDR.
I have written an application that transmits data over an l2cap connection.

1.) How do I force the connection to use EDR only?

According to the spec I need to set "Packet_Type" with the appropriate bits.
I'm using the BSD socket API. I don't see an option in setsockopt() to
set the Packet_Type parameter.
Is there another approach to accomplish this?

2.) Is there a tool I can use to verify that EDR is used?

Here is some additional information about the devices.
Both show support for DH3. Am I reading this correctly to mean that
3-DH3 is not supported on either device?
My understanding is the max speed for 3-DH3 is 3Mbit /sec, while DH3
is limited to 2.1Mbit/sec.


Device one (PC)
hci0:	Type: BR/EDR  Bus: USB
	BD Address: 9C:B7:0D:29:7C:39  ACL MTU: 1022:8  SCO MTU: 183:5
	UP RUNNING PSCAN ISCAN
	RX bytes:2230051 acl:3683 sco:0 events:4390 errors:0
	TX bytes:2287298 acl:4179 sco:0 commands:62 errors:0
	Features: 0xff 0xfe 0x0d 0xfe 0xd8 0x7f 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF
	Link mode: SLAVE ACCEPT
	Name: 'wifi2-0'
	Class: 0x6e0100
	Service Classes: Networking, Rendering, Capturing, Audio, Telephony
	Device Class: Computer, Uncategorized
	HCI Version: 4.0 (0x6)  Revision: 0x102
	LMP Version: 4.0 (0x6)  Subversion: 0x1
	Manufacturer: Atheros Communications, Inc. (69)

Device two (Phone)

hci0:	Type: BR/EDR  Bus: UART
	BD Address: 04:E4:51:7C:DA:F8  ACL MTU: 1021:4  SCO MTU: 180:4
	UP RUNNING PSCAN
	RX bytes:2306566 acl:5350 sco:0 events:2154 errors:0
	TX bytes:2202596 acl:3683 sco:0 commands:43 errors:0
	Features: 0xff 0xfe 0x2d 0xfe 0xdb 0xff 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF
	Link mode: SLAVE ACCEPT
	Name: 'XT910'
	Class: 0x5a020c
	Service Classes: Networking, Capturing, Object Transfer, Telephony
	Device Class: Phone, Smart phone
	HCI Version: 4.0 (0x6)  Revision: 0x0
	LMP Version: 4.0 (0x6)  Subversion: 0x2b2a
	Manufacturer: Texas Instruments Inc. (13)
