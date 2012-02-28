Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Feb 2012 09:57:22 +0200
From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] Bluetooth: use kfree_skb() instead of kfree()
Message-ID: <20120228075720.GA4381@aemeltch-MOBL1>
References: <20120228065246.GC20506@elgon.mountain>
MIME-Version: 1.0
In-Reply-To: <20120228065246.GC20506@elgon.mountain>
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 28, 2012 at 09:52:46AM +0300, Dan Carpenter wrote:
> sk_buffs should be freed using kfree_skb().
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Sorry missed that.

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index bdcfbf0..df3be69 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4284,7 +4284,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>  	if (!chan) {
>  		BT_DBG("unknown cid 0x%4.4x", cid);
>  		/* Drop packet and return */
> -		kfree(skb);
> +		kfree_skb(skb);
>  		return 0;
>  	}
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
