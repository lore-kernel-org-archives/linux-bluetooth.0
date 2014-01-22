Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] 6lowpan: add a license to 6lowpan_iphc module
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390418724-9804-1-git-send-email-ydroneaud@opteya.com>
Date: Wed, 22 Jan 2014 14:49:09 -0800
Cc: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-zigbee-devel@lists.sourceforge.net,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	Alexander Aring <alex.aring@gmail.com>
Message-Id: <54C711A5-F3BA-4327-B070-3DBE884543D1@holtmann.org>
References: <1390418724-9804-1-git-send-email-ydroneaud@opteya.com>
To: Yann Droneaud <ydroneaud@opteya.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yann,

> Since commit 8df8c56a5abc, 6lowpan_iphc is a module of its own.
> 
> Unfortunately, it lacks some infrastructure to behave like a
> good kernel citizen:
> 
>  kernel: 6lowpan_iphc: module license 'unspecified' taints kernel.
>  kernel: Disabling lock debugging due to kernel taint
> 
> This patch adds the basic MODULE_LICENSE(); with GPL license:
> the code was copied from net/ieee802154/6lowpan.c which is GPL
> and the module exports symbol with EXPORT_SYMBOL_GPL();.
> 
> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---
> net/ieee802154/6lowpan_iphc.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/net/ieee802154/6lowpan_iphc.c b/net/ieee802154/6lowpan_iphc.c
> index e14fe8b2c054..860aa2d445ba 100644
> --- a/net/ieee802154/6lowpan_iphc.c
> +++ b/net/ieee802154/6lowpan_iphc.c
> @@ -52,6 +52,7 @@
> 
> #include <linux/bitops.h>
> #include <linux/if_arp.h>
> +#include <linux/module.h>
> #include <linux/netdevice.h>
> #include <net/ipv6.h>
> #include <net/af_ieee802154.h>
> @@ -797,3 +798,5 @@ int lowpan_header_compress(struct sk_buff *skb, struct net_device *dev,
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lowpan_header_compress);
> +
> +MODULE_LICENSE("GPL”);

looks good to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

