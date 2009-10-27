Return-Path: <cyrus@holtmann.org>
Subject: Transient devices
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 27 Oct 2009 13:01:15 +0000
Message-Id: <1256648475.2367.106.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

I've had a few thoughts about some use cases that currently cause
problems (or would cause problems) with bluetoothd.


1) Printer pairing and setup

The cups backend will create a non-paired device to detect whether
devices with a printer class have supported services.

The problem is that the CUPS backend will not remove the device once
done, and the device will now appear in the list of known devices for
bluetoothd. In terms of UIs, that means it shows up in the wizard (as
it's not paired or setup), but not in the properties, thus can't be
removed from the list.

It would be nice to receive this data and have it cached client-side
instead, like we do for discovery results.

2) Adapter provided devices

Although we don't currently have code for that, it would be nice to
handle the possibility.

Some adapters provide a way to store link keys, and other data
pertaining to input devices.

The problem with setting those up is that the pairing will be permanent
on the bluetoothd side. We should make sure the associations go away
when the adapter goes down.

Opinions?

