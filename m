Return-Path: <schmidt@nue.et-inf.uni-siegen.de>
Message-ID: <413C24C6.1030102@nue.et-inf.uni-siegen.de>
Date: Mon, 06 Sep 2004 10:50:14 +0200
From: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] no concurrent inquiry / inquiry scan and L2CAP
 connection as slave
References: <413B18F9.6010101@nue.et-inf.uni-siegen.de> <1094459425.5145.19.camel@notepaq>
In-Reply-To: <1094459425.5145.19.camel@notepaq>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,


Marcel Holtmann schrieb:
> Hi Michael,
> 
> 
>>I'm experiencing the following behavior with BlueZ and L2CAP:
>>
>>After establishing an L2CAP connection between two nodes, only the 
>>master of this connection is still able to:
>>
>>- perform periodic device inquiries (i.e. search other devices
>>   in 'Periodic_Inquiry_Mode')	
>>- perform inquiry scans (i.e. be visible for other searching devices)
>>
>>However, I would like to be able to do this as slave as well (at least, 
>>to perform inquiry scans as slave).
>>
>>Now I'm wondering whether:
>>
>>- this is a restriction of BlueZ		or
>>- this is a restriction of my BT chipsets	or
>>- this is a restriction of Bluetooth		or
>>- I'm doing (configuring) something wrong...
>>
>>My environment:
>>
>>SuSE Linux 9.0: kernel 2.4.21, bluez-libs 2.4, bluez-utils-2.3
>>
>>I have tested and verified this behavior with the BrainBoxes BL-500 and
>>BL-554 adapters.
>>I'd be very grateful if someone of you could shed some light on this topic.
> 
> 
> this sounds like a chip limitation. What does "hciconfig -a" say?

Here goes:

BL-554:

hci0:	Type: USB
	BD Address: 02:00:F4:18:51:74 ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN
	RX bytes:1787 acl:1 sco:0 events:92 errors:0
	TX bytes:543 acl:1 sco:0 commands:44 errors:0
	Features: 0xff 0xff 0x0f 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: 'BlueZ (0)'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1)
	LMP Subver: 0x175
	Manufacturer: Cambridge Silicon Radio (10)


BL-500:

hci0:	Type: UART
	BD Address: 02:00:80:EC:7C:4A ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN
	RX bytes:897 acl:0 sco:0 events:19 errors:0
	TX bytes:634 acl:0 sco:0 commands:20 errors:0
	Features: 0xff 0xff 0x0f 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: 'BlueZ (0)'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x135 LMP Ver: 1.1 (0x1)
	LMP Subver: 0x135
	Manufacturer: Cambridge Silicon Radio (10)


Don't get confused by the apparently weird device addresses; this is 
part of my project.


Michael


-- 
=================================================
Michael Schmidt
-------------------------------------------------
Institute for Data Communications Systems
University of Siegen, Germany
-------------------------------------------------
http:   www.nue.et-inf.uni-siegen.de
=================================================
