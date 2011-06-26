Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: Peter Hurley <peter@hurleysoftware.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 26 Jun 2011 09:16:58 +0200
Subject: RE: [PATCH] Bluetooth: Fix hidp disconnect deadlock
Message-ID: <AC090B9732AB2B4DB7FF476E907FE66001315315BF@dnce02.ent.ti.com>
References: <1309037555.2143.5.camel@THOR>
In-Reply-To: <1309037555.2143.5.camel@THOR>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
IMHO the fix isnt good due to possible race condition which 
will destroy session/task objects - either by a call to kthread_stop
from the timer func or reentry to hidp_del_connection() on 
smp platforms.
see the intopic comments


> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Peter Hurley
> Sent: Sunday, June 26, 2011 12:33 AM
> To: linux-bluetooth
> Subject: [PATCH] Bluetooth: Fix hidp disconnect deadlock
> 
> Release reader lock on r/w sem before stopping khidp thread (which
> needs to
> claim the writer lock on sem before unlinking the session).
> 
> NB: kthread_stop waits for thread completion.
> ---
>  net/bluetooth/hidp/core.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index c405a95..16d75d7 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -1096,6 +1096,7 @@ int hidp_del_connection(struct hidp_conndel_req
> *req)
>  {
>  	struct hidp_session *session;
>  	int err = 0;
> +	bool stop_thread = false;
> 
>  	BT_DBG("");
> 
> @@ -1111,12 +1112,14 @@ int hidp_del_connection(struct hidp_conndel_req
> *req)
>  			skb_queue_purge(&session->ctrl_transmit);
>  			skb_queue_purge(&session->intr_transmit);
> 
> -			kthread_stop(session->task);
> +			stop_thread = true;
>  		}
>  	} else
>  		err = -ENOENT;
> 
>  	up_read(&hidp_session_sem);
> +	if (stop_thread)

Timer fires here - session is destroyed.

> +		kthread_stop(session->task);
>  	return err;
>  }
> 
> --
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I am working on a better solution which will ensure the async deletion
of session kthread operates correctly from different exec. contexts

Regards

Ilia Kolominsky
iliak@ti.com
Direct:  +972(9)7906231
Mobile: +972(54)909009

