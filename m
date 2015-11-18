Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] BNEP multicast filter is filtering multicast addresses in default case although differently specified
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <564C6C35.4030305@proofnet.de>
Date: Wed, 18 Nov 2015 13:45:00 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F6214B06-650D-4DE0-A375-49652B8124A5@holtmann.org>
References: <564C6C35.4030305@proofnet.de>
To: Danny Schweizer <danny.schweizer@proofnet.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Danny,

> This patch fixes the Bug 106691 by changing the default multicast filter
> to not filter out any multicast addresses.
> 
> ---
> net/bluetooth/bnep/core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index 1641367..ba2467a 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -609,7 +609,7 @@ int bnep_add_connection(struct bnep_connadd_req
> *req, struct socket *sock)
> 
> #ifdef CONFIG_BT_BNEP_MC_FILTER
> 	/* Set default mc filter */
> -	set_bit(bnep_mc_hash(dev->broadcast), (ulong *) &s->mc_filter);
> +	s->mc_filter = ~0LL;
> #endif

I am not convinced that these two are actually the same expressions. You need to explain this a lot more in detail on why this change is correct.

Regards

Marcel

