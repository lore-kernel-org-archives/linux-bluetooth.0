Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Which is needed to have usb bluetooth? (kernels
	modules)
From: Marcel Holtmann <marcel@holtmann.org>
To: Gregoire Favre <Gregoire.Favre@freesurf.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040412151229.GA24706@magma.epfl.ch>
References: <20040410155935.GA26618@magma.epfl.ch>
	 <1081613259.5398.5.camel@pegasus> <20040410161909.GC26618@magma.epfl.ch>
	 <1081701708.5398.58.camel@pegasus>  <20040412151229.GA24706@magma.epfl.ch>
Content-Type: text/plain
Message-Id: <1081783267.5398.167.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 12 Apr 2004 17:21:07 +0200

Hi Gregoire,

> OK, but then, is there anywhere an order on which I should load the
> modules?

if you use hotplug everything will be loaded for you. If not, you need
to load the USB host controller driver (I think uhci_hcd in your case)
and of course the Bluetooth driver (hci_usb).

> It did work with some kernel setup, but I have added some more options
> in the kernel (same kernel) and now I cannot find it back...
> I cannot test another unit on this "usb" because it is on the
> motherboard directly (and that way, it left me only 5 of the 6 usb bus).
> 
> Maybe it's a problem with the new bus speed option in the kernel?
> (Root Hub Transaction Translators (EXPERIMENTAL) ) I'll try without and
> if case of success I'll repport it here :-)

If it worked once, you must find your old settings. But actually this is
not a Bluetooth related problem. If it gots more worse, ask the USB guys
for help.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
