Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Alignment issue
Date: Wed, 11 Aug 2004 09:44:15 -0700
Message-ID: <001201c47fc2$7093e4a0$1301010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1092208405.4564.227.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Actually just using memmove instead of memcpy was the first thing I tried
that worked. Someone else here suggested that.

But I thought I read somewhere that the compiler is allowed to optimize
memmove in the same way. Though I don't know if gcc ever does (and
apparently it doesn't in this case). But if it is allowed to, then some
future version of gcc may. Perhaps I misread it.

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net 
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of 
> Marcel Holtmann
> Sent: August 11, 2004 12:13 AM
> To: Daryl Van Vorst
> Cc: 'BlueZ Mailing List'
> Subject: Re: [Bluez-devel] Alignment issue
> 
> 
> Hi Daryl,
> 
> > The attached patch should fix the problem (it does as far 
> as I can tell).
> > The compiler probably thinks both arguments to memcpy() are 
> aligned and so
> > makes an optimization which breaks the copy (because the 
> destination is not
> > actually aligned). Perhaps this is a compiler bug... I'm 
> using gcc 3.3.3.
> > After googling and reading some discussion on the topic it 
> seems that it's
> > probably not a compiler bug. I'll leave that for someone 
> else to decide. :)
> 
> after checking some more resources, you may be right and the compiler
> optimizes here where it should not. I found a comment about gcc and
> using its __builtin_memcpy. Try to replace the memcpy with memmove and
> see if this works.
> 
> --- bluetooth.h 2004/07/04 15:38:11     1.14
> +++ bluetooth.h 2004/08/11 07:07:12     1.15
> @@ -93,10 +93,10 @@ enum {
>  #define bt_put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
>  #else
>  #define bt_get_unaligned(ptr) \
> -       ({ __typeof__(*(ptr)) __tmp; memcpy(&__tmp, (ptr), 
> sizeof(*(ptr))); __tmp; })
> +       ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), 
> sizeof(*(ptr))); __tmp; })
>  #define bt_put_unaligned(val, ptr) \
>         ({ __typeof__(*(ptr)) __tmp = (val); \
> -       memcpy((ptr), &__tmp, sizeof(*(ptr))); \
> +       memmove((ptr), &__tmp, sizeof(*(ptr))); \
>         (void)0; })
>  #endif
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
