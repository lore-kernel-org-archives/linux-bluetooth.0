Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Using ASCII based files for link key storage
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050417184147.GA2546@externe.net>
References: <1113668583.16433.76.camel@pegasus>
	 <1113693376.18450.23.camel@pegasus>  <20050417184147.GA2546@externe.net>
Content-Type: text/plain
Message-Id: <1113764059.16233.77.camel@pegasus>
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
Date: Sun, 17 Apr 2005 20:54:19 +0200

Hi Guylhem,

> > I just wrote some code do deal with the link key storage and to support
> > the device name cache. I don't fully like it and I think it contains
> > some bugs, but it is better than nothing. So feel free to send me
> > patches to improve it. And btw using the hcitool with name cache support
> > is very great in my environment.
> 
> Some general thoughts:
>  - regarding keys, an ascii version to ease manipulation would be
>    great. I hate it when I have to rm all the keys because one device
>    has a problem.

this is now working with the new code in the CVS and it is really nice.
I should have done this a long time ago.

>    Even worse - some device can only pair with 1 other
>    device. If I was able to share keys between my desktop, my laptop and
>    my handheld that would be great(but maybe the bt device will use the
>    bt address too and refuse that)

The link key is bound to the BD_ADDR and so this is not possible unless
you set the BD_ADDR of all your devices to the same.

>  - regarding names : would it be possible to replace bt address by
>    nicknames? My devices send back a FQDN on scan because that's the
>    way I set them up, but it would be much better if I could address
>    them with that FQDN too.

I will not add support for this in the next release, but I am open for
such a feature.

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
