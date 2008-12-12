Return-Path: <cyrus@holtmann.org>
Subject: Re: How to set link policy with Logitech diNovo dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Liebetraut <thomas@tommie-lie.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4942A74E.2020409@tommie-lie.de>
References: <493D7110.1020508@tommie-lie.de>
	 <1228765907.28839.95.camel@violet.holtmann.net>
	 <493D9EA5.5000101@tommie-lie.de>
	 <1229046523.22285.25.camel@violet.holtmann.net>
	 <49429EDF.4050900@tommie-lie.de>
	 <1229104138.22285.113.camel@violet.holtmann.net>
	 <4942A74E.2020409@tommie-lie.de>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 19:07:46 +0100
Message-Id: <1229105266.22285.116.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

> > this is a really old dongle.
> Don't know exactly, about 4 years I guess. It's from the first DiNovo
> Media Desktop (neither Laser nor 2.0).
> 
> > Check hciconfig hci0 revision (as root) if
> > it is either a BlueCore01 or BlueCore02.
> | thomas@Majestix:~$ sudo hciconfig hci0 revision
> | hci0:   Type: USB
> |         BD Address: 00:07:61:19:49:79 ACL MTU: 192:8 SCO MTU: 64:8
> |         Build 846
> |         Chip version: BlueCore02-External
> |         Max key size: 56 bit
> |         SCO mapping:  HCI
> 
> > No idea why the Default Link Policy commands is not implemented here.
> > That is really strange.
> Isn't there some other way to get smooth communication with my MX900?
> After all, the Bluetooth Travel Mouse works fine with the exact same
> dongle after just reconnecting it.

not really. It is tricky and I am not willing to go back to the per
connection link policy setup, because that interferes with how with
setup Bluetooth 2.1 devices.

Problem is that this particular firmware is a custom build for Logitech
(or beta firmware) as it looks like. Also you have other problems with
not having AFH enabled when you have WiFi around.

I think that I do have the exact same mouse and keyboard at home
somewhere. But not supporting Default Link Policy is just pure stupid.

Regards

Marcel


