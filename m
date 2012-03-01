Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Mar 2012 11:10:26 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Subject: Re: [PATCH v4 1/2] Bluetooth: Remove usage of __cancel_delayed_work()
Message-ID: <20120301091024.GC25627@aemeltch-MOBL1>
References: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

On Mon, Jan 30, 2012 at 06:26:28PM -0200, Ulisses Furquim wrote:
> __cancel_delayed_work() is being used in some paths where we cannot
> sleep waiting for the delayed work to finish. However, that function
> might return while the timer is running and the work will be queued
> again. Replace the calls with safer cancel_delayed_work() version
> which spins until the timer handler finishes on other CPUs and
> cancels the delayed work.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  include/net/bluetooth/l2cap.h |    4 ++--
>  net/bluetooth/l2cap_core.c    |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index e7a8cc7..42fdbb8 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -614,7 +614,7 @@ static inline void l2cap_set_timer(struct l2cap_chan *chan,
>  {
>  	BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
>  
> -	if (!__cancel_delayed_work(work))
> +	if (!cancel_delayed_work(work))
>  		l2cap_chan_hold(chan);
>  	schedule_delayed_work(work, timeout);
>  }
> @@ -624,7 +624,7 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
>  {
>  	bool ret;
>  
> -	ret = __cancel_delayed_work(work);
> +	ret = cancel_delayed_work(work);
>  	if (ret)
>  		l2cap_chan_put(chan);
>  


I have some questions about delayed_work usage:

When setting timer with l2cap_set_timer() we hold_chan if work may be
running. So if previous work is cancelled OK we do not hold chan.

Didn't we miss hold_chan here?

Then in l2cap_clear_chan we put_chan if work cancelled OK, otherwise
put_chan is done in delayed_work so we always put_chan.

I am actually seeing some crashes in rare cases related to delayed work.

Best regards 
Andrei Emeltchenko 
