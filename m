Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41180E64.1010007@dark-reality.de>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>
	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>
	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
Content-Type: text/plain
Message-Id: <1092140041.4564.96.camel@pegasus>
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
Date: Tue, 10 Aug 2004 14:14:01 +0200

Hi Lars,

> | Actually you think that we need it, but I am still not sure that this is
> | really needed in case of the concept of the SCO packet from the HCI and
> | the SCO handling that is done on link manager/chip level. However you
> | can still convince me with real code.
> 
> I have to agree with Marcel here. I've been using snd-bt-sco for a while
> now with my HBH-35 Sony Ericsson Headset, and it works pretty well. Of
> course I don't know much about how audio is processed here, but the
> snd-bt-sco layer simply connects the sco socket to the alsa audio
> socket. There's not much stuff about full duplex or low latency done,
> I'm pretty sure I'd have noticed.

and the snd-bt-sco driver uses socket programming from within a kernel
thread. If we remove that and include it directly into the SCO driver I
think we have all what we need ;)

> Marcel, what exactly do you mean by "implementing an alsa interface"?
> Should there be an interface [like SCO] that is than accessed by an
> additional alsa driver?
> 
> Maybe it would be possible to use some of the snd-bt-sco code here,
> because only the userspace daemon that "wraps" the sound sockets
> together must be "integrated" (well, it's functionality) into BlueZ,
> while the snd-bt-sco alsa driver could remain nearly the same, just
> accessing the BlueZ/alsa interface instead of BlueZ/SCO?

Lets connect the SCO channel throught the socket interface and then tell
the kernel via an IOCTL to change this into an ALSA device. We do the
same for RFCOMM where we convert a socket into a TTY.

Most of the snd-bt-sco source will be useless, because it handles the in
kernel socket programming and you don't need that inside the SCO module.

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
