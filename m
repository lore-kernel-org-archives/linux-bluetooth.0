Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4495C348.70501@uni-koblenz.de>
References: <4493FEAF.3000904@uni-koblenz.de>
	<1150657327.8816.20.camel@localhost>  <4495C348.70501@uni-koblenz.de>
Date: Mon, 19 Jun 2006 06:43:51 +0200
Message-Id: <1150692231.7068.3.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Multiple connections with kernel 2.4 make HCI die
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Kevin,

> >> I have applied the changes in the 2.4.32 patch by Marcel, but I think
> >> they only refer to module unloading. Bluez installed is version 2.32. I
> >> already stressed the USB bus with wireless and a hard disk, to rule out
> >> that the usb driver has some funkiness, but everything went smooth.
> > 
> > You can try to make sure that the hci_usb driver doesn't use any ISOC
> > transfers for SCO. The 2.4 USB subsystem was kinda picky about it. Other
> > than that you don't really have a choice except re-writing the hci_usb
> > driver.
> 
> Ok, I'll rebuild a kernel with SCO support right away. Will that 
> suffice, or should I comment out the ISOC stuff in hci_usb.c?

no. Disable the SCO support of the hci_usb driver. With a 2.6 kernel you
can do this with a module paramter, but I am not sure if this made it
ever into the 2.4 kernel.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
