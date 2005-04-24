Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <426BAD24.1030507@xmission.com>
References: <1114345112.10706.64.camel@pegasus>
	 <20050424134746.GA31151@externe.net>  <426BAD24.1030507@xmission.com>
Content-Type: text/plain
Message-Id: <1114356184.10706.97.camel@pegasus>
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
Date: Sun, 24 Apr 2005 17:23:04 +0200

Hi Brad,

> > Later on, like rfcomm manages rfcomm0 etc. entries, some a2dp tool
> > could bind a2dp peripherals to /dev/a2dpN where SBC audio would be
> > expected and streamed to the a2dp peripheral bound there.
> 
> managing connections is kind of a pain. it can't be done entirely in 
> kernel space. you can see how this gets spread into the btsco daemon.

putting AVDTP inside the kernel is quite easy from the connection
viewpoint and in the long run we will need it anyway. The examples are
when it is possible to stream video and audio or if you wanna access two
separate sink endpoints on the same device. The kernel AVDTP layer must
to all sync and multiplexing work here and it is the only place where to
do that in a sane way. However this is out of focus right now.

The SCO and headset/handsfree support is different, because of the
needed RFCOMM connection and the AT parser. Without the AT parser you
can decide when to open the SCO link. It is actually broken by design.

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
