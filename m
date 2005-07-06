Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Querying device information.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050706123359.GY21449@beta.private.mielke.cc>
References: <1120649879.8836.5.camel@pegasus>
	 <20050706120934.GW21449@beta.private.mielke.cc>
	 <1120652788.8836.7.camel@pegasus>
	 <20050706123359.GY21449@beta.private.mielke.cc>
Content-Type: text/plain
Message-Id: <1120653839.8836.10.camel@pegasus>
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
Date: Wed, 06 Jul 2005 14:43:59 +0200

Hi Dave,

> >this depends on the information you want. 
> 
> Bluetooth is new to me so I'll describe what I'm looking for in terms of USB. 
> I'm looking to determine what kind of device is connected to the other end of
> the socket in the same way that I'd use the USB Vendor/Product identifiers.

no you can't, but you can use SDP to retrieve information about the
services/profiles offered by the peer device.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
