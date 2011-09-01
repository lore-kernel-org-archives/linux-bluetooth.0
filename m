Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Is bluetooth supported on lastest mac-mini?
Date: Thu, 1 Sep 2011 08:38:31 +0000
Message-ID: <654DF80AD31A344E93DBCC6280BD6DEF222465B6@NL0230MBX08N1.DIR.slb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using bluez-4.96, things work fine on:

dell latitude d430
Bus 002 Device 004: ID 413c:8140 Dell Computer Corp. Wireless 360 Bluetooth

..but don't work on:

2011 unibody mac mini server
Bus 001 Device 003: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of BCM2046 Bluetooth)

"bluetoothd -nd" does not throw up any error messages, but "hcitool scan" fails with a "no device" found message.

Is there any further troubleshooting I could try?

Regards
John
