Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 7 May 2010 07:59:38 -0400
Message-ID: <s2sf97b2b971005070459z83446366pd640d4345eda23d7@mail.gmail.com>
Subject: MAC ADDRESS CHANGE
From: Ahmed Ragab <elmasri.ahmed@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I bought 4 bluetooth dongles and all off them have the same mac
address.hciconfig -a show
hci0:	Type: USB
	BD Address: 00:15:83:15:A3:10 ACL MTU: 672:4 SCO MTU: 48:1
	UP RUNNING PSCAN
	RX bytes:5637 acl:26 sco:0 events:221 errors:0
	TX bytes:2362 acl:25 sco:0 commands:179 errors:0
	Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: ''
	Class: 0x000104
	Service Classes: Unspecified
	Device Class: Computer, Desktop workstation
	HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subver: 0xc5c
	Manufacturer: Cambridge Silicon Radio (10)

I tried ./bdaddr -i hci0  00:09:DA:50:29:30 , ./bdaddr -i hci0 -r
00:09:DA:50:29:30
,bccmd -d 0 psset -s 0 bdaddr 0×44 0×00 0×66 0×55 0×33 0×00 0×22 0×11
None of them seems to work. i have kernel  2.6.31 and bluez 4.60. i
only need to change
The mac address to avoid chaos when i proceed with my application

Thanks

Ahmed
