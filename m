Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 19:39:49 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] Bluetooth: use kfree_skb() instead of kfree()
Message-ID: <20120301013949.GB26492@x220>
References: <20120228065246.GC20506@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120228065246.GC20506@elgon.mountain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

On Tue, Feb 28, 2012, Dan Carpenter wrote:
> sk_buffs should be freed using kfree_skb().
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
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

Applied to my bluetooth-next tree. Thanks.

Johan
