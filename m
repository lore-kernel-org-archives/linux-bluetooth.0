Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Version 3 libs/utils
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>, Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.2.20030722125704.097cd218@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030721173324.096d96b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<5.1.0.14.2.20030717163326.07385478@unixmail.qualcomm.com>
	<5.1.0.14.2.20030721173324.096d96b0@unixmail.qualcomm.com>
	<5.1.0.14.2.20030722125704.097cd218@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1058909609.2854.68.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 22 Jul 2003 23:33:22 +0200

Hi Max,

> >Should we keep the kernel inquiry interface? The kernel inside inquiry
> >cache is a nice thing and works in the background like a charm :)
> You mean HCI_INQUIRY ioctl, right ? I'm not sure about that one.
> We'll certainly keep inquiry cache. Cache doesn't really depend on ioctl.

yes, I meant the ioctl. The kernel inquiry cache is a nice thing and
maybe we should provide read only access to it from the userspace.

> >What about the idea to integrate the inquiry into the library or into
> >the Bluetooth master daemon.
> I don't see a need for forwarding inquiry results from a daemon. It can be 
> done in a simple way in the kernel, just like I explained in prev emails
> (ie kernel parsing hci_inquiry command).

My concern is the HCI_INQUIRY ioctl, because it don't really fits the
possibilities and specification details of the inquiry command. But I
don't know what the best way is here and with Bluetooth 1.2 we can also
get the RSSI from an inquiry result.

At the moment I think additional ioctl's for accessing the inquiry cache
will make it possible to use the inquiry command in a more dynamic way:

	- get number of inquiry cache entries
	- copy first n inquiry cache entries to my buffer
	- flush inquiry cache

Comments? Ideas?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
