Return-Path: <gregoire.favre@freesurf.ch>
Date: Mon, 12 Apr 2004 17:39:45 +0200
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Which is needed to have usb bluetooth? (kernels modules)
Message-ID: <20040412153945.GA25368@magma.epfl.ch>
References: <20040410155935.GA26618@magma.epfl.ch> <1081613259.5398.5.camel@pegasus> <20040410161909.GC26618@magma.epfl.ch> <1081701708.5398.58.camel@pegasus> <20040412151229.GA24706@magma.epfl.ch> <1081783267.5398.167.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1081783267.5398.167.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

On Mon, Apr 12, 2004 at 05:21:07PM +0200, Marcel Holtmann wrote:

Hello Marcel :-)

> if you use hotplug everything will be loaded for you. If not, you need
> to load the USB host controller driver (I think uhci_hcd in your case)
> and of course the Bluetooth driver (hci_usb).

I use hotplug, everything regarding usb load fine, only bluetooth is not
found... (same if I load things by hand).

> If it worked once, you must find your old settings. But actually this i=
s
> not a Bluetooth related problem. If it gots more worse, ask the USB guy=
s
> for help.

I can't find the working solution, and I will then live without
bluetooth as it is much too hard to use it... at least with this stupid
MSI onboard :-(

Thank for all your help,

	Gr=E9goire
_________________________________________________________________________=
_
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.c=
h
