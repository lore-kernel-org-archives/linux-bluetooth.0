Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001301c47f09$3900e650$1301010a@baked>
References: <001301c47f09$3900e650$1301010a@baked>
Content-Type: text/plain
Message-Id: <1092179574.4564.216.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 11 Aug 2004 01:12:54 +0200

Hi Daryl,

> I ran into an alignment problem on our ARM platform. It showed up as corrupt
> SDP responses. I traced it back to bt_put_unaligned() in bluetooth.h
> 
> The attached patch should fix the problem (it does as far as I can tell).
> The compiler probably thinks both arguments to memcpy() are aligned and so
> makes an optimization which breaks the copy (because the destination is not
> actually aligned). Perhaps this is a compiler bug... I'm using gcc 3.3.3.
> After googling and reading some discussion on the topic it seems that it's
> probably not a compiler bug. I'll leave that for someone else to decide. :)

I am not an expert in this area. I thought that this method of getting
unaligned support was compatible accross the platforms. Looking at the
kernel unaligned for ARM shows me that this is actually more different.
I need verification of that patch with GCC 2.95 and from PowerPC and
SPARC platforms. I would do it by myself for SPARC, but the harddrive of
my Sun machine is dead.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
