Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Jun 2011 17:24:56 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: "Ilia, Kolominsky" <iliak@ti.com>
Cc: Peter Hurley <peter@hurleysoftware.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Fix hidp disconnect deadlock
Message-ID: <20110629202456.GA6490@joana>
References: <1309037555.2143.5.camel@THOR>
 <AC090B9732AB2B4DB7FF476E907FE66001315315BF@dnce02.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AC090B9732AB2B4DB7FF476E907FE66001315315BF@dnce02.ent.ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Ilia, Kolominsky <iliak@ti.com> [2011-06-26 09:16:58 +0200]:

> Hi!
> IMHO the fix isnt good due to possible race condition which 
> will destroy session/task objects - either by a call to kthread_stop
> from the timer func or reentry to hidp_del_connection() on 
> smp platforms.
> see the intopic comments
> 
> 
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Peter Hurley
> > Sent: Sunday, June 26, 2011 12:33 AM
> > To: linux-bluetooth
> > Subject: [PATCH] Bluetooth: Fix hidp disconnect deadlock
> > 
> > Release reader lock on r/w sem before stopping khidp thread (which
> > needs to
> > claim the writer lock on sem before unlinking the session).
> > 
> > NB: kthread_stop waits for thread completion.
> > ---
> >  net/bluetooth/hidp/core.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> > index c405a95..16d75d7 100644
> > --- a/net/bluetooth/hidp/core.c
> > +++ b/net/bluetooth/hidp/core.c
> > @@ -1096,6 +1096,7 @@ int hidp_del_connection(struct hidp_conndel_req
> > *req)
> >  {
> >  	struct hidp_session *session;
> >  	int err = 0;
> > +	bool stop_thread = false;
> > 
> >  	BT_DBG("");
> > 
> > @@ -1111,12 +1112,14 @@ int hidp_del_connection(struct hidp_conndel_req
> > *req)
> >  			skb_queue_purge(&session->ctrl_transmit);
> >  			skb_queue_purge(&session->intr_transmit);
> > 
> > -			kthread_stop(session->task);
> > +			stop_thread = true;
> >  		}
> >  	} else
> >  		err = -ENOENT;
> > 
> >  	up_read(&hidp_session_sem);
> > +	if (stop_thread)
> 
> Timer fires here - session is destroyed.
> 
> > +		kthread_stop(session->task);
> >  	return err;
> >  }
> > 
> > --
> > 1.7.4.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> I am working on a better solution which will ensure the async deletion
> of session kthread operates correctly from different exec. contexts

Are you going to deliver this soon? This needs to be fixed on 3.0.

	Gustavo
