Return-Path: <nils.faerber@kernelconcepts.de>
Subject: Re: [Bluez-devel] Renaming USB HID driver
From: Nils Faerber <nils.faerber@kernelconcepts.de>
To: Herr Philip Blundell <pb@nexus.co.uk>
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Vojtech Pavlik <vojtech@suse.cz>, Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <1080142065.2648.39.camel@mill.nexus.co.uk>
References: <1079963694.2663.247.camel@pegasus>
	 <1080037332.7098.83.camel@localhost>
	 <1080142065.2648.39.camel@mill.nexus.co.uk>
Content-Type: text/plain
Message-Id: <1080225946.7098.120.camel@localhost>
Mime-Version: 1.0
Date: Thu, 25 Mar 2004 15:45:46 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Am Mi, den 24.03.2004 schrieb Philip Blundell um 16:27:
> On Tue, 2004-03-23 at 10:22, Nils Faerber wrote:
> > For example I am currently working on Linux for PDAs. Some of them can
> > be attached to external keyboards, mostly serial. Having a cleanly
> > abstracted HID layer would make it possible to have those properly
> > supported. Currently this is done by a pretty ugly hack calling
> > handle_scancode() or similar :(
> I don't think this would actually help much for those keyboards.  As far
> as I know, none of the common PDA keyboards speak HID; they all use some
> custom serial protocol for event reporting.  You can avoid the gruesome
> handle_scancode() stuff by injecting EV_KEY events into the input stack,
> either via input_report_key() within the kernel, or via uinput from
> user-space.

Ah, yes indeed, that make more sense.
So pls ignore my post ;)

I was about almost about to start digging through HID parsing and
thinking about emulating it...

> p.
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--
