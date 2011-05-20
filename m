Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 23:34:42 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: David Miller <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: Kill set but unused variable 'pi' in
 l2cap_data_channel()
Message-ID: <20110520023440.GD4888@joana>
References: <20110519.174712.485186818693543128.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110519.174712.485186818693543128.davem@davemloft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* David Miller <davem@davemloft.net> [2011-05-19 17:47:12 -0400]:

> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a86f9ba..84ebe8d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3667,7 +3667,6 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>  {
>  	struct l2cap_chan *chan;
>  	struct sock *sk = NULL;
> -	struct l2cap_pinfo *pi;
>  	u16 control;
>  	u8 tx_seq;
>  	int len;
> @@ -3679,7 +3678,6 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
>  	}
>  
>  	sk = chan->sk;
> -	pi = l2cap_pi(sk);
>  
>  	BT_DBG("chan %p, len %d", chan, skb->len);

I fixed this one already. Thanks anyway.

-- 
Gustavo F. Padovan
http://profusion.mobi
