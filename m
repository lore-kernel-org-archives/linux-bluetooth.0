Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] cmtp, capidrv and kernel 2.6
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Thomae <thomae@ei.tum.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <401A269C.7070104@ei.tum.de>
References: <401A269C.7070104@ei.tum.de>
Content-Type: text/plain
Message-Id: <1075562378.2720.8.camel@pegasus>
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
Date: Sat, 31 Jan 2004 16:19:38 +0100

Hi Matthias,

> could anyone give a hint what changes are necessary from kernel 2.4.X to 
> 2.6.X to get an isdn dialup setup via cmtp and capidrv (i4l)?

the I4L and CAPI ISDN subsystem of 2.6 must be resynced and I hope
Karsten Keil is doing this very soon. For now apply the i4l-t9bk22 patch
and try again.

> I have a very well working setup for 2.4.22-mh2, essentially following 
> Marcel's (BTW excellent :) instructions from 
> http://www.holtmann.org/linux/bluetooth/isdn.html and had a quick try 
> using the same setup on an unpatched 2.6.2-rc2 vanilla kernel, getting 
> the following symptoms:
> 
> - cmtp and kernelcapi are loaded and connecting to an AP-X works

You have to load capi.ko by hand and mount the capifs.

> - capiinfo and capiinit complain about not being able to load 
> kernelcapi, although it is already loaded

Known problem, because the new modprobe complains with an error if a
module is already loaded. The CAPI utils needs to be patched.

> - capidrv isn't loaded automatically any more

Can't tell you why, but simply load it :)

> - "/etc/init.d/isdnutils start" complains about /dev/isdnctrl (because 
> of missing capidrv?)

Maybe the scripts need a little bit 2.6 cleanup.

> - when modprobing capidrv the console is flooded with messages

The capidrv itself is an CAPI application and the 2.6 CAPI subsystem is
a little bit talky, because the debug stuff is on by default.

> I use debian/unstable with the latest isdn and capi packages (3.3-7).

With the i4l-t9bk22 the CAPI part should work perfect.

> Do I need any kernel patches (e.g. the i4l patch from 
> http://rcum.uni-mb.si/~uvp00845b/)?

Yes.

> Do I have to modify the module loading definitions in /etc/modutils?

Not that I know of.

> Does pppdcapiplugin work without additional kernel patches?

No.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
