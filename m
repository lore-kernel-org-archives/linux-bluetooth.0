Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092315210.15466.220.camel@hades.cambridge.redhat.com>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
	 <1092315210.15466.220.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1092391122.28711.220.camel@pegasus>
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
Date: Fri, 13 Aug 2004 11:58:42 +0200

Hi David,

> These should do it right on all architectures -- I've checked with a gcc
> hacker and verified that at least the get_unaligned() version does the
> right thing on both FR-V and i386. On FR-V it loads each byte and shifts
> it into place, while on i386 it just loads it.
> 
> #define get_unaligned(ptr)                      \
> ({                                              \
>         struct __attribute__((packed)) {        \
>                 typeof(*(ptr)) __v;             \
>         }  *__p = (ptr);                        \
>         __p->__v;                               \
> })
> 
> #define put_unaligned(ptr, val)			\
> do {                                            \
>         struct __attribute__((packed)) {        \
>                 typeof(*(ptr)) __v;             \
>         }  *__p = (ptr);                        \
>         __p->__v = (val);			\
> } while(0)

is it verified that this works with every GCC release? Some people still
use a 2.95 or older.

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
