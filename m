Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix abuse of kernel headers.
From: David Woodhouse <dwmw2@infradead.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
References: <5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
Content-Type: text/plain
Message-Id: <1051305362.13999.115.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 25 Apr 2003 22:16:02 +0100

On Fri, 2003-04-25 at 18:43, Max Krasnyansky wrote:
> At 06:25 AM 4/25/2003, David Woodhouse wrote:
> >Thou Shalt Not Use Private Kernel Headers In Userspace.
> Yes. But asm/unaligned.h is the integral part of the glibc headers.

Take a look at the PPC version.

The rule is that you're not permitted to use _anything_ in asm/ or
linux/ directly from userspace. We know people do, but they shouldn't,
and if it breaks they get to keep both pieces. 

> 
> >-       return ntohs(get_unaligned(u16_ptr));
> >+       return (u8_ptr[0] << 8) | u8_ptr[1];
> I'd rather see reimplementation of get_unaligned() in hcidump headers 
> than this. We have sdp_get/put_unaligned() btw.

I looked at that but AFAIK the C standard doesn't actually guarantee the
packed structure method will work, and since we were always byteswapping
in the hcidump case anyway it didn't seem worth implementing a safe
generic version.

-- 
dwmw2




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
