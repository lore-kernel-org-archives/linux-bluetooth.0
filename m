Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Using ASCII based files for link key storage
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1113668583.16433.76.camel@pegasus>
References: <1113668583.16433.76.camel@pegasus>
Content-Type: text/plain
Message-Id: <1113693376.18450.23.camel@pegasus>
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
Date: Sun, 17 Apr 2005 01:16:16 +0200

Hi again,

> All the framework around these stuff is already committed to the BlueZ
> utils CVS and we need only to fill in the functions for writing and
> reading the link keys from the files. Both can be found as some kind of
> prototypes in hcid/storage.c and I would be very happy if someone fills
> these function with actual code, because I am quite busy with some other
> stuff.

I just wrote some code do deal with the link key storage and to support
the device name cache. I don't fully like it and I think it contains
some bugs, but it is better than nothing. So feel free to send me
patches to improve it. And btw using the hcitool with name cache support
is very great in my environment.

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
