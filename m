Return-Path: <cyrus@holtmann.org>
Message-ID: <53CFD895.6020507@bigfoot.com>
Date: Wed, 23 Jul 2014 17:45:25 +0200
From: DrYak <blackkitty@bigfoot.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Reverse tethering DUN
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

I would like to know which is the current modern way to do DUN reverse
tethering using Bluez version >= 5.

I have an old PDA that I use sometime (a Tapwave Zodiac running PalmOS5.
It's similar to Palm Tungsten, etc.) These old devices don't have Wifi,
only Bluetooth.
For networking over Bluetooth, these old devices don't support PAN, only
DUN.

So to provide them networking, one need to share a desktop PC's
connection over bluetooth DUN.

Up until Bluez version 4, the standard way to provide networking over
bluetooth for such PalmOS 5 devices was:
https://wiki.debian.org/BluetoothPalmOSConnection

Basically:
- run "dund" to listen for incoming connection.
- once the palmos device connects to the PC, have dund start PPPD with
parameters tailored for the device
- use iptables to forward the connection.

My problem:
- I've read that bluez 5 changed the way DUN is handled and thus support
for the old "dund" was dropped.
- Indeed there's no "bluez-compat" package available anymore for my
current distro (opensuse 13.1, runs bluez 5.18)

So my question:
- What's the modern successor of "dund --listen" for bluez 5 ?

How should I setup a DUN service on my computer to which to connect from
my PDA ?

I've looked around, but I haven't been able to find any guide.

Thank you for your help.

- Ivan
