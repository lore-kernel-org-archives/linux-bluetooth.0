Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Message-ID: <001301c47f09$3900e650$1301010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-devel] Alignment issue
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
Date: Tue, 10 Aug 2004 11:38:25 -0700

Marcel,

I ran into an alignment problem on our ARM platform. It showed up as =
corrupt
SDP responses. I traced it back to bt_put_unaligned() in bluetooth.h

The attached patch should fix the problem (it does as far as I can =
tell).
The compiler probably thinks both arguments to memcpy() are aligned and =
so
makes an optimization which breaks the copy (because the destination is =
not
actually aligned). Perhaps this is a compiler bug... I'm using gcc =
3.3.3.
After googling and reading some discussion on the topic it seems that =
it's
probably not a compiler bug. I'll leave that for someone else to decide. =
:)

I know I'm behind on the libs version, but I just had a look in CVS and =
the
code in question is the same.

Look reasonable to you?

Regards,

-Daryl.

--- bluez-libs-2.8/include/bluetooth.h	2004-07-07 21:54:33.000000000 =
-0700
+++ bluez-libs-2.8_mod/include/bluetooth.h	2004-08-09
11:27:04.000000000 -0700
@@ -93,10 +93,14 @@
 #define bt_put_unaligned(val, ptr) ((void)( *(ptr) =3D (val) ))
 #else
 #define bt_get_unaligned(ptr) \
-	({ __typeof__(*(ptr)) __tmp; memcpy(&__tmp, (ptr), sizeof(*(ptr)));
__tmp; })
+	({ __typeof__(*(ptr)) __tmp; \
+	char *__tmp1 =3D (char *)(ptr); \
+	memcpy(&__tmp, __tmp1, sizeof(*(ptr))); \
+	__tmp; })
 #define bt_put_unaligned(val, ptr) \
 	({ __typeof__(*(ptr)) __tmp =3D (val); \
-	memcpy((ptr), &__tmp, sizeof(*(ptr))); \
+	char *__tmp1 =3D (char *)(ptr); \
+	memcpy(__tmp1, &__tmp, sizeof(*(ptr))); \
 	(void)0; })
 #endif
=20



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
