Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 9 Feb 2012 16:13:31 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 06/16] Bluetooth: Add socket error function
Message-ID: <20120209181331.GB3174@joana>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797057-26331-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797859.28848.23.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328797859.28848.23.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-02-09 15:30:59 +0100]:

> Hi Andrei,
> 
> > Use locked and unlocked versions to help removing socket
> > locks from l2cap.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |   30 +++++++++++++++++++++---------
> >  1 files changed, 21 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index a23c306..e6515b3 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -243,6 +243,22 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
> >  	release_sock(sk);
> >  }
> >  
> > +static inline void __l2cap_set_sock_err(struct l2cap_chan *chan, int err)
> > +{
> > +	struct sock *sk = chan->sk;
> > +
> > +	sk->sk_err = err;
> > +}
> > +
> > +static inline void l2cap_set_sock_err(struct l2cap_chan *chan, int err)
> > +{
> > +	struct sock *sk = chan->sk;
> > +
> > +	lock_sock(sk);
> > +	__l2cap_set_sock_err(chan, err);
> > +	release_sock(sk);
> > +}
> 
> I think we better call this l2cap_chan_set_sock_err(). Sounds kinda
> long, but makes it a bit more clearer what it does.

Or l2cap_chan_set_err() since this will be made generic once the separation
between core and sock is done.

	Gustavo
