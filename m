Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 16 Dec 2012 19:58:35 +0200
Message-ID: <CAGXs5wWXOLpn1O77RMiQ-Cvp3vXEKm3KCbRvz07dN6jJwFoe-A@mail.gmail.com>
Subject: PSCAN and ISCAN flags in hciconfig
From: Kevin Wilson <wkevils@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I have 2 PC with Linux which once used to recognize each other by
"hcitool scan" and  to create
a PAND-based connection.

Now I fail to see each other with "hcitool scan".
My question is :
I see now only the PSCAN flag when running "hciconfig" on both of then.
Is the ISCAN flag (inquiry) mandatory so that a device will be discoverable ?

following is full output on one of them:

hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:23:4E:E5:70:3A  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING PSCAN
	RX bytes:1857 acl:0 sco:0 events:65 errors:0
	TX bytes:762 acl:0 sco:0 commands:57 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: 'n-0'
	Class: 0x400100
	Service Classes: Telephony
	Device Class: Computer, Uncategorized
	HCI Version: 2.1 (0x4)  Revision: 0x5259
	LMP Version: 2.1 (0x4)  Subversion: 0x424c
	Manufacturer: Broadcom Corporation (15)

rgs,
Kevin
