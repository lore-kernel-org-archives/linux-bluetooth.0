Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: John Gruenenfelder <johng@as.arizona.edu>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Can't get btsco to connect to Plantronics M2500 headset
Message-ID: <20050726062958.GA17805@as.arizona.edu>
References: <20050726042812.GA16828@as.arizona.edu> <42E5CA58.4030408@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42E5CA58.4030408@xmission.com>
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
Date: Mon, 25 Jul 2005 23:29:58 -0700

On Mon, Jul 25, 2005 at 11:30:00PM -0600, Brad Midgley wrote:
>John,
>
>You can force the pairing to be built again by removing 
>/etc/bluetooth/link_key

I thought something like this might be possible.  If I have hcidump running,
when I start hcid I see:

< HCI Command: Read Stored Link Key (0x03|0x000d) plen 7
> HCI Event: Command Complete (0x0e) plen 8

Which says to me that a key is stored somewhere.  However, I have never seen
the file /etc/bluetooth/link_key on my system.  Is there anyplace else it
might be located, perhaps under /var?  I searched my machine for any
*link_key* files, but didn't find anything.

>I've looked at your messages and I can't think of many other things. Do 
>you have other bluetooth devices you can try? Can you easily try it with 
>a 32-bit kernel/userland?

I do have an old laptop that I can test with.  I will try this tomorrow.  I
don't actually intend to use the headset on my 64bit machine, but as it is my
desktop, it's what I use for testing.  So if it works with a 32bit machine,
that will be just fine.


-- 
--John Gruenenfelder    Research Assistant, Steward Observatory, U of Arizona
                        johng@as.arizona.edu
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
