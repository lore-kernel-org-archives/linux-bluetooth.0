Return-Path: <jt@bougret.hpl.hp.com>
Date: Wed, 4 Feb 2004 17:11:02 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: L2CAP non-blocking socket nasty race conditions
Message-ID: <20040205011102.GA23352@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040204015825.GA2217@bougret.hpl.hp.com> <1075879044.13285.151.camel@pegasus> <20040204175832.GB16590@bougret.hpl.hp.com> <1075924727.2783.47.camel@pegasus> <20040204214541.GA20129@bougret.hpl.hp.com> <1075942818.2783.70.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075942818.2783.70.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, Feb 05, 2004 at 02:00:18AM +0100, Marcel Holtmann wrote:
> Hi Jean,
> 
> > 	I could find an informal arrangement if you want my code, like
> > "for your eyes only", but it's also not totally trivial to setup.
> 
> not needed, because it is very clear where the problem is. But thanks
> for the offer.
> 
> > 	Yes, the accept() code is right, what's wrong is obviously the
> > "poll" code that should not indicate socket readyness before the
> > socket is really ready.
> > 	The more "correct" way would be to change the "poll()" code to
> > really test child socket readyness instead of just testing
> > sk_ack_backlog. But, the poll code would get very ugly quickly.
> > 	One of the simplest way would be to increase sk_ack_backlog
> > only when the socket change to the BT_CONNECTED state (as opposed to
> > immediately when we add it to the parent queue). I would need to
> > understand where and how exactly is sk_ack_backlog used.
> > 	Another solution if we can't use sk_ack_backlog is to use our
> > own counter to count the number of child ready, or a flag, or whatever
> > mechanism.
> 
> I don't see what sk_ack_backlog have to do with it. Can you explain this
> to me?

	See below.

> I haven't tested this yet, but I think the problem is the extra check in
> bt_sock_poll() for the accept_q:
> 
>         if (!skb_queue_empty(&sk->sk_receive_queue) || 
>                         !list_empty(&bt_sk(sk)->accept_q) ||
>                         (sk->sk_shutdown & RCV_SHUTDOWN))
>                 mask |= POLLIN | POLLRDNORM;

	Wrong. The client may only receive packet and never send
packets, and anyway those packets would go to the child socket, not
the parent socket (remember, we are before accept(), so we are polling
the parent/listening socket). You really need to test the *childs* of
this socket (i.e. those guys in accept_q).
	One way to do this is to have a counter counting the number of
child sockets in CONNECTED mode but not yet dequeued. One idea is to
reuse sk_ack_backlog to do this.

> Regards
> 
> Marcel

	Jean
