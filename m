Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth 2.1 USB adapter!
From: Marcel Holtmann <marcel@holtmann.org>
To: rankincj@yahoo.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <294606.8239.qm@web52903.mail.re2.yahoo.com>
References: <294606.8239.qm@web52903.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Fri, 26 Sep 2008 00:23:06 +0200
Message-Id: <1222381386.6442.8.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chris,

> I have just bought a Belkin USB adapter 0x050d:0x016a, and according to hciconfig this is a Bluetooth 2.1 device:
> 
> # hciconfig hci0 version revision
> hci0:	Type: USB
> 	BD Address: 00:0A:3A:83:76:DA ACL MTU: 1021:8 SCO MTU: 64:1
> 	HCI Ver: 2.1 (0x4) HCI Rev: 0x5184 LMP Ver: 2.1 (0x4) LMP Subver: 0x420e
> 	Manufacturer: Broadcom Corporation (15)
> 	Firmware 132.66 / 14
> 
> Does this mean that the adapter cannot possibly work correctly in anything less than a 2.6.27 kernel? Because it clearly *isn't* working correctly at the moment:

load btusb or hci_usb with reset=1 and if that helps, I can add a quirk
for this dongle.

Regards

Marcel


