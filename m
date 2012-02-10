Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Feb 2012 10:46:36 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 06/16] Bluetooth: Add socket error function
Message-ID: <20120210084634.GD28197@aemeltch-MOBL1>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797057-26331-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797859.28848.23.camel@aeonflux>
 <20120209181331.GB3174@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120209181331.GB3174@joana>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Gustavo,

On Thu, Feb 09, 2012 at 04:13:31PM -0200, Gustavo Padovan wrote:
> > > +static inline void __l2cap_set_sock_err(struct l2cap_chan *chan, int err)
> > > +{
> > > +	struct sock *sk = chan->sk;
> > > +
> > > +	sk->sk_err = err;
> > > +}
> > > +
> > > +static inline void l2cap_set_sock_err(struct l2cap_chan *chan, int err)
> > > +{
> > > +	struct sock *sk = chan->sk;
> > > +
> > > +	lock_sock(sk);
> > > +	__l2cap_set_sock_err(chan, err);
> > > +	release_sock(sk);
> > > +}
> > 
> > I think we better call this l2cap_chan_set_sock_err(). Sounds kinda
> > long, but makes it a bit more clearer what it does.
> 
> Or l2cap_chan_set_err() since this will be made generic once the separation
> between core and sock is done.

So which of the proposed names better to use? Both looks OK.

Best regards 
Andrei Emeltchenko 
