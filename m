Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Which is needed to have usb bluetooth? (kernels
	modules)
From: Marcel Holtmann <marcel@holtmann.org>
To: Gregoire Favre <Gregoire.Favre@freesurf.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040412153945.GA25368@magma.epfl.ch>
References: <20040410155935.GA26618@magma.epfl.ch>
	 <1081613259.5398.5.camel@pegasus> <20040410161909.GC26618@magma.epfl.ch>
	 <1081701708.5398.58.camel@pegasus> <20040412151229.GA24706@magma.epfl.ch>
	 <1081783267.5398.167.camel@pegasus>  <20040412153945.GA25368@magma.epfl.ch>
Content-Type: text/plain
Message-Id: <1081784654.5398.175.camel@pegasus>
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
Date: Mon, 12 Apr 2004 17:44:15 +0200

Hi Gregoire,

> > if you use hotplug everything will be loaded for you. If not, you need
> > to load the USB host controller driver (I think uhci_hcd in your case)
> > and of course the Bluetooth driver (hci_usb).
> 
> I use hotplug, everything regarding usb load fine, only bluetooth is not
> found... (same if I load things by hand).

of course. If the hotplug don't sees a Bluetooth device it don't loads
the driver ;)

> > If it worked once, you must find your old settings. But actually this is
> > not a Bluetooth related problem. If it gots more worse, ask the USB guys
> > for help.
> 
> I can't find the working solution, and I will then live without
> bluetooth as it is much too hard to use it... at least with this stupid
> MSI onboard :-(

Sorry for that, but as long as USB don't finds your device I also can't
help.

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
