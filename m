Return-Path: <gregoire.favre@freesurf.ch>
Date: Mon, 12 Apr 2004 17:12:29 +0200
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Which is needed to have usb bluetooth? (kernels modules)
Message-ID: <20040412151229.GA24706@magma.epfl.ch>
References: <20040410155935.GA26618@magma.epfl.ch> <1081613259.5398.5.camel@pegasus> <20040410161909.GC26618@magma.epfl.ch> <1081701708.5398.58.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1081701708.5398.58.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

On Sun, Apr 11, 2004 at 06:41:48PM +0200, Marcel Holtmann wrote:

Hello Marcel :-)

> use it as modules, because it will be less complicated.

OK, but then, is there anywhere an order on which I should load the
modules?

> No USB Bluetooth adapter at the USB bus. Maybe you have to activate the
> bus itself in your BIOS. Check if another USB device (for example a
> mouse) will work in the same slot.

It did work with some kernel setup, but I have added some more options
in the kernel (same kernel) and now I cannot find it back...
I cannot test another unit on this "usb" because it is on the
motherboard directly (and that way, it left me only 5 of the 6 usb bus).

Maybe it's a problem with the new bus speed option in the kernel?
(Root Hub Transaction Translators (EXPERIMENTAL) ) I'll try without and
if case of success I'll repport it here :-)

There is a hack to huse it on a "true" usb under
http://www.overclockers.com/tips1102/

	Gr=E9goire
_________________________________________________________________________=
_
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.c=
h
