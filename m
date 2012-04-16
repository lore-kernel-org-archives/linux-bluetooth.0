Return-Path: <cyrus@holtmann.org>
Message-ID: <1334583579.16897.175.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: trivial: Remove empty line
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 16 Apr 2012 15:39:39 +0200
In-Reply-To: <1334583124-15134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1334583124-15134-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index e0e5549..0fac788 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -532,7 +532,6 @@ struct l2cap_ops {
>  	void			(*state_change) (void *data, int state);
>  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
>  					unsigned long len, int nb);
> -
>  };
>  
>  struct l2cap_conn {

patch has been applied to bluetooth-next tree.

Regards

Marcel


