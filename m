Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 May 2012 11:18:21 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded calculation and magic number
Message-ID: <20120503081814.GA8310@aemeltch-MOBL1>
References: <1336031752-8153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336031752-8153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 03, 2012 at 10:55:52AM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Remove magic number unneeded calculation since
> hlen = L2CAP_HDR_SIZE + L2CAP_PSMLEN_SIZE

Since Gustavo removed hlen I'll do the same.

Best regards 
Andrei Emeltchenko 

> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 07a09cc..1748c3c 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1922,8 +1922,8 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
>  	/* Create L2CAP header */
>  	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
>  	lh->cid = cpu_to_le16(chan->dcid);
> -	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
> -	put_unaligned(chan->psm, skb_put(skb, 2));
> +	lh->len = cpu_to_le16(len + L2CAP_PSMLEN_SIZE);
> +	put_unaligned(chan->psm, skb_put(skb, L2CAP_PSMLEN_SIZE));
>  
>  	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
>  	if (unlikely(err < 0)) {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
