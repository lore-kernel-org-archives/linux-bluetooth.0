Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
   Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
In-Reply-To: <200402251504.47809.mtortonesi@ing.unife.it>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <200402251359.00791.mtortonesi@ing.unife.it>
	 <1077715546.2919.77.camel@pegasus>
	 <200402251504.47809.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1077719012.2919.94.camel@pegasus>
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
Date: Wed, 25 Feb 2004 15:23:32 +0100

Hi Mauro,

> > the Bluetooth specification can be found under www.bluetooth.org and the
> > links to the mailing list archives are at www.bluez.org.
> 
> really, i was asking about the link to the url in the archives where i can 
> find the "comments from the CSR guys about SCO"...

is it so hard to search through the archives? I did the search for you,
but don't expect me to do it again. This is one of them

	http://article.gmane.org/gmane.linux.bluez.user/502

> > How often must I repeat this? 
> 
> sorry, i happen to be a bit dumb sometimes ;-) but it seems that many others 
> are experiencing problems with SCO. perhaps you could start writing something 
> like a SCO readme?

Let me use the statement from Steven Singer

	Summary: SCO is suitable only for analogue signals

> > You can send PCM audio over a SCO socket, but you can't expect that the
> > PCM stream on the other side is byte by byte the same. It only sounds
> > the same.
> 
> i haven't tried, but i don't suppose that infinite series of zeros i get on 
> the receiver sounds just like art blakey's alamode. there is surely something 
> wrong in the transfer process. could it be the fact that my hosts have an 
> usb-uhci controller?

Is the PCM mapping of both dongles set to HCI? What kernel version do
you use?

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
