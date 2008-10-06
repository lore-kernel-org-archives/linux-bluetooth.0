Return-Path: <cyrus@holtmann.org>
Message-ID: <48EA9C74.5060402@pook.es>
Date: Tue, 07 Oct 2008 01:17:08 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez/git + 2.6.27-rc8 + Belkin F8T017 -> works with reset=1
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net>	 <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>	 <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>		 <48EA7770.30307@pook.es> <1223325944.11272.227.camel@violet.holtmann.net>	 <48EA893E.2000704@pook.es> <1223332734.11272.244.camel@violet.holtmann.net>
In-Reply-To: <1223332734.11272.244.camel@violet.holtmann.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

hi Marcel

> I doubt it since it is not in yet. Show me the output of hciconfig -a
> for this so I can create a patch for it.

see below

> What is the exact model number of this one. Do you have to have a link
> to the product website by any chance.

Belkin
Bluetooth Adapter
Model:  F8T017
FCC ID: K7SF8T017

When I ordered the dongle I ordered a F8T017ng but the "ng"
is not indicated on the dongle or on the packaging.

http://catalog.belkin.com/IWCatProductPage.process?Product_Id=454427
http://www.belkin.com/uk/support/article/?lid=enu&pid=F8T017ng&aid=10334&scid=0

: root@kooka; hciconfig -a
hci0:	Type: USB
	BD Address: 00:0A:3A:84:94:D9 ACL MTU: 1021:8 SCO MTU: 64:1
	UP RUNNING
	RX bytes:844 acl:0 sco:0 events:46 errors:0
	TX bytes:2609 acl:0 sco:0 commands:46 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH HOLD SNIFF PARK
	Link mode: SLAVE ACCEPT
	Name: 'kooka-0'
	Class: 0x4a0104
	Service Classes: Networking, Capturing, Telephony
	Device Class: Computer, Desktop workstation
	HCI Ver: 2.1 (0x4) HCI Rev: 0x5123 LMP Ver: 2.1 (0x4) LMP Subver: 0x420e
	Manufacturer: Broadcom Corporation (15)

This dongle has a small button. I'm not sure yet but it seemed that
the dongle didn't want to work until I pressed the button.
I'll check next time.

thanks
Stuart
