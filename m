Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 00:10:32 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 06/30] Bluetooth: Timers fixes
Message-ID: <20120320030747.GC9142@joana>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331814621-13905-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331814621-13905-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-15 14:29:57 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index d9c668c..1a5c9e6 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -624,29 +624,30 @@ static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
>  	mutex_unlock(&chan->lock);
>  }
>  
> -static inline void l2cap_set_timer(struct l2cap_chan *chan,
> -					struct delayed_work *work, long timeout)
> -{
> -	BT_DBG("chan %p state %s timeout %ld", chan,
> -					state_to_string(chan->state), timeout);
> -
> -	if (!cancel_delayed_work(work))
> -		l2cap_chan_hold(chan);
> -	schedule_delayed_work(work, timeout);
> -}
> -
>  static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
>  					struct delayed_work *work)
>  {
>  	bool ret;
>  
> -	ret = cancel_delayed_work(work);
> +	ret = (delayed_work_pending(work) && cancel_delayed_work(work));
>  	if (ret)
>  		l2cap_chan_put(chan);
>  
>  	return ret;
>  }
>  
> +static inline void l2cap_set_timer(struct l2cap_chan *chan,
> +					struct delayed_work *work, long timeout)
> +{
> +	BT_DBG("chan %p state %s timeout %ld", chan,
> +					state_to_string(chan->state), timeout);
> +
> +	l2cap_clear_timer(chan, work);
> +
> +	l2cap_chan_hold(chan);
> +	schedule_delayed_work(work, timeout);
> +}
> +

This one looks good, but you need to improve the title and commit message.
As it is a fix send it before the others.

	Gustavo
