Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001301c47f09$3900e650$1301010a@baked>
References: <001301c47f09$3900e650$1301010a@baked>
Content-Type: text/plain
Message-Id: <1092208405.4564.227.camel@pegasus>
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
Date: Wed, 11 Aug 2004 09:13:25 +0200

Hi Daryl,

> The attached patch should fix the problem (it does as far as I can tell).
> The compiler probably thinks both arguments to memcpy() are aligned and so
> makes an optimization which breaks the copy (because the destination is not
> actually aligned). Perhaps this is a compiler bug... I'm using gcc 3.3.3.
> After googling and reading some discussion on the topic it seems that it's
> probably not a compiler bug. I'll leave that for someone else to decide. :)

after checking some more resources, you may be right and the compiler
optimizes here where it should not. I found a comment about gcc and
using its __builtin_memcpy. Try to replace the memcpy with memmove and
see if this works.

--- bluetooth.h 2004/07/04 15:38:11     1.14
+++ bluetooth.h 2004/08/11 07:07:12     1.15
@@ -93,10 +93,10 @@ enum {
 #define bt_put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
 #else
 #define bt_get_unaligned(ptr) \
-       ({ __typeof__(*(ptr)) __tmp; memcpy(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
+       ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
 #define bt_put_unaligned(val, ptr) \
        ({ __typeof__(*(ptr)) __tmp = (val); \
-       memcpy((ptr), &__tmp, sizeof(*(ptr))); \
+       memmove((ptr), &__tmp, sizeof(*(ptr))); \
        (void)0; })
 #endif

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
