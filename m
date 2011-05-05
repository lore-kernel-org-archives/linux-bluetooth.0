Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 May 2011 13:30:08 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allow unsegmented SDU retries on
 sock_queue_rcv_skb failure.
Message-ID: <20110505163008.GA2139@joana>
References: <1303990781-15538-1-git-send-email-Ruiyi.zhang@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303990781-15538-1-git-send-email-Ruiyi.zhang@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruiyi,

* Ruiyi Zhang <Ruiyi.zhang@atheros.com> [2011-04-28 19:39:41 +0800]:

>  In L2CAP_SDU_UNSEGMENTED case, if sock_queue_rcv_skb returns error,
>  l2cap_ertm_reassembly_sdu should not return 0 so as to insert the
>  skb into BUSY_QUEUE for later retries.
> 
> 
> Signed-off-by: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
> ---
>  net/bluetooth/l2cap_core.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ca27f3a..3b2f140 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2784,8 +2784,7 @@ static int l2cap_ertm_reassembly_sdu(struct sock *sk, struct sk_buff *skb, u16 c
>  			goto drop;
>  
>  		err = sock_queue_rcv_skb(sk, skb);
> -		if (!err)
> -			return err;
> +		return err;
>  
>  		break;

I prefer simply
		return sock_queue_rcv_skb();

and remove the break inclusive.

-- 
Gustavo F. Padovan
http://profusion.mobi
