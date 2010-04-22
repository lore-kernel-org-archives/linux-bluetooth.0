Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Thu, 22 Apr 2010 09:33:47 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrei Emeltchenko <andrei.emeltchenko@nokia.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] bluetooth: handle l2cap_create_connless_pdu() errors
Message-ID: <20100422123347.GA5265@vigoh>
References: <20100422095201.GO29647@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100422095201.GO29647@bicker>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

* Dan Carpenter <error27@gmail.com> [2010-04-22 11:52:01 +0200]:

> l2cap_create_connless_pdu() can sometimes return ERR_PTR(-ENOMEM) or
> ERR_PTR(-EFAULT).
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 99d68c3..9753b69 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1626,7 +1626,10 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
>  	/* Connectionless channel */
>  	if (sk->sk_type == SOCK_DGRAM) {
>  		skb = l2cap_create_connless_pdu(sk, msg, len);
> -		err = l2cap_do_send(sk, skb);
> +		if (IS_ERR(skb))
> +			err = PTR_ERR(skb);
> +		else
> +			err = l2cap_do_send(sk, skb);
>  		goto done;
>  	}

Your fix looks ok, but we have changed l2cap_do_send() to void, so you
have to modify your patch.

That change is not in the bluetooth-testingtree yet, so remote add my git
tree and use the branch ertm.

git://git.profusion.mobi/users/padovan/bluetooth-testing.git

Regards,

-- 
Gustavo F. Padovan
http://padovan.org
