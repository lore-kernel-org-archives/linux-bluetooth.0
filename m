Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "john smith" <roofass@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Alignment issue
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY22-F42hUaRTpCkEW000285a5@hotmail.com>
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
Date: Mon, 16 Aug 2004 09:48:58 +0000

> > > Why are these macros even here? ISTR Max having some reason not to use
> > > <asm/unaligned.h> but surely that's what it's there for...
> >
> > No, asm/unaligned.h is there for kernel code only.
>
>the rule is to not include headers from the kernel source code in any
>user space program or library. Even if some people try to bend this rule
>I will follow as much as I can.

Hi, I'm new to Linux prog. and I'm a bit confused. Does this mean there's a 
problem with bluez/utils/tools/l2ping.c which contains:

   #include <asm/types.h>
   #include <asm/byteorder.h>


Or are the above includes System kernel headers ( which as far as I 
understand are OK for user-space apps. to link to) rather than Kernel source 
headers.

Bye for now,

John

_________________________________________________________________
Express yourself with cool new emoticons http://www.msn.co.uk/specials/myemo



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
