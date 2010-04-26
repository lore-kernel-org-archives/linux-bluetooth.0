Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Apr 2010 12:09:19 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrei Emeltchenko <andrei.emeltchenko@nokia.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch v2] bluetooth: handle l2cap_create_connless_pdu() errors
Message-ID: <20100426150919.GA12813@vigoh>
References: <20100422095201.GO29647@bicker>
 <20100422123347.GA5265@vigoh>
 <20100426113627.GS29093@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100426113627.GS29093@bicker>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

* Dan Carpenter <error27@gmail.com> [2010-04-26 13:36:27 +0200]:

> l2cap_create_connless_pdu() can sometimes return ERR_PTR(-ENOMEM) or
> ERR_PTR(-EFAULT).
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> In v2 I wrote the patch on top of Gustavo Padovon's devel tree
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index a668ef4..b32682c 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1712,8 +1712,12 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
>  	/* Connectionless channel */
>  	if (sk->sk_type == SOCK_DGRAM) {
>  		skb = l2cap_create_connless_pdu(sk, msg, len);
> -		l2cap_do_send(sk, skb);
> -		err = len;
> +		if (IS_ERR(skb)) {
> +			err = PTR_ERR(skb);

Remove the braces on the 'if', then we are fine to pick your patch ;)

> +		} else {
> +			l2cap_do_send(sk, skb);
> +			err = len;
> +		}
>  		goto done;
>  	}
>  


Regards,

-- 
Gustavo F. Padovan
http://padovan.org
