Return-Path: <pb@nexus.co.uk>
Subject: Re: [Bluez-devel] Renaming USB HID driver
From: Philip Blundell <pb@nexus.co.uk>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Vojtech Pavlik <vojtech@suse.cz>, Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <1080037332.7098.83.camel@localhost>
References: <1079963694.2663.247.camel@pegasus>
	 <1080037332.7098.83.camel@localhost>
Content-Type: text/plain
Message-Id: <1080142065.2648.39.camel@mill.nexus.co.uk>
Mime-Version: 1.0
Date: Wed, 24 Mar 2004 15:27:45 +0000
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, 2004-03-23 at 10:22, Nils Faerber wrote:
> For example I am currently working on Linux for PDAs. Some of them can
> be attached to external keyboards, mostly serial. Having a cleanly
> abstracted HID layer would make it possible to have those properly
> supported. Currently this is done by a pretty ugly hack calling
> handle_scancode() or similar :(

I don't think this would actually help much for those keyboards.  As far
as I know, none of the common PDA keyboards speak HID; they all use some
custom serial protocol for event reporting.  You can avoid the gruesome
handle_scancode() stuff by injecting EV_KEY events into the input stack,
either via input_report_key() within the kernel, or via uinput from
user-space.

p.
