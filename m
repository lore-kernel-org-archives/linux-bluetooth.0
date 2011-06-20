Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Jun 2011 17:03:38 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Fix not setting the chan state
Message-ID: <20110620200338.GE7240@joana>
References: <1308361587-8338-1-git-send-email-vinicius.gomes@openbossa.org>
 <20110620193131.GC7240@joana>
 <20110620200156.GA13325@piper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110620200156.GA13325@piper>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-06-20 17:01:56 -0300]:

> Hi Gustavo,
> 
> On 16:31 Mon 20 Jun, Gustavo F. Padovan wrote:
> > * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-06-17 22:46:25 -0300]:
> > 
> > > When the connection is ready we should set the connection
> > > to CONNECTED so userspace can use it.
> > > 
> > > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > > ---
> > >  net/bluetooth/l2cap_core.c |    3 +--
> > >  1 files changed, 1 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index 25f31f4..4af61fb 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -895,8 +895,7 @@ static void l2cap_chan_ready(struct sock *sk)
> > >  	chan->conf_state = 0;
> > >  	__clear_chan_timer(chan);
> > >  
> > > -	sk->sk_state = BT_CONNECTED;
> > > -	sk->sk_state_change(sk);
> > > +	l2cap_state_change(chan, BT_CONNECTED);
> > 
> > Why are you removing the sk->sk_state_change() ?
> 
> I was thinking that l2cap_state_change() would do this for me. May I ask
> why it doesn't call sk->sk_state_change()?

Because we don't call sk->sk_state_change() every time the state changes.

	Gustavo
