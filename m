Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: john smith <roofass@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY22-F42hUaRTpCkEW000285a5@hotmail.com>
References: <BAY22-F42hUaRTpCkEW000285a5@hotmail.com>
Content-Type: text/plain
Message-Id: <1092651309.4375.119.camel@pegasus>
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
Date: Mon, 16 Aug 2004 12:15:09 +0200

Hi John,

> >the rule is to not include headers from the kernel source code in any
> >user space program or library. Even if some people try to bend this rule
> >I will follow as much as I can.
> 
> Hi, I'm new to Linux prog. and I'm a bit confused. Does this mean there's a 
> problem with bluez/utils/tools/l2ping.c which contains:
> 
>    #include <asm/types.h>
>    #include <asm/byteorder.h>
> 
> 
> Or are the above includes System kernel headers ( which as far as I 
> understand are OK for user-space apps. to link to) rather than Kernel source 
> headers.

we don't include kernel headers and asm/* are kernel headers. So it
seems that there are some leftovers and I hopefully now cleaned them up.
Can someone doublecheck on little and big endian machines that I don't
made any mistakes. Please also check the RFCOMM part of hcidump.

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
