Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Krisztian Mark Szentes <office@produktivIT.com>, BlueZ Mailing List <bluez-users@lists.sourceforge.net>, Edd Dumbill <ejad@debian.org>
In-Reply-To: <1053093446.26552.137.camel@pegasus>
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<200305131047.39294.office@produktivIT.com>
	<1053083095.26552.49.camel@pegasus>
	<200305161438.08919.office@produktivIT.com>
	<1053091452.2561.86.camel@gaston>  <1053091839.26550.125.camel@pegasus>
	<1053091938.2978.88.camel@gaston>  <1053092394.26552.132.camel@pegasus>
	<1053092826.2561.90.camel@gaston>  <1053093446.26552.137.camel@pegasus>
Content-Type: text/plain
Message-Id: <1053094302.2561.99.camel@gaston>
Mime-Version: 1.0
Date: 16 May 2003 16:11:43 +0200
Sender: Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 2003-05-16 at 15:57, Marcel Holtmann wrote:
> Hi Ben,
> 
> > > an ioctl is not possible at that time, because we need the firmware
> > > loaded before we can initialise the Bluetooth HCI device. And I don't
> > > want to use the /proc for this kind of stuff. We hopefully will have a
> > > unified interface for this in 2.5 with request_firmware() call and the
> > > sysfs. See current discussion on LKML.
> > 
> > Then a /proc entry or a temporary /dev entry will be the only sane
> > solution for 2.4 I'm afraid...
> 
> if you don't see any other solution to work around, this device will be
> not supported on the PowerPC platform.

And probably many others...

direct IO port access is really an x86 thing... 

Note that if the cardbus bridge actually sits on the main PCI bus and uses
"legacy" PIO addresses, it is possible to do something, though I hate it ;)

You can call the sys_pciconfig_iobase syscall to retreive the physical base
address where the IO ports of a given PCI bus are mapped.

By passing that the bus number where the cardbus bridge lives on, you can
then use the resulting value to mmap /dev/mem and actually access those
IO ports.

When actually implementing inx/outx in userland, I strongly suggest you do
what the kernel does in asm/io.h for ld/st_le16, so you get byteswapped
access for 16 bits, and have proper eieio barriers.

That syscall should have the following syntax:

#define IOBASE_IO		2

syscall(200, IOBASE_IO, bus_number, 0);

Ben.
