Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Nov 2011 16:26:21 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Allow L2CAP to increase the security level
Message-ID: <20111108182621.GE25584@joana>
References: <1320677128-25949-1-git-send-email-padovan@profusion.mobi>
 <1320677128-25949-2-git-send-email-padovan@profusion.mobi>
 <1320710358.15441.312.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320710358.15441.312.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, 

* Marcel Holtmann <marcel@holtmann.org> [2011-11-08 08:59:15 +0900]:

> Hi Gustavo,
> 
> > Some incomming connections needs to increase the security level by
> > requesting encryption for example (HID keyboard case). This change allows
> > the userspace to change it through setsockopt with defer_setup enabled.
> > 
> > Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> > ---
> >  include/net/bluetooth/l2cap.h |    1 +
> >  net/bluetooth/l2cap_core.c    |    2 +-
> >  net/bluetooth/l2cap_sock.c    |   13 ++++++++++---
> >  3 files changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index fdb2b78..5ff38e9 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -810,5 +810,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan);
> >  int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> >  								u32 priority);
> >  void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
> > +int l2cap_chan_check_security(struct l2cap_chan *chan);
> >  
> >  #endif /* __L2CAP_H */
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 793971c..6a5c1b2 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -516,7 +516,7 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
> >  }
> >  
> >  /* Service level security */
> > -static inline int l2cap_chan_check_security(struct l2cap_chan *chan)
> > +int l2cap_chan_check_security(struct l2cap_chan *chan)
> >  {
> >  	struct l2cap_conn *conn = chan->conn;
> >  	__u8 auth_type;
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 664762e..b58f40c 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -623,8 +623,12 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
> >  
> >  		chan->sec_level = sec.level;
> >  
> > +		if (!chan->conn)
> > +			break;
> > +
> >  		conn = chan->conn;
> 
> is this fixing a real bug? Can chan->conn really be NULL?

Not really fixing, this check was here before. For LE only make senes call
smp_conn_security() if a conn exists and the goes for
l2cap_chan_check_security().

> 
> > -		if (conn && chan->scid == L2CAP_CID_LE_DATA) {
> > +
> > +		if (chan->scid == L2CAP_CID_LE_DATA) {
> >  			if (!conn->hcon->out) {
> >  				err = -EINVAL;
> >  				break;
> > @@ -632,9 +636,12 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
> >  
> >  			if (smp_conn_security(conn, sec.level))
> >  				break;
> > -
> > -			err = 0;
> >  			sk->sk_state = BT_CONFIG;
> > +		} else if (sk->sk_state == BT_CONNECT2 &&
> > +					bt_sk(sk)->defer_setup) {
> > +			err = l2cap_chan_check_security(chan);
> > +		} else {
> > +			err = -EINVAL;
> >  		}
> >  		break;
> >  
> 
> You might wanna add some comments here on what each if block is for.
> This becomes a complex statements and we need comments here to keep us
> sane.

Sure.

	Gustavo
