Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Oct 2012 18:48:02 +0800
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v2 4/8] Bluetooth: Add chan->ops->defer()
Message-ID: <20121012104802.GE10739@joana>
References: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
 <1349938311-25101-4-git-send-email-gustavo@padovan.org>
 <1349963363.27233.170.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349963363.27233.170.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-10-11 15:49:23 +0200]:

> Hi Gustavo,
> 
> > When DEFER_SETUP is set defer() will trigger an authorization
> > request to the userspace.
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> >  include/net/bluetooth/l2cap.h |  5 +++++
> >  net/bluetooth/a2mp.c          |  1 +
> >  net/bluetooth/l2cap_core.c    | 10 +++-------
> >  net/bluetooth/l2cap_sock.c    | 13 +++++++++++++
> >  4 files changed, 22 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index caab98c..6e23afd 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -541,6 +541,7 @@ struct l2cap_ops {
> >  	void			(*state_change) (struct l2cap_chan *chan,
> >  						 int state);
> >  	void			(*ready) (struct l2cap_chan *chan);
> > +	void			(*defer) (struct l2cap_chan *chan);
> >  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
> >  					       unsigned long len, int nb);
> >  };
> > @@ -748,6 +749,10 @@ static inline void l2cap_chan_no_ready(struct l2cap_chan *chan)
> >  {
> >  }
> >  
> > +static inline void l2cap_chan_no_defer(struct l2cap_chan *chan)
> > +{
> > +}
> > +
> >  extern bool disable_ertm;
> >  
> >  int l2cap_init_sockets(void);
> > diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> > index 3ff4dc9..7bf9a10 100644
> > --- a/net/bluetooth/a2mp.c
> > +++ b/net/bluetooth/a2mp.c
> > @@ -699,6 +699,7 @@ static struct l2cap_ops a2mp_chan_ops = {
> >  	.new_connection = l2cap_chan_no_new_connection,
> >  	.teardown = l2cap_chan_no_teardown,
> >  	.ready = l2cap_chan_no_ready,
> > +	.defer = l2cap_chan_no_defer,
> >  };
> >  
> >  static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 91d312b..a2f945d 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1123,11 +1123,9 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
> >  				lock_sock(sk);
> >  				if (test_bit(BT_SK_DEFER_SETUP,
> >  					     &bt_sk(sk)->flags)) {
> > -					struct sock *parent = bt_sk(sk)->parent;
> >  					rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
> >  					rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
> > -					if (parent)
> > -						parent->sk_data_ready(parent, 0);
> > +					chan->ops->defer(chan);
> 
> I would prefer you explain this in detail. Sine the no_defer is then no
> longer calling sk_data_ready. Is this safe?

Yes, this is safe, the no_defer exists only to be used by those that do not
implement DEFER_SETUP support. Actually ops->defer() will never be called if
DEFER_SETUP is no enabled.

> 
> >  
> >  				} else {
> >  					__l2cap_state_change(chan, BT_CONFIG);
> > @@ -3459,7 +3457,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn,
> >  				__l2cap_state_change(chan, BT_CONNECT2);
> >  				result = L2CAP_CR_PEND;
> >  				status = L2CAP_CS_AUTHOR_PEND;
> > -				parent->sk_data_ready(parent, 0);
> > +				chan->ops->defer(chan);
> >  			} else {
> >  				__l2cap_state_change(chan, BT_CONFIG);
> >  				result = L2CAP_CR_SUCCESS;
> > @@ -5520,11 +5518,9 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
> >  			if (!status) {
> >  				if (test_bit(BT_SK_DEFER_SETUP,
> >  					     &bt_sk(sk)->flags)) {
> > -					struct sock *parent = bt_sk(sk)->parent;
> >  					res = L2CAP_CR_PEND;
> >  					stat = L2CAP_CS_AUTHOR_PEND;
> > -					if (parent)
> > -						parent->sk_data_ready(parent, 0);
> > +					chan->ops->defer(chan);
> >  				} else {
> >  					__l2cap_state_change(chan, BT_CONFIG);
> >  					res = L2CAP_CR_SUCCESS;
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 45c81e1..efcb914 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -956,6 +956,7 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
> >  
> >  	bt_accept_enqueue(parent, sk);
> >  
> > +
> 
> No pointless empty lines please.

Yes, this is the leftover from a merge conflict. I'll remove it.

> 
> >  	release_sock(parent);
> >  
> >  	return l2cap_pi(sk)->chan;
> > @@ -1088,6 +1089,17 @@ static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
> >  	release_sock(sk);
> >  }
> >  
> > +static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
> > +{
> > +	struct sock *sk = chan->data;
> > +	struct sock *parent;
> > +
> > +	parent = bt_sk(sk)->parent;
> 
> You can do struct sock *parent = bt_sk(sk)-parent here.

Sure.

> 
> > +
> > +	if (parent)
> > +		parent->sk_data_ready(parent, 0);
> > +}
> > +
> >  static struct l2cap_ops l2cap_chan_ops = {
> >  	.name		= "L2CAP Socket Interface",
> >  	.new_connection	= l2cap_sock_new_connection_cb,
> > @@ -1096,6 +1108,7 @@ static struct l2cap_ops l2cap_chan_ops = {
> >  	.teardown	= l2cap_sock_teardown_cb,
> >  	.state_change	= l2cap_sock_state_change_cb,
> >  	.ready		= l2cap_sock_ready_cb,
> > +	.defer		= l2cap_sock_defer_cb,
> >  	.alloc_skb	= l2cap_sock_alloc_skb_cb,
> >  };
> >  
> 
> I am bit unease with accidentally having no_defer and then DEFER_SETUP
> is set. Are we not changing behavior here?

No, as I said above, this case will not happen.

	Gustavo
