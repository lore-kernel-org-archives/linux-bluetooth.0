Return-Path: <SRS0+7abe75bf9b19a3b2e46b+354+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: RE: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092306154.28711.85.camel@pegasus>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
Content-Type: text/plain
Message-Id: <1092315210.15466.220.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 12 Aug 2004 13:53:30 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-08-12 at 12:22 +0200, Marcel Holtmann wrote:
> For now I will use memmove, but we need clarification on this. I lost my
> Sun Ultra system, so I can't do any tests.
> 
> Please send me the additional compiler defines for architectures that
> can do unaligned access by themself.

These should do it right on all architectures -- I've checked with a gcc
hacker and verified that at least the get_unaligned() version does the
right thing on both FR-V and i386. On FR-V it loads each byte and shifts
it into place, while on i386 it just loads it.

#define get_unaligned(ptr)                      \
({                                              \
        struct __attribute__((packed)) {        \
                typeof(*(ptr)) __v;             \
        }  *__p = (ptr);                        \
        __p->__v;                               \
})

#define put_unaligned(ptr, val)			\
do {                                            \
        struct __attribute__((packed)) {        \
                typeof(*(ptr)) __v;             \
        }  *__p = (ptr);                        \
        __p->__v = (val);			\
} while(0)

-- 
dwmw2
