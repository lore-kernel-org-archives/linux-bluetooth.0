Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BCSP not working
From: Marcel Holtmann <marcel@holtmann.org>
To: Carlos AM <Carlos@naxus.biz>
Cc: bluez-devel lista <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092837623.28955.120.camel@localhost.localdomain>
References: <001201c48529$3b309710$5000005a@naxus>
	 <1092837623.28955.120.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1092850955.31651.111.camel@pegasus>
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
Date: Wed, 18 Aug 2004 19:42:35 +0200

Hi Carlos,

> The machine is an arm running uclinux. I used the linux kernel version
> 2.4.22 and bluez-2.7. Yesterday I patched the kernel with this patch:
> 
> http://www.holtmann.org/linux/kernel/patch-2.4.22-mh7.gz
> 
> And got the following kernel log:
> 
> <3>bcsp_recv: Out-of-order packet arrived, got 1 expected 0
> <3>bcsp_recv: Out-of-order packet arrived, got 1 expected 0
> <4>Warning: kfree_skb passed an skb still on a list (from 00093a14).
> <2>kernel BUG at skbuff.c:319!
> (hanged)
> 
> The only difference with the last kernel messages was:
>  "<3>bcsp_recv: Short BCSP packet" that didn't appear anymore.
> According to the kernel patch changelog this is normal.

I don't get your point, because I can't remember any change that implies
this. Actually I care about the kfree_skb bug, because it seems that
with ucLinux something works different. I am not an expert in that area,
so I can't help you here. Have you tried a 2.6 kernel?

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
