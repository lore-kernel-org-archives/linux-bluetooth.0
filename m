Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Which is needed to have usb bluetooth? (kernels
	modules)
From: Marcel Holtmann <marcel@holtmann.org>
To: Gregoire Favre <Gregoire.Favre@freesurf.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040410161909.GC26618@magma.epfl.ch>
References: <20040410155935.GA26618@magma.epfl.ch>
	 <1081613259.5398.5.camel@pegasus>  <20040410161909.GC26618@magma.epfl.ch>
Content-Type: text/plain
Message-Id: <1081701708.5398.58.camel@pegasus>
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
Date: Sun, 11 Apr 2004 18:41:48 +0200

Hi Greogire,

> > I personally prefer having the USB and Bluetooth subsystem as modules,
> > but it should work in both ways. May you wanna try a modular system.
> 
> I have also tried with everything in module (I have no preference...).

use it as modules, because it will be less complicated.

> http://www.computerbase.de/bild/article/91/63/ has a good picture of the
> Bluetooth for my motherboard (MSI Max2-BLR).

No USB Bluetooth adapter at the USB bus. Maybe you have to activate the
bus itself in your BIOS. Check if another USB device (for example a
mouse) will work in the same slot.

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
