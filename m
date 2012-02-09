Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 17:24:30 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 04/16] Bluetooth: Add l2cap_chan_lock
Message-ID: <20120209192430.GD3174@joana>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797057-26331-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328797057-26331-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2012-02-09 16:17:25 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Channel lock will be used to lock L2CAP channels which are locked
> currently by socket locks.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |   11 +++++++++++
>  net/bluetooth/l2cap_core.c    |    2 ++
>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 42fdbb8..f9fe348 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -497,6 +497,7 @@ struct l2cap_chan {
>  
>  	void		*data;
>  	struct l2cap_ops *ops;
> +	struct mutex		lock;
>  };
>  
>  struct l2cap_ops {
> @@ -609,6 +610,16 @@ static inline void l2cap_chan_put(struct l2cap_chan *c)
>  		kfree(c);
>  }
>  
> +static inline void l2cap_chan_lock(struct l2cap_chan *chan)
> +{
> +	mutex_lock(&chan->lock);
> +}
> +
> +static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
> +{
> +	mutex_unlock(&chan->lock);
> +}
> +

I would call this just l2cap_lock(chan), the shorter the better. We will
always use "chan" in the parameter, so it is easy to understand.

	Gustavo
