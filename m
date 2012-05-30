Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 04:17:18 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Do not check func ready existence
Message-ID: <20120530071718.GK18069@joana>
References: <20120529152357.GA4575@joana>
 <1338360932-29940-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338360932-29940-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-05-30 09:55:32 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Functions will be always defined and in case not implemented as
> dummy __no_func.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 778c0c8..4f65a32 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -937,8 +937,7 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
>  
>  	chan->state = BT_CONNECTED;
>  
> -	if (chan->ops->ready)
> -		chan->ops->ready(chan);
> +	chan->ops->ready(chan);

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
