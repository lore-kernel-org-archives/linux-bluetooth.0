Return-Path: <cyrus@holtmann.org>
Subject: Re: Missing support in btusb for broadcom dongle 0a5c:2009
From: Marcel Holtmann <marcel@holtmann.org>
To: Guillaume Bedot <littletux@zarb.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1225123432.15672.6.camel@localhost>
References: <1225123432.15672.6.camel@localhost>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 19:04:54 +0100
Message-Id: <1225130694.7157.12.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guillaume,

> It seems this particular dongle needs a quirk that existed in hci_usb,
> but doesn't in btusb.
> 
> Is it possible to send some command to use this dongle (as hciconfig
> reset can replace the reset quirk) ?
> 
> Or should the quirk be introduced in btusb too ?

you can load btusb with reset=1 and that does the same trick, but the
quirk should be added to btusb directly. Send in the lsusb output and
content of /proc/bus/usb/devices for your dongle.

Regards

Marcel


