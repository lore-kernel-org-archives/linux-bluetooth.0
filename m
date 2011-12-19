Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Dec 2011 11:53:30 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 19/22] Bluetooth: Change l2cap chan_list to use RCU
Message-ID: <20111219135330.GD2610@joana>
References: <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-17-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-18-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-19-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-20-git-send-email-padovan@profusion.mobi>
 <20111219104254.GC3982@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111219104254.GC3982@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2011-12-19 12:42:57 +0200]:

> Hi Gustavo,
> 
> On Sat, Dec 17, 2011 at 07:29:39PM -0200, Gustavo F. Padovan wrote:
> > From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> > 
> > This list has much more reads than writes, so RCU makes senses here, also
> > it avoid deadlock against the socket lock.
> > 
> > Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> > ---
> >  net/bluetooth/l2cap_core.c |  117 +++++++++++++++++++++----------------------
> >  1 files changed, 57 insertions(+), 60 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index d616519..a212295 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -89,24 +89,36 @@ static inline void chan_put(struct l2cap_chan *c)
> >  
> >  static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
> >  {
> > -	struct l2cap_chan *c;
> > +	struct l2cap_chan *c, *r = NULL;
> >  
> > -	list_for_each_entry(c, &conn->chan_l, list) {
> > -		if (c->dcid == cid)
> > -			return c;
> > +	rcu_read_lock();
> > +
> > +	list_for_each_entry_rcu(c, &conn->chan_l, list) {
> > +		if (c->dcid == cid) {
> > +			r = c;
> > +			break;
> > +		}
> >  	}
> > +
> > +	rcu_read_unlock();
> >  	return NULL;
> >  }
> >  
> >  static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 cid)
> >  {
> > -	struct l2cap_chan *c;
> > +	struct l2cap_chan *c, *r = NULL;
> >  
> > -	list_for_each_entry(c, &conn->chan_l, list) {
> > -		if (c->scid == cid)
> > -			return c;
> > +	rcu_read_lock();
> > +
> > +	list_for_each_entry_rcu(c, &conn->chan_l, list) {
> > +		if (c->scid == cid) {
> > +			r = c;
> > +			break;
> > +		}
> >  	}
> > -	return NULL;
> > +
> > +	rcu_read_unlock();
> > +	return r;
> >  }
> >  
> >  /* Find channel with given SCID.
> > @@ -115,34 +127,36 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
> >  {
> >  	struct l2cap_chan *c;
> >  
> > -	mutex_lock(&conn->chan_lock);
> >  	c = __l2cap_get_chan_by_scid(conn, cid);
> >  	if (c)
> >  		lock_sock(c->sk);
> > -	mutex_unlock(&conn->chan_lock);
> >  	return c;
> >  }
> >  
> >  static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
> >  {
> > -	struct l2cap_chan *c;
> > +	struct l2cap_chan *c, *r = NULL;
> >  
> > -	list_for_each_entry(c, &conn->chan_l, list) {
> > -		if (c->ident == ident)
> > -			return c;
> > +	rcu_read_lock();
> > +
> > +	list_for_each_entry_rcu(c, &conn->chan_l, list) {
> > +		if (c->ident == ident) {
> > +			r = c;
> > +			break;
> > +		}
> >  	}
> > -	return NULL;
> > +
> > +	rcu_read_unlock();
> > +	return r;
> >  }
> >  
> >  static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
> >  {
> >  	struct l2cap_chan *c;
> >  
> > -	mutex_lock(&conn->chan_lock);
> >  	c = __l2cap_get_chan_by_ident(conn, ident);
> >  	if (c)
> >  		lock_sock(c->sk);
> > -	mutex_unlock(&conn->chan_lock);
> >  	return c;
> >  }
> >  
> > @@ -323,7 +337,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
> >  	chan_put(chan);
> >  }
> >  
> > -static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> > +static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> >  {
> >  	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
> >  			chan->psm, chan->dcid);
> > @@ -364,7 +378,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> >  
> >  	chan_hold(chan);
> >  
> > -	list_add(&chan->list, &conn->chan_l);
> > +	list_add_rcu(&chan->list, &conn->chan_l);
> >  }
> >  
> >  /* Delete channel.
> > @@ -381,9 +395,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> >  
> >  	if (conn) {
> >  		/* Delete from channel list */
> > -		mutex_lock(&conn->chan_lock);
> > -		list_del(&chan->list);
> > -		mutex_unlock(&conn->chan_lock);
> > +		list_del_rcu(&chan->list);
> > +		synchronize_rcu();
> > +
> >  		chan_put(chan);
> >  
> >  		chan->conn = NULL;
> > @@ -750,13 +764,13 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
> >  /* ---- L2CAP connections ---- */
> >  static void l2cap_conn_start(struct l2cap_conn *conn)
> >  {
> > -	struct l2cap_chan *chan, *tmp;
> > +	struct l2cap_chan *chan;
> >  
> >  	BT_DBG("conn %p", conn);
> >  
> > -	mutex_lock(&conn->chan_lock);
> > +	rcu_read_lock();
> >  
> > -	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
> > +	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
> >  		struct sock *sk = chan->sk;
> >  
> >  		bh_lock_sock(sk);
> > @@ -780,9 +794,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
> >  					&chan->conf_state)) {
> >  				/* l2cap_chan_close() calls list_del(chan)
> >  				 * so release the lock */
> > -				mutex_unlock(&conn->chan_lock);
> >  				l2cap_chan_close(chan, ECONNRESET);
> > -				utex_lock(&conn->chan_lock);
> 
> OK, I see why this works. BTW: IMO the mutex and rcu patches shall be
> amended, otherwise we do unneeded work of implementing mutexes and then
> changing them to RCU.

Indeed, but unfortunately I pushed the patches already and forgot to ammend
both path patches. I was trying to push this ASAP so you guys could rebase
your work on top of it.

	Gustavo
