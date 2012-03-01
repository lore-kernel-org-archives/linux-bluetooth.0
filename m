Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Mar 2012 14:23:27 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Subject: Re: [PATCH v4 1/2] Bluetooth: Remove usage of __cancel_delayed_work()
Message-ID: <20120301122324.GD25627@aemeltch-MOBL1>
References: <1327955189-4604-1-git-send-email-ulisses@profusion.mobi>
 <20120301091024.GC25627@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120301091024.GC25627@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > __cancel_delayed_work() is being used in some paths where we cannot
> > sleep waiting for the delayed work to finish. However, that function
> > might return while the timer is running and the work will be queued
> > again. Replace the calls with safer cancel_delayed_work() version
> > which spins until the timer handler finishes on other CPUs and
> > cancels the delayed work.
> > 
> > Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> > ---
> >  include/net/bluetooth/l2cap.h |    4 ++--
> >  net/bluetooth/l2cap_core.c    |    6 +++---
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index e7a8cc7..42fdbb8 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -614,7 +614,7 @@ static inline void l2cap_set_timer(struct l2cap_chan *chan,
> >  {
> >  	BT_DBG("chan %p state %d timeout %ld", chan, chan->state, timeout);
> >  
> > -	if (!__cancel_delayed_work(work))
> > +	if (!cancel_delayed_work(work))
> >  		l2cap_chan_hold(chan);
> >  	schedule_delayed_work(work, timeout);
> >  }
> > @@ -624,7 +624,7 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
> >  {
> >  	bool ret;
> >  
> > -	ret = __cancel_delayed_work(work);
> > +	ret = cancel_delayed_work(work);
> >  	if (ret)
> >  		l2cap_chan_put(chan);
> >  
> 
> 
> I have some questions about delayed_work usage:
> 
> When setting timer with l2cap_set_timer() we hold_chan if work may be
> running. So if previous work is cancelled OK we do not hold chan.
> 
> Didn't we miss hold_chan here?
> 
> Then in l2cap_clear_chan we put_chan if work cancelled OK, otherwise
> put_chan is done in delayed_work so we always put_chan.

What about following change:

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a357336..d61e158 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -628,17 +628,6 @@ static inline void l2cap_chan_unlock(struct
l2cap_chan *chan)
        mutex_unlock(&chan->lock);
 }
 
-static inline void l2cap_set_timer(struct l2cap_chan *chan,
-                                       struct delayed_work *work, long
                                        timeout)
-{
-       BT_DBG("chan %p state %s timeout %ld", chan,
-                                       state_to_string(chan->state),
                                        timeout);
-
-       if (!cancel_delayed_work(work))
-               l2cap_chan_hold(chan);
-       schedule_delayed_work(work, timeout);
-}
-
 static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
                                        struct delayed_work *work)
 {
@@ -651,6 +640,18 @@ static inline bool l2cap_clear_timer(struct
l2cap_chan *chan,
        return ret;
 }
 
+static inline void l2cap_set_timer(struct l2cap_chan *chan,
+                                       struct delayed_work *work, long
timeout)
+{
+       BT_DBG("chan %p state %s timeout %ld", chan,
+                                       state_to_string(chan->state),
timeout);
+
+       l2cap_clear_timer(chan, work);
+
+       l2cap_chan_hold(chan);
+       schedule_delayed_work(work, timeout);
+}
+
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
 #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
 #define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \

Best regards 
Andrei Emeltchenko 
