Return-Path: <cyrus@holtmann.org>
Message-ID: <4E2C46CE.2060000@kernelconcepts.de>
Date: Sun, 24 Jul 2011 18:22:38 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: RFCOMM connection lag (slow)
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
I recently found a strange behaviour...

I have a device which accepts an RFCOMM connection on channel 1.
Creating the connection works just fine and I can basically communicate.

But as soon as larger chunks of data are sent (something like 128 bytes
at a time) it starts to take a pretty long time to transfer it (in the
range of about a second). The connection stays connected and data can be
sent but at a very slow pace.
This is from a 2.6.39 kernel to the device, my PC has a Bluetooth3.0 USB
device.

The interesting part is that if I try the same thing from an HTC G1
phone it works as expected, i.e. "fast". I tried to compare the HCI
settings between the HTC G1 and my notebook and did the same on my
notebook which did not help (the only obvious difference was disabled
PARK mode and a slightly different ACL MTU).

It is pretty likely that the device also has an RFCOMM bug here but
since it works with the HTC phone it must be possible to make it work
with my notebook too.

Any hint would be very much appreciated ;)

Thanks!

Cheers
  nils

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
