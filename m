Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4117C0AB.2010609@superbug.demon.co.uk>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus>  <4117B098.5020805@dark-reality.de>
	 <1092073167.4564.26.camel@pegasus>  <4117C0AB.2010609@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1092090364.4564.46.camel@pegasus>
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
Date: Tue, 10 Aug 2004 00:26:04 +0200

Hi James,

> > I think the SCO driver should provide two interfaces. The first one we
> > know already is a socket interface to the SCO packets and the second
> > should handle the SCO packets directly over into an ALSA interface. May
> > you would like to switch between these two via an IOCTL, like we did it
> > for the RFCOMM layer.
> 
> I looked at doing ALSA -> SCO interface a long time ago, but gave up due 
> to what I considered limitations with the current bluetooth stack.

you never sent any patches for changing this. Start writing code and
send it in for review.

> To summarise, we need low latency, full duplex, and to provide that, we 
> need to accurately be able to determine and control the buffer sizes. 
> The current bluetooth stack has no api to help us in this regard, and 
> therefore will not work very well.

Actually you think that we need it, but I am still not sure that this is
really needed in case of the concept of the SCO packet from the HCI and
the SCO handling that is done on link manager/chip level. However you
can still convince me with real code.

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
