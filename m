Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: Nils Faerber <nils.faerber@kernelconcepts.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1077728432.6021.522.camel@localhost>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <200402251359.00791.mtortonesi@ing.unife.it>
	 <1077715546.2919.77.camel@pegasus>
	 <200402251504.47809.mtortonesi@ing.unife.it>
	 <1077719012.2919.94.camel@pegasus>  <1077728432.6021.522.camel@localhost>
Content-Type: text/plain
Message-Id: <1077729384.2919.120.camel@pegasus>
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
Date: Wed, 25 Feb 2004 18:16:25 +0100

Hi Nils,

> > Is the PCM mapping of both dongles set to HCI? What kernel version do
> > you use?
> 
> And if it isn't?
> I searched the archive but could not find a way to change it.
> Or is this fixed in the firmware? This would be a pity...
> I have just got a Fujitsu-Siemens Lifebook with builtin Blueooth (CSR
> chipset BlueCore01b, HCI 12.3) which reports SCOmapping to PCM...

the SCO mapping is a PSKEY like everything else. It is the same as for
the host transport or the UART setttings. You can change it if you know
how. Actually I don't provide any source code that is capable of
changing PSKEY's.

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
