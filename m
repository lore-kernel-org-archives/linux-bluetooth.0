Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Oct 2012 19:13:33 +0800
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v2 2/8] Bluetooth: Move bt_accept_enqueue() to
 l2cap_sock.c
Message-ID: <20121012111333.GA28715@joana>
References: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
 <1349938311-25101-2-git-send-email-gustavo@padovan.org>
 <1349963078.27233.166.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349963078.27233.166.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-10-11 15:44:38 +0200]:

> Hi Gustavo,
> 
> > This is move the parent socket usage to l2cap_sock.c
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> >  net/bluetooth/l2cap_core.c | 4 ----
> >  net/bluetooth/l2cap_sock.c | 2 ++
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index b382631..e10a1a3 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1233,8 +1233,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
> >  	bacpy(&bt_sk(sk)->src, conn->src);
> >  	bacpy(&bt_sk(sk)->dst, conn->dst);
> >  
> > -	bt_accept_enqueue(parent, sk);
> > -
> >  	l2cap_chan_add(conn, chan);
> >  
> >  	l2cap_chan_ready(chan);
> > @@ -3451,8 +3449,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn,
> >  	chan->psm  = psm;
> >  	chan->dcid = scid;
> >  
> > -	bt_accept_enqueue(parent, sk);
> > -
> >  	__l2cap_chan_add(conn, chan);
> >  
> >  	dcid = chan->scid;
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index f95fc7e..d5093b8 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -949,6 +949,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
> >  
> >  	l2cap_sock_init(sk, parent);
> >  
> > +	bt_accept_enqueue(parent, sk);
> > +
> >  	return l2cap_pi(sk)->chan;
> >  }
> >  
> 
> and this has no side effect with adding during this window. Your commit
> message is not really explaining why this is fine. Please fix that.

No, it is safe to this here. If you look to the flow you will see that this
change is trivial actually. I'll add some more explanation to the commit
message.

	Gustavo
