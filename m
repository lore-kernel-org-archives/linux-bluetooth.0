Return-Path: <SRS0+7abe75bf9b19a3b2e46b+354+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: RE: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092302834.28711.72.camel@pegasus>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
Content-Type: text/plain
Message-Id: <1092304890.15466.44.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 11:01:31 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-08-12 at 11:27 +0200, Marcel Holtmann wrote:
> I am not an expert when it comes to specific compiler stuff and I can't
> make the best decision with my limited information. What I realized is
> that we need our own unaligned access implementation, because we can't
> rely on the asm/unaligned.h. So I started to put our own in bluetooth.h
> for general access. If this was wrong, please correct me.

No, that was entirely correct. I may even have prodded you to do it
after packaging bluez-utils for all the Fedora architectures. 

> Some platforms can do unaligned access by themself and some are not. At
> the moment only the i386 is listed, but we should list others like AMD64
> and PowerPC. Patches and hints are welcome. For the rest the generic way
> is to use memcpy, but actually every architecture uses memmove, because
> of the GCC __builtin_memcpy problem. Some of them like Alpha and ARM are
> using specific implementations, but using the macro with memmove seems
> also to work fine there. I like to keep the unaligned macros as short as
> possible.
> 
> Do anyone wrote an autoconf macro for checking if memmove works like
> expected or if it gets optimized by the compiler?

Autocrap considered harmful; I'd rather let the compiler do it.
The reason the compiler isn't doing what you want with memcpy is because
it 'knows' the source pointer is aligned, because it was a pointer to,
for example, an int, and it knows that such pointers have certain
alignment. You need to stop the compiler from 'knowing' that. Ways of
achieving this include __attribute__((packed)) -- you could try
something like this:

#define put_unaligned(ptr, val) { \
	struct { typeof(*ptr) __v } __attribute__((packed)) __p; \
	__p = (void *)(ptr); \
	__p->__v = (val); \
}

Now gcc will know that the object '__v' it's loading from the packed
structure may not be aligned, and it should emit code optimal for the
architecture in question.

The above was typed into the email -- it probably won't even compile,
let alone work. But variations on the theme should work. In fact I'm not
entirely sure we even need the structure -- we might be able to get away
with 
	(typeof (*ptr)) *__p __attribute__((packed));
	*__p = (val);

-- 
dwmw2
