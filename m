Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030425153625.081db0f0@unixmail.qualcomm.com>
To: David Woodhouse <dwmw2@infradead.org>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] [PATCH] Fix abuse of kernel headers.
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1051305362.13999.115.camel@imladris.demon.co.uk>
References: <5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
	<5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Date: Fri, 25 Apr 2003 15:49:26 -0700

At 02:16 PM 4/25/2003, David Woodhouse wrote:
>On Fri, 2003-04-25 at 18:43, Max Krasnyansky wrote:
>> At 06:25 AM 4/25/2003, David Woodhouse wrote:
>> >Thou Shalt Not Use Private Kernel Headers In Userspace.
>> Yes. But asm/unaligned.h is the integral part of the glibc headers.
>
>Take a look at the PPC version.

/*
 * The PowerPC can do unaligned accesses itself in big endian mode. 
 *
 * The strange macros are there to make sure these can't
 * be misused in a way that makes them not work on other
 * architectures where unaligned accesses aren't as simple.
 */

#define get_unaligned(ptr) (*(ptr))

#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))

Looks ok to me ;-). But I do remember some problem on some arch.
Which was the reason why I implemented sdp_get_unaligned() instead
of using <asm/unaligned.h>

>The rule is that you're not permitted to use _anything_ in asm/ or
>linux/ directly from userspace. We know people do, but they shouldn't,
>and if it breaks they get to keep both pieces. 
>> >-       return ntohs(get_unaligned(u16_ptr));
>> >+       return (u8_ptr[0] << 8) | u8_ptr[1];
>> I'd rather see reimplementation of get_unaligned() in hcidump headers 
>> than this. We have sdp_get/put_unaligned() btw.
>
>I looked at that but AFAIK the C standard doesn't actually guarantee the
>packed structure method will work
I don't think packet structures are in the standard. But compiler has to 
guarantee that. Otherwise we'd have big problems (all hci structures are packed).

>and since we were always byteswapping
No we don't. ntohs does nothing on big endian machines.

Max



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
