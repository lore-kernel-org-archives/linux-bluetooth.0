Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
   Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
In-Reply-To: <200402251359.00791.mtortonesi@ing.unife.it>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <40393D4D.5070908@superbug.demon.co.uk> <1077522938.2832.84.camel@pegasus>
	 <200402251359.00791.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1077715546.2919.77.camel@pegasus>
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
Date: Wed, 25 Feb 2004 14:25:46 +0100

Hi Mauro,

> > Yes it have to. You should read the mailing list archive and search for
> > comments from the CSR guys about SCO. And you can of course take the
> > Bluetooth specification itself.
> 
> could you please provide a url?

the Bluetooth specification can be found under www.bluetooth.org and the
links to the mailing list archives are at www.bluez.org.

> i have been trying to transfer pcm data over a sco socket both using scotest 
> and other similar apps of mine, but the actual data tranferred were only a 
> bunch of random bytes, completely unrelated to the data sent. moreover, the 
> behaviour of sco links is very unreliable. in my tests i have used several 
> usb dongles with CSR chips (firmware versions ranging from HCI 15.3 to HCI 
> 16.4) and kernel versions from 2.4.22 to 2.4.25-pre7.
> 
> you have told us many times that there are strong limitations in what you can 
> do with sco sockets, but i still can't understand what are these limitations. 
> i have tried searching trough the archives but i couldn't find anything 
> interesting about this.

How often must I repeat this? We are doing audio over SCO and no data
transfer. Even with transparent SCO as air coding the results on both
ends must not be the same.

> > Again, I can't follow what you are trying to achieve. The current socket
> > interface for SCO fits not perfect, because it is audio only data.
> 
> does this mean that you simply can't perform pcm audio transfers between two 
> bluez hosts by using sco sockets just like scotest does? if so, what is the 
> purpose of scotest, then?

You can send PCM audio over a SCO socket, but you can't expect that the
PCM stream on the other side is byte by byte the same. It only sounds
the same.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
