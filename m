Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jonathan Paisley <jp-www@dcs.gla.ac.uk>,
   Lars Grunewaldt <lgw@dark-reality.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4118D6B9.3090708@superbug.demon.co.uk>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>
	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>
	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
	 <1092140041.4564.96.camel@pegasus>
	 <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk>
	 <1092143505.4564.117.camel@pegasus> <4118D049.9060000@superbug.demon.co.uk>
	 <1092145771.4564.148.camel@pegasus> <4118D6B9.3090708@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1092148473.4564.156.camel@pegasus>
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
Date: Tue, 10 Aug 2004 16:34:33 +0200

Hi James,

> I can get modules added to the alsa cvs. I would think that newly 
> developed modules should go into cvs first, and then backported to older 
> kernel versions. After all, the only way to get snd-bt-sco into the 
> linux kernel proper, is via the alsa cvs.
> There are various staging steps in the alsa cvs, before a module in the 
> alsa cvs gets into the linux kernel proper.

why should this be? ALSA is part of the Linux 2.6 kernel and so I would
submit a BlueZ ALSA driver for kernel inclusion only. I don't care about
the ALSA CVS, because the ALSA CVS must track the kernel and not vice
versa.

> Of course the snd-bt-sco module will just be a bit of shim code between 
> alsa and blues. With the major work done in a user space bluetooth profile.
> 
> One advantage of alsa, is that once a module is in the alsa cvs, it will 
> will always function correctly on all kernel versions, so back porting 
> is not an issue with alsa.

Maybe I have to repeat it, but I don't care about the ALSA CVS and any
older kernel versions. The current mainline kernel is the only base.

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
