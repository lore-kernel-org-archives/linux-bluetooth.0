Return-Path: <jt@bougret.hpl.hp.com>
Date: Wed, 4 Feb 2004 17:40:30 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: L2CAP non-blocking socket nasty race conditions
Message-ID: <20040205014030.GA23802@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040204015825.GA2217@bougret.hpl.hp.com> <1075879044.13285.151.camel@pegasus> <20040204175832.GB16590@bougret.hpl.hp.com> <1075924727.2783.47.camel@pegasus> <20040204214541.GA20129@bougret.hpl.hp.com> <1075942818.2783.70.camel@pegasus> <20040205011102.GA23352@bougret.hpl.hp.com> <1075944624.2783.87.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075944624.2783.87.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, Feb 05, 2004 at 02:30:24AM +0100, Marcel Holtmann wrote:
> Hi Jean,
> 
> > > I haven't tested this yet, but I think the problem is the extra check in
> > > bt_sock_poll() for the accept_q:
> > > 
> > >         if (!skb_queue_empty(&sk->sk_receive_queue) || 
> > >                         !list_empty(&bt_sk(sk)->accept_q) ||
> > >                         (sk->sk_shutdown & RCV_SHUTDOWN))
> > >                 mask |= POLLIN | POLLRDNORM;
> > 
> > 	Wrong. The client may only receive packet and never send
> > packets, and anyway those packets would go to the child socket, not
> > the parent socket (remember, we are before accept(), so we are polling
> > the parent/listening socket). You really need to test the *childs* of
> > this socket (i.e. those guys in accept_q).
> > 	One way to do this is to have a counter counting the number of
> > child sockets in CONNECTED mode but not yet dequeued. One idea is to
> > reuse sk_ack_backlog to do this.
> 
> now I got it. I was thinking from the wrong direction ;)
> 
> Touching sk_ack_backlog or introducing another counter is not a good
> idea, I think. What about moving the bt_accept_enqueue() call in the
> L2CAP code to the right "time"?

	The problem with that is that you are going to loose track of
those sockets. As accept has not been done, they are not referenced
from user space. The only place knowing about them is parent->accept_q.
	If for some reason the config req/rsp fail, or if the user
space doesn't accept, those sockets are going to leak. Look at the
code in "dequeue" that reap CLOSED sockets, and also the code that
close all childs when a socket is destroyed.
	I told you it was not totally trivial.

> BTW do RFCOMM have the same problem?

	Never tried.

> Regards
> 
> Marcel

	Jean
