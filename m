Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] omtu, imtu
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050209160702.56b74881@CleverSophie>
References: <20050209140701.2cf50710@CleverSophie>
	 <1107955171.13863.26.camel@pegasus> <20050209143858.1e0350c3@CleverSophie>
	 <1107957430.13863.34.camel@pegasus>  <20050209160702.56b74881@CleverSophie>
Content-Type: text/plain
Message-Id: <1107962283.13863.65.camel@pegasus>
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
Date: Wed, 09 Feb 2005 16:18:03 +0100

Hi Bjoern,

> can you also tell me what omtu and imtu are for? I know the Maximum Transfer Unit, but what exactly do these 2? I have set them to 672 and 0 like in the rctest.c file.

what about reading the L2CAP part of the Bluetooth specification. It is
all there, but in short (i)ncoming MTU and (o)utgoing MTU.

> Is 672 the maximum? It would just be nice to know the maximum data per frame, for a good header to data proportion.

The maximal value is 65535. The header/payload is not important for the
throughput. Only matching it to the baseband packet types helps.

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
