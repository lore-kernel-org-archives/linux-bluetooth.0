Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BCSP not working
From: Marcel Holtmann <marcel@holtmann.org>
To: Carlos AM <Carlos@naxus.biz>
Cc: lista bluez <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000c01c4847b$d1fe14f0$5000005a@naxus>
References: <000c01c4847b$d1fe14f0$5000005a@naxus>
Content-Type: text/plain
Message-Id: <1092818534.31651.63.camel@pegasus>
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
Date: Wed, 18 Aug 2004 10:42:14 +0200

Hi Carlos,

> These messages appear on the kernel log when I am using BCSP:
>  
> <3>bcsp_recv: Out-of-order packet arrived, got 1 expected 0
> <3>bcsp_recv: Checksum failed: computed b237 received 0000
> <4>Warning: kfree_skb passed an skb still on a list (from 000f77a4).
> <2>kernel BUG at skbuff.c:319!
> <3>bcsp_recv: Short BCSP packet
>  
> Then the computer hangs.
>  
> I enabled "Send CRC with every hci packet" in the kernel and in the
> bluetooth device.

I asked for more information not some extra text. What kernel version
are using, what library version, what tools. What hardware, what command
for reproducing etc. Is there an oops?

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
