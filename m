Return-Path: <cyrus@holtmann.org>
From: Steven Davies <linux-bluetooth-list@steev.me.uk>
Subject: BLE: dbus doesn't show GATT characteristics
To: linux-bluetooth@vger.kernel.org
Message-ID: <5600674E.2010602@steev.me.uk>
Date: Mon, 21 Sep 2015 21:23:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm having a problem using BLE through dbus where the GATT services
don't appear after a BLE device has been found during a scan. What is
available through dbus is a Device1 node with the correct address and a
Name property of the name which was sent in the advertising beacons -
however that's the only node available in the tree.

When running with the same BLE dongle (ID 0a5c:21e8 Broadcom Corp.
BCM20702A0 Bluetooth 4.0) and same BLE remote device (TI SensorTag 2
CC2650STK) on a different computer I can see all the GATT
characteristics in the dbus tree without any problems.

The computer with the problem is running on kernel 4.2.0 with bluez
5.34. gatttool works without a problem.

Where should I start looking to find out why this is happening? I am a
developer; if someone could point me in the direction to begin looking
I'll do some investigation.

Regards
Steven Davies
