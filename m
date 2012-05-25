Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 15:39:34 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v2 12/12] Bluetooth: Used void * as parameter in
 alloc_skb()
Message-ID: <20120525123932.GH3089@aemeltch-MOBL1>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
 <1337949064-26187-13-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337949064-26187-13-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, May 25, 2012 at 09:31:04AM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> This keep l2cap chan ops functions parameters in sync.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

...

> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 25a85ab..0f8886b 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -532,8 +532,8 @@ struct l2cap_ops {
>  	void			(*close) (void *data);
>  	void			(*teardown) (void *data, int err);
>  	void			(*state_change) (void *data, int state);
> -	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
> -					       unsigned long len, int nb);
> +	struct sk_buff		*(*alloc_skb) (void *data, unsigned long len,
> +					       int nb);

...

> @@ -1893,7 +1893,7 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
>  
>  		count = min_t(unsigned int, conn->mtu, len);
>  
> -		tmp = chan->ops->alloc_skb(chan, count,
> +		tmp = chan->ops->alloc_skb(chan->data, count,

Why do we need to pass chan->data instead of chan?

Best regards 
Andrei Emeltchenko 

