Return-Path: <cyrus@holtmann.org>
Subject: Re: Adapter stored link keys
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Tue, 10 May 2011 14:59:28 +0100
In-Reply-To: <1304864514.2427.18.camel@novo.hadess.net>
References: <1304864514.2427.18.camel@novo.hadess.net>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1305035969.2427.50.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2011-05-08 at 15:21 +0100, Bastien Nocera wrote:
> Heya,
> 
> I updated my KeyOnAdapter property patch, and cooked up a few related
> patches.
> 
> This is the test I intend on making work:
> - pair keyboard
> - set KeyOnAdapter value to TRUE
> - check that key is indeed on the adapter using the hciconfig readkeys
> command, and the bluetoothd output
> - stop bluetoothd
> - remove all mentions of keyboard from /var/lib/bluetooth (or nuke
> directory)
> - start bluetoothd
> - check that debug output mentions the key still being on the adapter
> - turn on keyboard, make sure it still connects without triggering a
> link_key_request event.
> 
> If the above works, can we agree that we should add KeyOnAdapter to
> bluez, and get front-ends to use it?

As discussed with Marcel and Johan, we shouldn't be using this with any
newer adapters, because of security concerns, and we should not be
advertising this as a property, so it's not possible to get it wrong.

The way it should work is:
- should be a plugin
- when new adapters are made available, use the Broadcom or CSR way of
reading the linkkeys (which contain more information than the Bluetooth
1.2 API) and sync it to /var/lib/bluetooth/*/linkkeys
- when new devices are paired with the devices, write the linkkeys
(using the proprietary API again), but only if the adapter is a
dual-HID/HCI adapter, and only for keyboards and paired mice.

This would mean that the use of proprietary APIs do not leak into the
core of bluetoothd, and security concerns are taken care of.

As of now, we do not have any information about the Broadcom or CSR ways
of doing this (Marcel, do you have it for CSR?), but porting the patch I
sent to be a plugin would provide a good basis for the functionality we
actually want.

Cheers

