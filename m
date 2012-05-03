Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 May 2012 10:43:53 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded elements from size calculation
Message-ID: <20120503074351.GB7483@aemeltch-MOBL1>
References: <1335970577-19224-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335970577-19224-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, May 02, 2012 at 11:56:17AM -0300, Gustavo Padovan wrote:
> hlen - L2CAP_HDR_SIZE = 0, so we don't need to add them in the

I feel that hlen is not needed and might be changed to L2CAP_HDR_SIZE.

Best regards 
Andrei Emeltchenko 

> calculation.
> 
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 0f2b1be..870116a 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1909,7 +1909,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
>  	/* Create L2CAP header */
>  	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
>  	lh->cid = cpu_to_le16(chan->dcid);
> -	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
> +	lh->len = cpu_to_le16(len);
>  
>  	err = l2cap_skbuff_fromiovec(chan, msg, len, count, skb);
>  	if (unlikely(err < 0)) {
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
