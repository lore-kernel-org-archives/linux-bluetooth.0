Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: "Dr. Simon Vogl" <vogl@soft.uni-linz.ac.at>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
   Mauro Tortonesi <mtortonesi@ing.unife.it>,
   Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <403CB843.2080507@soft.uni-linz.ac.at>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <200402251359.00791.mtortonesi@ing.unife.it>
	 <1077715546.2919.77.camel@pegasus>
	 <200402251504.47809.mtortonesi@ing.unife.it>
	 <403CB172.8070103@superbug.demon.co.uk>
	 <403CB843.2080507@soft.uni-linz.ac.at>
Content-Type: text/plain
Message-Id: <1077721777.2919.105.camel@pegasus>
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
Date: Wed, 25 Feb 2004 16:09:38 +0100

Hi Simon,

> Yes, there seems to be something utterly wrong, indeed - I spent four 
> days debugging my apps (down
> to the hci_usb driver) until I found out that I do not get a byte of 
> audio data with that acer bt stick (mind,
> though, that I get the connection set up all right, and that I cound 
> send an audio stream). After a change
> to a newer Acer stick my apps first worked fine, but sometimes the sco 
> connections don't get set up ...

the PCM mapping is important. For CSR chips it can be checked with
"hciconfig hci0 revision". It must be set to HCI.

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
