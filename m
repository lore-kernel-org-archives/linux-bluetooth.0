Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: GCC-4 Patch for btsco
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <loom.20050617T124909-183@post.gmane.org>
References: <loom.20050617T115730-392@post.gmane.org>
	 <1119003833.8980.116.camel@pegasus>
	 <loom.20050617T124909-183@post.gmane.org>
Content-Type: text/plain
Message-Id: <1119006318.8980.126.camel@pegasus>
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
Date: Fri, 17 Jun 2005 13:05:18 +0200

Hi Bastian,

> > > - Fix hci_switch_role expecting a bdaddr_t as the second argument (not a
> > > "bdaddr_t *")
> > 
> > this was a bug in the earlier library versions. The correct argument is
> > a "bdaddr_t *" as for all other functions.
> 
> I believe you mean that there was a bug in the headers. In which version of the
> bluez-libs was this fixed?

the bug was also present in the function itself. I have no idea how it
slipped into the source. I fixed it with the bluez-libs-2.11 release.

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
