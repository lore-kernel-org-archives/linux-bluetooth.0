Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 00:04:49 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 01/30] Bluetooth: Make ertm_init available
Message-ID: <20120320030449.GB9142@joana>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331814621-13905-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331814621-13905-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-15 14:29:52 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Function l2cap_ertm_init will be used for initialization
> fixed A2MP channel.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |    2 +-
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 9b242c6..c107944 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -861,5 +861,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
>  								u32 priority);
>  void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
>  int l2cap_chan_check_security(struct l2cap_chan *chan);
> +void l2cap_ertm_init(struct l2cap_chan *chan);
>  
>  #endif /* __L2CAP_H */
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 0a46603..b0d1cee 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2038,7 +2038,7 @@ static void l2cap_ack_timeout(struct work_struct *work)
>  	l2cap_chan_put(chan);
>  }
>  
> -static inline void l2cap_ertm_init(struct l2cap_chan *chan)
> +void l2cap_ertm_init(struct l2cap_chan *chan)

I prefer to see this kind of change with the actual code that uses it.

	Gustavo
