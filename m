Return-Path: <welpan@gmx.de>
From: Alex <welpan@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Error message
Date: Fri, 21 May 2004 20:51:07 +0200
References: <200405211611.38038.welpan@gmx.de> <200405211940.07538.welpan@gmx.de> <1085161340.22191.32.camel@pegasus>
In-Reply-To: <1085161340.22191.32.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200405212051.07773.welpan@gmx.de>
List-ID: <bluez-users.lists.sourceforge.net>

Am Freitag, 21. Mai 2004 19:42 schrieben Sie:
> Hi Alex,
>
> > > there is no CSR chip in this dongle.
> >
> > KMelektronik cheat, thats not fine.
>
> yes they did. Where do you bought it? If the error still exists after
> disabling SCO support I must try to get one of these.



>
> > > What is the content of /proc/bus/usb/devices with the dongle attached?
> >
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>
> You missed some information at the top.

>
> > > > Kernel with Bluez-modules and USB drivers
> > >
> > > Use patch-2.6.6-mh1 to prevent some USB related bugs.
> >
> > I use the patch ( I did it like the description), so that was my last
> > hope to find the error by myself
>
> If you already use 2.6.6-mh1 then it is good to say that ;)
>
> However disable CONFIG_BT_HCIUSB_SCO and try again.

That was it, the dongle is running.

Thank you very much for your help.


Best Regards

Alex
