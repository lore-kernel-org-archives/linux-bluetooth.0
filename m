Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] 2.6.11-mh2, HID report mode protocol patch
	breakout
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <F09C7DEB2116B64E81782DA92231F1ED7E3A@insexch01.intellinetservices.net>
References: 
	 <F09C7DEB2116B64E81782DA92231F1ED7E3A@insexch01.intellinetservices.net>
Content-Type: text/plain
Message-Id: <1113411351.9061.44.camel@pegasus>
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
Date: Wed, 13 Apr 2005 18:55:51 +0200

Hi Manuel,

> I am hoping Marcel could help me out here... or someone else. I am not really a programmer, otherwise I would do this myself.
> I would need a patch file from the latest mh1 to mh2 that addresses only the HID boot protocol reenablement.
> The gentoo developers are considering to merge it into their kernel, but the whole mh2 patch is too big.
> http://bugs.gentoo.org/show_bug.cgi?id=85792 <http://bugs.gentoo.org/show_bug.cgi?id=85792> 
>  
> I would really appreciate if someone could take a look at that.

this stuff was actually not meant for inclusion into any distribution
kernel. And the HIDP report mode support is the big part of -mh2:

 net/bluetooth/hidp/Makefile |    2 
 net/bluetooth/hidp/core.c   |  112 ++
 net/bluetooth/hidp/hid.c    | 1682 ++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hidp/hid.h    |  350 +++++++++
 net/bluetooth/hidp/hidp.h   |    5 
 5 files changed, 2142 insertions(+), 9 deletions(-)

Due the current Bitkeeper problematic the work on the generic HID parser
has been stalled. One of my concerns was to keep the revision history of
the old HID code and at the moment I have no idea how to do that.

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
