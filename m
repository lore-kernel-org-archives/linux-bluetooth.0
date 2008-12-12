Return-Path: <cyrus@holtmann.org>
Subject: Re: How to set link policy with Logitech diNovo dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Liebetraut <thomas@tommie-lie.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49429EDF.4050900@tommie-lie.de>
References: <493D7110.1020508@tommie-lie.de>
	 <1228765907.28839.95.camel@violet.holtmann.net>
	 <493D9EA5.5000101@tommie-lie.de>
	 <1229046523.22285.25.camel@violet.holtmann.net>
	 <49429EDF.4050900@tommie-lie.de>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 18:48:58 +0100
Message-Id: <1229104138.22285.113.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

> > this is a serious problem. Please show me hciconfig -a of your dongle. I
> > have never seen a dongle that doesn't support Default Link Policy.
> 
> Here is the output from hciconfig -a:
> | thomas@Majestix:~/src/bluez-4.22$ hciconfig -a
> | hci0:   Type: USB
> |         BD Address: 00:07:61:19:49:79 ACL MTU: 192:8 SCO MTU: 64:8
> |         UP RUNNING PSCAN
> |         RX bytes:27144 acl:1558 sco:0 events:162 errors:0
> |         TX bytes:1935 acl:59 sco:0 commands:68 errors:0
> |         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
> |         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> |         Link policy:
> |         Link mode: SLAVE ACCEPT
> |         Name: 'Majestix-0'
> |         Class: 0x0a0104
> |         Service Classes: Networking, Capturing
> |         Device Class: Computer, Desktop workstation
> |         HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP
> Subver: 0x34e
> |         Manufacturer: Cambridge Silicon Radio (10)

this is a really old dongle. Check hciconfig hci0 revision (as root) if
it is either a BlueCore01 or BlueCore02.

No idea why the Default Link Policy commands is not implemented here.
That is really strange.

Regards

Marcel


