Return-Path: <nils.faerber@kernelconcepts.de>
Subject: Re: [Bluez-devel] Renaming USB HID driver
From: Nils Faerber <nils.faerber@kernelconcepts.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Vojtech Pavlik <vojtech@suse.cz>, Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <1079963694.2663.247.camel@pegasus>
References: <1079963694.2663.247.camel@pegasus>
Content-Type: text/plain
Message-Id: <1080037332.7098.83.camel@localhost>
Mime-Version: 1.0
Date: Tue, 23 Mar 2004 11:22:13 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Am Mo, den 22.03.2004 schrieb Marcel Holtmann um 14:54:
> Hi Folks,
Hello!

> my plan is to move the HID parser out of the USB subsystem and provide a
> general HID parser implementation under drivers/hid/ which could then be
> used by the USB and the Bluetooth subsystem drivers. To avoid any naming
> conflict due and after the development I suggest to rename the USB HID
> module from hid.ko to usbhid.ko (see attached patch).
[...]
> Comments?

Maybe as additional motivation for a better abstraction, like Marcel
porposed, I would like to mention other keyboard devices on other Linux
platforms that could benefit from this!
For example I am currently working on Linux for PDAs. Some of them can
be attached to external keyboards, mostly serial. Having a cleanly
abstracted HID layer would make it possible to have those properly
supported. Currently this is done by a pretty ugly hack calling
handle_scancode() or similar :(

> Regards
> Marcel
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--
