Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Using ASCII based files for link key storage
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200504161932.39416.bluez-devel@schaettgen.de>
References: <1113668583.16433.76.camel@pegasus>
	 <200504161932.39416.bluez-devel@schaettgen.de>
Content-Type: text/plain
Message-Id: <1113678271.16433.85.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 16 Apr 2005 21:04:31 +0200

Hi Fred,

> > And second, The format of the link key file will be very simple:
> >
> > 	<bdaddr> <hex-linkkey> <type>
> 
> This means that we will still be unable to list the devices for which a link 
> key exists without root privileges, is this correct? If yes, is this 
> intentional?

there is no other way, because we must store the link keys as secure as
possible.

> Anyway, I for myself don't care much about where the data goes, as long as the 
> location and the file formats stay stable, because the link key manager of 
> kdebluetooth has to be changed each time.

In the long term I like to make the place totally configurable, but for
now I think going with /var/lib/bluetooth and ASCII based files is a
good think.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
