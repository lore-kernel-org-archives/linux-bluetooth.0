Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] snd-bt-sco development teamup...
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4118FBFD.6000606@superbug.demon.co.uk>
References: <4117AB9A.9010909@dark-reality.de>
	 <1092071356.4564.12.camel@pegasus> <4117B098.5020805@dark-reality.de>
	 <1092073167.4564.26.camel@pegasus> <4117C0AB.2010609@superbug.demon.co.uk>
	 <1092090364.4564.46.camel@pegasus> <41180E64.1010007@dark-reality.de>
	 <1092140041.4564.96.camel@pegasus>
	 <Pine.LNX.4.59.9999.0408101355310.22497@brava.dcs.gla.ac.uk>
	 <1092143505.4564.117.camel@pegasus> <4118D049.9060000@superbug.demon.co.uk>
	 <1092145771.4564.148.camel@pegasus> <4118D6B9.3090708@superbug.demon.co.uk>
	 <1092148473.4564.156.camel@pegasus> <4118E6A1.4030709@superbug.demon.co.uk>
	 <1092151554.4564.188.camel@pegasus> <4118FBFD.6000606@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1092178711.4564.210.camel@pegasus>
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
Date: Wed, 11 Aug 2004 00:58:32 +0200

Hi James,

> > the point is in writing an ALSA driver and not changing the ALSA
> > subsystem. The SCO driver is part of the Bluetooth subsystem and so it
> > will go in by me. The ALSA subsystem provides an in-kernel API and that
> > can be used without any acknowledge of the ALSA maintainer.
> 
> ALSA is very modularised. This separates the hardware specific driver 
> stuff from the more general alsa kernel code. So, if you write your own 
> ALSA driver hardware module, it will have to depend on other ALSA 
> modules. The only ALSA API that is going to be stable is the user land 
> alsa-lib, which talks to applications. Although the ALSA kernel API and 
> ALSA low level hardware driver API has not changed in some time, the 
> ALSA maintainer reserves the right to change it at any time without 
> having to warn people, as alsa-lib hides all the changes from users.
> It is therefore a good idea to place any ALSA specific code in the ALSA 
> tree, so that the ALSA maintainers keep it's kernel API up to date.
> This would then leave the BlueZ team to only have to worry about the 
> ALSA to BlueZ API.

you don't get my point. The ALSA code in the kernel is the base and if I
want to use that API I don't have to ask anyone for inclusion. The ALSA
subsystem is part of the Linux kernel and so they must take of that
every component is working with their changes. This has nothing to do
with their CVS, because as I said, the kernel counts.

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
