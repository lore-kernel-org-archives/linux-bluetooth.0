Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] varying time to connect
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Albert Huang <ashuang@gmail.com>
In-Reply-To: <20050615113734.035D26EC@arbetsmyra.dyndns.org>
References: <20050615113734.035D26EC@arbetsmyra.dyndns.org>
Content-Type: text/plain
Message-Id: <1118840940.9104.80.camel@pegasus>
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
Date: Wed, 15 Jun 2005 15:09:00 +0200

Hi Ronny,

> Following up my own question on the users-list at
> http://sourceforge.net/mailarchive/forum.php?thread_id=7501858&forum_id=1883
> I've made futher investigations regarding the optimise-connect issue.
> 
> Reading the BT 1.2 spec it seems like HCI support an optional clock 
> offset parameter when doing connects. However, it seems like BlueZ 
> doesn't utilise it. My guess is this might be the case to the very much 
> varying delays when establishing a connection with 
>    hcitool cc 00:11:22:33:44:55

using "hcitool cc ..." is not the right way for creating an ACL link.
The kernel will create the ACL links on demand and use the clock offset
from its inquiry cache if it is not outdated.

> Anyone who can confirm this? Or is there a reason why the clock offset 
> parameter ain't used? I'm thinking of perhaps modifying hcid to cache 
> clocks from most resent inqury to reuse them later, at a subsequent 
> connect. Or is there a better way?

Don't use "hcitool cc ...". It is not needed and only available for
testing.

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
