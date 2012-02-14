Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Do not dereference zero sk
Date: Tue, 14 Feb 2012 14:27:21 +0100
CC: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1329225177-31940-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1329225150.28848.74.camel@aeonflux>
In-Reply-To: <1329225150.28848.74.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201202141427.22053.szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > @@ -795,7 +795,7 @@ static void l2cap_sock_kill(struct sock *sk)
> >  static int l2cap_sock_shutdown(struct socket *sock, int how)
> >  {
> >  	struct sock *sk = sock->sk;
> > -	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> > +	struct l2cap_chan *chan;
> >  	int err = 0;
> >  
> >  	BT_DBG("sock %p, sk %p", sock, sk);
> > @@ -803,6 +803,8 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
> >  	if (!sk)
> >  		return 0;
> >  
> > +	chan = l2cap_pi(sk)->chan;
> > +
> 
> funny that this never caused any problems so far.

It didn't because chan is a pointer so only offset is added to sk pointer and
stored in chan. And kernel is compiled with option that prevents gcc to remove
NULL checks even if pointer was already dereferenced.

-- 
BR
Szymon Janc
