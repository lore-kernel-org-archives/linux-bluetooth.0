Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jonathan Paisley <jp-www@dcs.gla.ac.uk>,
   Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4118D049.9060000@superbug.demon.co.uk>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>
	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>
	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
	 <1092140041.4564.96.camel@pegasus>
	 <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk>
	 <1092143505.4564.117.camel@pegasus> <4118D049.9060000@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1092145771.4564.148.camel@pegasus>
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
Date: Tue, 10 Aug 2004 15:49:32 +0200

Hi James,

> > I prefer the ALSA integration would be written from scratch, because the
> > original driver was written for a 2.4 kernel and we must concentrate on
> > the 2.6 series. The ALSA subsytem will be cleaned up in the next kernel
> > releases and the magic casting stuff they do is still wrong.
> 
> The latest alsa cvs fixes the magic casting stuff.

as I said, I don't care about what is in the ALSA CVS or their external
drivers. The main focus is the ALSA subsystem in the mainline kernel.

So everone who will work on this have this in mind and start with the
latest 2.6 kernel. If the ALSA stuff in their CVS is newer, then ping
them to merge it mainline.

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
