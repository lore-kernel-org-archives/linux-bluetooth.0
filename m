Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [snd-bt-sco] Re: [Bluez-devel] snd-bt-sco development teamup |
	ALSA connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
Cc: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   snd-bt-sco@corinis.net
In-Reply-To: <Pine.LNX.4.59.9999.0408101448200.22497@brava.dcs.gla.ac.uk>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>
	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>
	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
	 <1092140041.4564.96.camel@pegasus>  <4118C5FC.1050502@dark-reality.de>
	 <1092145515.4564.143.camel@pegasus>
	 <Pine.LNX.4.59.9999.0408101448200.22497@brava.dcs.gla.ac.uk>
Content-Type: text/plain
Message-Id: <1092148605.4564.159.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 10 Aug 2004 16:36:45 +0200

Hi Jonathan,

> > If you mean with that when someone opens the DSP device we should create
> > the connection, then this will fail. The RFCOMM channel must be created
> > first and this is part of the connection handling from userspace. The
> > kernel can't do anything here.
> 
> A user space daemon can, however, keep a file descriptor open on the ALSA 
> device's hwdep interface. The kernel driver could notify the daemon when 
> an app opens the device, at which point the daemon can take a policy 
> decision about attempting to connect to some default headset device (which 
> eventually results in binding the SCO socket to the device).
> 
> > The general workflow should be something like this:
> >
> > 	- create RFCOMM channel and start AT handling
> > 	- create SCO socket if needed
> > 	- issue ioctl to make SCO socket an ALSA device
> 
> I think that the creation of ALSA devices and binding of SCO socket to an 
> ALSA device should be separate operations. That way, an ALSA device can 
> exist with no attached headset. Using the technique described above, that
> device can be demand-connected to a particular SCO socket.

if this works we may can implement something like "rfcomm bind ...". The
creation of the ALSA device can be handled through a SCO raw socket like
we did it for RFCOMM.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
