Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Help with bluez pairing problem!!
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <IJTM7X$1B27DB0B4797131F8B5DE564475869A0@libero.it>
References: <IJTM7X$1B27DB0B4797131F8B5DE564475869A0@libero.it>
Content-Type: text/plain
Message-Id: <1121686258.22662.80.camel@pegasus>
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
Date: Mon, 18 Jul 2005 13:30:58 +0200

Hi Andrea,

> i have a problem with pairing in a scenario where a pc tries to push (via obex) a file to a cell phone. I set up all my environment and all works fine, on my cell the PC PIN is requested and after i enter it the file is trasmitted and all goes fine. But i ve this kind of problem:
> 
> After the first authentication i still need (for my project requirementes) that next pushes to the cell ask again for PIN. To do this i think i suppose i need to delete (on my cell phone side or on my pc side) the authentication info. I need to do it on my pc, but how can i programmatically delete a pairing entry from the link_key file ?

the newer bluez-utils version don't use /etc/bluetooth/link_key file
anymore. See my posting for details.

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
