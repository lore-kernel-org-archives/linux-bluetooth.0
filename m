Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
From: Marcel Holtmann <marcel@holtmann.org>
To: Jonathan Paisley <jp@dcs.gla.ac.uk>
Cc: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.59.9999.0408101412470.22497@brava.dcs.gla.ac.uk>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>
	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>
	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
	 <1092140041.4564.96.camel@pegasus>
	 <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk>
	 <1092143505.4564.117.camel@pegasus>
	 <Pine.LNX.4.59.9999.0408101412470.22497@brava.dcs.gla.ac.uk>
Content-Type: text/plain
Message-Id: <1092144507.4564.125.camel@pegasus>
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
Date: Tue, 10 Aug 2004 15:28:27 +0200

Hi Jonathan,

> > the point is that dropping packets and generating zero packets is
> > already part of the Bluetooth chip. This means we will get a correct
> > stream from the hardware and we must only make sure that we deliver our
> > packets in time as long as the hardware is able to buffer it.
> 
> Agreed. The problem I've seen is due to the driver not providing packets 
> in time to the SCO layer. As such, the hardware doesn't get a chance to 
> buffer.

there is also a flow control for SCO packets if my memory don't play
tricks with me. However I think that we should not worry about this too
much at the moment. If we ran into problems then we can think about how
we can fix them.

> > I prefer the ALSA integration would be written from scratch, because the
> > original driver was written for a 2.4 kernel and we must concentrate on
> > the 2.6 series. The ALSA subsytem will be cleaned up in the next kernel
> > releases and the magic casting stuff they do is still wrong.
> 
> I haven't been keeping track of ALSA development recently. It sounds like 
> you're saying that the API is going to be changing enough that simple 
> modifications to the existing ALSA-interfacing code in snd-bt-sco will not 
> be enough to keep it up to date. Does this mean it would be worth putting 
> a hold on development of a properly-bluez-integrated driver until the ALSA 
> subsystem has stabilised?

I don't know how much of the API will be really changed, but actually
some parts can be done much easier. My point is that I get a clean
driver in the end. The focus is the ALSA of a recent 2.6.8 kernel or
later and nothing before. If we must change something in the ALSA
library or tools only for adding another driver, this is a sign that
something has designed in a wrong way.

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
