Return-Path: <cyrus@holtmann.org>
Subject: Missing support in btusb for broadcom dongle 0a5c:2009
From: Guillaume Bedot <littletux@zarb.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 17:03:52 +0100
Message-Id: <1225123432.15672.6.camel@localhost>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

It seems this particular dongle needs a quirk that existed in hci_usb,
but doesn't in btusb.

Is it possible to send some command to use this dongle (as hciconfig
reset can replace the reset quirk) ?

Or should the quirk be introduced in btusb too ?

Regards,

Guillaume B.

