Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Krisztian Mark Szentes <office@produktivIT.com>, BlueZ Mailing List <bluez-users@lists.sourceforge.net>, Edd Dumbill <ejad@debian.org>
In-Reply-To: <1053091938.2978.88.camel@gaston>
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<200305131047.39294.office@produktivIT.com>
	<1053083095.26552.49.camel@pegasus>
	<200305161438.08919.office@produktivIT.com>
	<1053091452.2561.86.camel@gaston>  <1053091839.26550.125.camel@pegasus>
	<1053091938.2978.88.camel@gaston>
Content-Type: text/plain
Message-Id: <1053092394.26552.132.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 16 May 2003 15:39:44 +0200

Hi Ben,

> > > Hrm... The problem isn't simple. You are just not supposed to tap IOs
> > > that way from userland, especially since PPC arch doesn't have anything
> > > like "PIO" instructions. The IO space of your card is actually mapped
> > > somewhere in physical memory, that "somewhere" not beeing generally
> > > available to userland.
> > > 
> > > Can you tell me more about the card ? Is it a 16 bits PCMCIA device or
> > > is it a cardbus (PCI) one ? Why can't you tap the IOs solely from within
> > > a kernel driver ?
> > 
> > this is a 16 Bit PCMCIA card. We need to load the firmware from
> > userspace, because we can't distribute it within the kernel driver due
> > the legal issues. At the moment we don't even distribute the firmware
> > file with our userspace firmware loader program.
> 
> Can't you do some kind of ioctl or /proc entry to the card's driver
> to pass it the firmware from userland and have the actual IO code in
> the kernel ?

an ioctl is not possible at that time, because we need the firmware
loaded before we can initialise the Bluetooth HCI device. And I don't
want to use the /proc for this kind of stuff. We hopefully will have a
unified interface for this in 2.5 with request_firmware() call and the
sysfs. See current discussion on LKML.

Regards

Marcel




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
