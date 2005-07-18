Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Help with bluez pairing problem!!
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42DBAD1D.4080204@palmsource.com>
References: <IJTM7X$1B27DB0B4797131F8B5DE564475869A0@libero.it>
	 <1121686258.22662.80.camel@pegasus>  <42DBAD1D.4080204@palmsource.com>
Content-Type: text/plain
Message-Id: <1121699800.22662.104.camel@pegasus>
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
Date: Mon, 18 Jul 2005 17:16:40 +0200

Hi Fred,

> Is there any plan to provide information and/or access to paired devices 
> (like paired device list, remove a device, ...) through BlueZ.

since the new files are ASCII based, these tasks are quite easy. However
my plan is to provide all these functions over D-Bus. For this I wanna
implement a bluetoothd that combines at least hcid and sdpd. Take a look
at the mailing list archive. Claudio already started with discussing the
interface. I will be away for the OLS, so I am a little bit behind with
writing my comments for it.

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
