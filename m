Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HID report mode protocol support in 2.6.11-mh1
	broken/missing?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200503141404.15347.florian-evers@gmx.de>
References: <1110498275.3040.6.camel@pc.vesuri.net>
	 <200503141344.03345.florian-evers@gmx.de> <1110804929.629.7.camel@pegasus>
	 <200503141404.15347.florian-evers@gmx.de>
Content-Type: text/plain
Message-Id: <1110805602.629.9.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 14 Mar 2005 14:06:42 +0100

Hi Florian,

> > > -mh3 and -mh4 didn't work for me. They were not able to detect my
> > > bluetooth dongle. Vanilla 2.6.11 and 2.6.11-mh1 detect my MS-BT 2.0
> > > dongle correctly, but keyboard and mouse are accessed in boot protocol
> > > mode. So I'm using 2.6.10-mh2 again...
> >
> > send in the "hcidump -X -V" for the HID connection setup.
> 
> Ok, I'll do later this evening when I'm back home.
> Do you need the output using kernel 2.6.10-mh2, 2.6.11-mh1 or both?

I think 2.6.11-mh1 is enough.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
