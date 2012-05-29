Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 May 2012 12:23:57 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Do not check func ready existence
Message-ID: <20120529152357.GA4575@joana>
References: <1338239783-26599-3-git-send-email-gustavo@padovan.org>
 <1338275460-16370-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338275460-16370-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-05-29 10:11:00 +0300]:

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
> index 2e984ec..6399e3f 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -957,8 +957,7 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
>  
>  	chan->state = BT_CONNECTED;
>  
> -	if (chan->ops->ready)
> -		chan->ops->ready(chan);
> +	chan->ops->ready(chan);
>  }
>  
>  static void l2cap_choose_conn(struct l2cap_chan *chan)

This is not rebased against upstream, we don't have this function in there.

	Gustavo
