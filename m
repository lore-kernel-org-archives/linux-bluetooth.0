Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
From: Marcel Holtmann <marcel@holtmann.org>
To: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
Cc: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>
	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>
	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
	 <1092140041.4564.96.camel@pegasus>
	 <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk>
Content-Type: text/plain
Message-Id: <1092143505.4564.117.camel@pegasus>
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
Date: Tue, 10 Aug 2004 15:11:45 +0200

Hi Jonathan,

> > and the snd-bt-sco driver uses socket programming from within a kernel
> > thread. If we remove that and include it directly into the SCO driver I
> > think we have all what we need ;)
> 
> I'll chime in here to say that I agree with this too! (as the original 
> author of the snd-bt-sco hack).
> 
> I'd also mention that I didn't find latency to be a problem, but I know 
> that there are issues resulting from lack of buffering that cause audio 
> dropouts for the listener. This lack of buffering, however, is a result of 
> the design of the driver and not a fundamental limitation in bluez.

the point is that dropping packets and generating zero packets is
already part of the Bluetooth chip. This means we will get a correct
stream from the hardware and we must only make sure that we deliver our
packets in time as long as the hardware is able to buffer it.

> > Lets connect the SCO channel throught the socket interface and then tell
> > the kernel via an IOCTL to change this into an ALSA device. We do the
> > same for RFCOMM where we convert a socket into a TTY.
> >
> > Most of the snd-bt-sco source will be useless, because it handles the in
> > kernel socket programming and you don't need that inside the SCO module.
> 
> Again, this sounds like a reasonable way to do things. I'd imagine that 
> the ALSA device will have to hang around in the absence of an active SCO 
> connection in order that programs using the device can keep it open while 
> a headset comes and goes. Therefore it'd be necessary to have a mechanism 
> to dynamically create ALSA devices, and another for binding active SCO 
> sockets to those devices.
> 
> As far as the existing snd-bt-sco source goes, I think there's a 
> significant amount of code that can be saved. Most of the code is dealing 
> with the ALSA integration, management of the mixer and pcm interfaces etc. 
> The kernel thread that does the socket programming can be ripped out 
> (along with the ioctl handlers that set it up) and replaced with 
> timer-driven code which talks directly to the SCO module.

I prefer the ALSA integration would be written from scratch, because the
original driver was written for a 2.4 kernel and we must concentrate on
the 2.6 series. The ALSA subsytem will be cleaned up in the next kernel
releases and the magic casting stuff they do is still wrong.

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
