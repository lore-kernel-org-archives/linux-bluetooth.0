Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092304890.15466.44.camel@hades.cambridge.redhat.com>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1092306154.28711.85.camel@pegasus>
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
Date: Thu, 12 Aug 2004 12:22:34 +0200

Hi David,

> > I am not an expert when it comes to specific compiler stuff and I can't
> > make the best decision with my limited information. What I realized is
> > that we need our own unaligned access implementation, because we can't
> > rely on the asm/unaligned.h. So I started to put our own in bluetooth.h
> > for general access. If this was wrong, please correct me.
> 
> No, that was entirely correct. I may even have prodded you to do it
> after packaging bluez-utils for all the Fedora architectures. 

btw what is the status of BlueZ for Fedora Core. Currently I know the
status of them for Debian and SuSE. Are there any extra patches that I
must know of? How do you split the bluez-utils into different packages?

> > Some platforms can do unaligned access by themself and some are not. At
> > the moment only the i386 is listed, but we should list others like AMD64
> > and PowerPC. Patches and hints are welcome. For the rest the generic way
> > is to use memcpy, but actually every architecture uses memmove, because
> > of the GCC __builtin_memcpy problem. Some of them like Alpha and ARM are
> > using specific implementations, but using the macro with memmove seems
> > also to work fine there. I like to keep the unaligned macros as short as
> > possible.
> > 
> > Do anyone wrote an autoconf macro for checking if memmove works like
> > expected or if it gets optimized by the compiler?
> 
> Autocrap considered harmful; I'd rather let the compiler do it.

Actually I meant to let autoconf compile some test code, then run it and
analyse that result.

> The reason the compiler isn't doing what you want with memcpy is because
> it 'knows' the source pointer is aligned, because it was a pointer to,
> for example, an int, and it knows that such pointers have certain
> alignment. You need to stop the compiler from 'knowing' that. Ways of
> achieving this include __attribute__((packed)) -- you could try
> something like this:
> 
> #define put_unaligned(ptr, val) { \
> 	struct { typeof(*ptr) __v } __attribute__((packed)) __p; \
> 	__p = (void *)(ptr); \
> 	__p->__v = (val); \
> }
> 
> Now gcc will know that the object '__v' it's loading from the packed
> structure may not be aligned, and it should emit code optimal for the
> architecture in question.
> 
> The above was typed into the email -- it probably won't even compile,
> let alone work. But variations on the theme should work. In fact I'm not
> entirely sure we even need the structure -- we might be able to get away
> with 
> 	(typeof (*ptr)) *__p __attribute__((packed));
> 	*__p = (val);

For now I will use memmove, but we need clarification on this. I lost my
Sun Ultra system, so I can't do any tests.

Please send me the additional compiler defines for architectures that
can do unaligned access by themself.

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
