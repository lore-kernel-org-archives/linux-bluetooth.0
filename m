Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Krisztian Mark Szentes <office@produktivIT.com>, BlueZ Mailing List <bluez-users@lists.sourceforge.net>, Edd Dumbill <ejad@debian.org>
In-Reply-To: <1053094302.2561.99.camel@gaston>
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<200305131047.39294.office@produktivIT.com>
	<1053083095.26552.49.camel@pegasus>
	<200305161438.08919.office@produktivIT.com>
	<1053091452.2561.86.camel@gaston>  <1053091839.26550.125.camel@pegasus>
	<1053091938.2978.88.camel@gaston>  <1053092394.26552.132.camel@pegasus>
	<1053092826.2561.90.camel@gaston>  <1053093446.26552.137.camel@pegasus>
	<1053094302.2561.99.camel@gaston>
Content-Type: text/plain
Message-Id: <1053095112.26551.141.camel@pegasus>
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
Date: 16 May 2003 16:25:05 +0200

Hi Ben,

> > if you don't see any other solution to work around, this device will be
> > not supported on the PowerPC platform.
> 
> And probably many others...
> 
> direct IO port access is really an x86 thing... 
> 
> Note that if the cardbus bridge actually sits on the main PCI bus and uses
> "legacy" PIO addresses, it is possible to do something, though I hate it ;)
> 
> You can call the sys_pciconfig_iobase syscall to retreive the physical base
> address where the IO ports of a given PCI bus are mapped.
> 
> By passing that the bus number where the cardbus bridge lives on, you can
> then use the resulting value to mmap /dev/mem and actually access those
> IO ports.
> 
> When actually implementing inx/outx in userland, I strongly suggest you do
> what the kernel does in asm/io.h for ld/st_le16, so you get byteswapped
> access for 16 bits, and have proper eieio barriers.
> 
> That syscall should have the following syntax:
> 
> #define IOBASE_IO		2
> 
> syscall(200, IOBASE_IO, bus_number, 0);

I have not a PowerPC platform for testing, so I can't write any code at
the moment. But your proposal looks very ugly and I don't want to go
this way for 2.4. I will wait until the firmware stuff is accepted by
Linus and then try to port the current driver to the new architecture.

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
