Return-Path: <vojtech@ucw.cz>
Date: Tue, 23 Mar 2004 11:30:15 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Greg Kroah-Hartman <greg@kroah.com>
Subject: Re: [Bluez-devel] Renaming USB HID driver
Message-ID: <20040323103015.GA395@ucw.cz>
References: <1079963694.2663.247.camel@pegasus> <1080037332.7098.83.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1080037332.7098.83.camel@localhost>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Mar 23, 2004 at 11:22:13AM +0100, Nils Faerber wrote:
> Am Mo, den 22.03.2004 schrieb Marcel Holtmann um 14:54:
> > Hi Folks,
> Hello!
> 
> > my plan is to move the HID parser out of the USB subsystem and provide a
> > general HID parser implementation under drivers/hid/ which could then be
> > used by the USB and the Bluetooth subsystem drivers. To avoid any naming
> > conflict due and after the development I suggest to rename the USB HID
> > module from hid.ko to usbhid.ko (see attached patch).
> [...]
> > Comments?
> 
> Maybe as additional motivation for a better abstraction, like Marcel
> porposed, I would like to mention other keyboard devices on other Linux
> platforms that could benefit from this!
> For example I am currently working on Linux for PDAs. Some of them can
> be attached to external keyboards, mostly serial. Having a cleanly
> abstracted HID layer would make it possible to have those properly
> supported. Currently this is done by a pretty ugly hack calling
> handle_scancode() or similar :(

You seem to be talking 2.4? In 2.6 you have an abstract input layer,
where you call register_input_device() and then input_report_key() for
these kinds of devices. You definitely are not supposed to call
handle_scancode() directly.

We're talking about another HID separation, separating the parser for
HID descriptors, as defined in the USB HID specification.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
