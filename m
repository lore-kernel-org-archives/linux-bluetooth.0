Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI reset problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200507021912.29173.sua@home.se>
References: <200507021912.29173.sua@home.se>
Content-Type: text/plain
Message-Id: <1120404389.10273.56.camel@pegasus>
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
Date: Sun, 03 Jul 2005 17:26:29 +0200

Hi Johan,

> This is what I see when the reset happens (and yes, there are two output lines
> from hcidump):
> 
> [root@x300 ~]# hcidump -t -X -V 
> 2005-07-02 14:09:10.093053 < HCI Command: Reset (0x03|0x0003) plen 0
> 2005-07-02 14:09:10.093053 < HCI Command: Reset (0x03|0x0003) plen 0

this is a bug that I introduced with bluez-hcidump-1.22 release. I did
some type changes and was a little bit too lazy to check their users. In
this case you should only see one HCI_Reset and then hcidump should
terminate, because the device is gone. A fix for it is in the CVS now.

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
