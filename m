Return-Path: <SRS0+53c6f9e0eda5ea539b39+515+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1106232343.8190.187.camel@pegasus>
References: <001301c47f09$3900e650$1301010a@baked>
	 <1092208405.4564.227.camel@pegasus>
	 <1106231454.26551.582.camel@hades.cambridge.redhat.com>
	 <1106232343.8190.187.camel@pegasus>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 14:59:35 +0000
Message-Id: <1106233175.26551.597.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2005-01-20 at 15:45 +0100, Marcel Holtmann wrote:
> 
> why using a do-while for put_unaligned() and not for get_unaligned(). 

Because get_unaligned() returns a value, and put_unaligned() does not.

> Is this supposed to work with each GCC version?

Yes.

> Will it also work with other compilers? 

Don't know; don't care. Remember, the existing code isn't guaranteed to
work even with gcc, let alone other compilers. Does the rest of the
BlueZ code compile with non-gcc compilers? Probably not... you have 122
other instances of '__attribute__((packed))' in the source. Including
the alignment stuff in include/sdp_internal.h which does it the way I'm
suggesting, albeit with a gratuitous '#ifdef __i386__'.

> What about performance? If a platform can do unaligned
> access by itself it should be faster than compiler tricks.

If the platform can do unaligned access by itself, then GCC knows that
and emits a direct load/store instruction. It's only if the platform
_can't_ do it by itself that GCC does anything different. That's why the
#ifdef __i386__ in include/sdp_internal.h is pointless -- GCC should
emit the same code even if the other version is used.

-- 
dwmw2
