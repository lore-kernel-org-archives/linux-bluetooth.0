Return-Path: <cyrus@holtmann.org>
Subject: Running "putkey" for keyboards and mice
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 06 Sep 2010 11:06:53 +0100
Message-ID: <1283767613.7529.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

Did a small test this week-end on my Macbook, and running "hciconfig"
with putkey works, adding the just paired keyboards' linkkey into the
Bluetooth adapter.

This meant that even though I paired the device in Linux, it was still
available in MacOS X, without any more pairing.

My question is whether we should, for all the adapters listed in the
hid2hci rules, copy the linkkeys for keyboards and (paired) mice[1] to
the adapter itself.

How would you like to see this implemented? Would a device plugin be
good enough to track newly paired devices?

Cheers

[1]: Just the mice that would require pairing, obviously, such as the
Apple mice

