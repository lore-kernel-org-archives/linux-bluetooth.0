Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131216202857.GB19601@elgon.mountain>
References: <20131216202857.GB19601@elgon.mountain>
Date: Mon, 16 Dec 2013 16:35:25 -0400
Message-ID: <CAJdJm_O9q3YgpjTQexbLvMm8ViViu+MrmRCqPwQDDUzaxVQYUg@mail.gmail.com>
Subject: Re: [patch] Bluetooth: fix ->alloc_skb() error checking
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

On Mon, Dec 16, 2013 at 4:28 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> @@ -2413,8 +2413,8 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
>
>         skb = chan->ops->alloc_skb(chan, count + L2CAP_HDR_SIZE,
>                                    msg->msg_flags & MSG_DONTWAIT);
> -       if (IS_ERR(skb))
> -               return skb;
> +       if (skb)
> +               return ERR_PTR(-ENOMEM);

It should be "!skb" above right?

>
>         skb->priority = priority;
>

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
