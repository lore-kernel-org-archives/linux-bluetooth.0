Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 14:06:11 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 2/2] Bluetooth: Remove last usage of sk->sk_state_change()
Message-ID: <20120524170611.GF3105@joana>
References: <1337839374-20443-3-git-send-email-gustavo@padovan.org>
 <1337842817-27865-1-git-send-email-gustavo@padovan.org>
 <1337842817-27865-2-git-send-email-gustavo@padovan.org>
 <20120524083043.GF24715@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120524083043.GF24715@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2012-05-24 11:30:45 +0300]:

> Hi Gustavo,
> 
> On Thu, May 24, 2012 at 04:00:17AM -0300, Gustavo Padovan wrote:
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > 
> > If the is not oriented we should call sk_state_change() just after set the
> > channel state to BT_CONNECTED.
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> >  net/bluetooth/l2cap_core.c |    6 +-----
> >  net/bluetooth/l2cap_sock.c |    4 ++++
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 0d22695..6137b48 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1176,12 +1176,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
> >  				l2cap_chan_ready(chan);
> >  
> >  		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
> > -			struct sock *sk = chan->sk;
> >  			__clear_chan_timer(chan);
> > -			lock_sock(sk);
> > -			__l2cap_state_change(chan, BT_CONNECTED);
> > -			sk->sk_state_change(sk);
> > -			release_sock(sk);
> > +			l2cap_state_change(chan, BT_CONNECTED);
> >  
> >  		} else if (chan->state == BT_CONNECT)
> >  			l2cap_do_start(chan);
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 0a1a827..9fd9412 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -1018,6 +1018,10 @@ static void l2cap_sock_state_change_cb(void *data, int state)
> >  	struct sock *sk = data;
> >  
> >  	sk->sk_state = state;
> > +
> > +	if (state == BT_CONNECTED &&
> > +	    l2cap_pi(sk)->chan->chan_type != L2CAP_CHAN_CONN_ORIENTED)
> > +		sk->sk_state_change(sk);
> 
> Somehow I feel that there is too much logic here.

Yes, there is, I failed to find something better.

>BTW: can we use
> sk_state_change for every state_change callback?

No, it would be a bit expensive call sk_state_change() everytime here.

	Gustavo
