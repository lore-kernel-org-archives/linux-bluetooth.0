Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030425104103.1040bb30@unixmail.qualcomm.com>
To: David Woodhouse <dwmw2@infradead.org>, bluez-devel@lists.sourceforge.net
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] [PATCH] Fix abuse of kernel headers.
In-Reply-To: <1051277155.1989.3007.camel@passion.cambridge.redhat.com>
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
Date: Fri, 25 Apr 2003 10:43:59 -0700

At 06:25 AM 4/25/2003, David Woodhouse wrote:
>Thou Shalt Not Use Private Kernel Headers In Userspace.
Yes. But asm/unaligned.h is the integral part of the glibc headers.


>-       return ntohs(get_unaligned(u16_ptr));
>+       return (u8_ptr[0] << 8) | u8_ptr[1];
I'd rather see reimplementation of get_unaligned() in hcidump headers 
than this. We have sdp_get/put_unaligned() btw.

Max




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
