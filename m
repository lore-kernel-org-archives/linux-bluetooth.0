Return-Path: <cyrus@holtmann.org>
Date: Sat, 11 Jul 2009 12:00:05 +0900
From: Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: There is a audio break when we search devices while A2DP.
To: linux-bluetooth@vger.kernel.org
Message-id: <006301ca01d3$b144be00$13ce3a00$%park@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, everyone

Have you ever met a audio(A2DP) gap while you search the remote devices?

Surprisingly in case of a commercial stack , I couldn't find the break.

Some phone doesn't allow this feature 
but Windows Mobile does allow this and I could enjoy music without
interrupt.

At least their audio break is too small to bother listening to the music.

If possible, how could I improve this ?

If you know this problem or a clue, please give me a tip.

If not , could you explain why this should be happened?


Test environment:

Ubuntu 8.04
Kernel 2.6.24-24
BlueZ 4.45

Command :
hcitool scan

hci0:	Type: USB
	BD Address: 00:10:60:E3:F9:A7 ACL MTU: 310:10 SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:169836 acl:202 sco:0 events:23081 errors:0
	TX bytes:6635760 acl:22905 sco:0 commands:96 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'chanten-linux-0'
	Class: 0x4a2104
	Service Classes: Networking, Capturing, Telephony
	Device Class: Computer, Desktop workstation
	HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subver:
0xc5c
	Manufacturer: Cambridge Silicon Radio (10)

Regards 
Chanyeol


