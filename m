Return-Path: <jt@bougret.hpl.hp.com>
Date: Wed, 4 Feb 2004 13:45:41 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: L2CAP non-blocking socket nasty race conditions
Message-ID: <20040204214541.GA20129@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040204015825.GA2217@bougret.hpl.hp.com> <1075879044.13285.151.camel@pegasus> <20040204175832.GB16590@bougret.hpl.hp.com> <1075924727.2783.47.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075924727.2783.47.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Feb 04, 2004 at 08:58:47PM +0100, Marcel Holtmann wrote:
> Hi Jean,
> 
> > 	No, the code is not that simple and I don't really want it
> > out. However, I think any trivial program using non-blocking sockets
> > will show that.
> > 	Anyway, I think the bug report was detailed enough.
> 
> code is always better ;) I have written some stuff by myself now.

	I could find an informal arrangement if you want my code, like
"for your eyes only", but it's also not totally trivial to setup.

> > 	After around 500 iterations, it will succeed. I guess it
> > depend on your CPU speed.
> 
> It seems that we signal the socket readable after the L2CAP connect
> req/resp is handled. But the socket is first usable after we had a
> two-way L2CAP config req/resp for MTU negotiation. And this takes some
> time depending on if we have to do a role change, authenticate etc.

	Correct.

> > 	Yes, listen() will not block. However I also want the accept()
> > to be non-blocking, because I don't want it to prevent it servincing
> > my other socekts. What's the point of writting all the rest of my code
> > non-blocking if accept() take 100ms to complete ? The only way to get
> > a non-blocking accept() is to have the listen socket in non-blocking
> > mode.
> 
> Actually I don't know how to change this and I even don't know if this
> is a good idea, because the return code of accept() seems right.
> 
> Comments?

	Yes, the accept() code is right, what's wrong is obviously the
"poll" code that should not indicate socket readyness before the
socket is really ready.
	The more "correct" way would be to change the "poll()" code to
really test child socket readyness instead of just testing
sk_ack_backlog. But, the poll code would get very ugly quickly.
	One of the simplest way would be to increase sk_ack_backlog
only when the socket change to the BT_CONNECTED state (as opposed to
immediately when we add it to the parent queue). I would need to
understand where and how exactly is sk_ack_backlog used.
	Another solution if we can't use sk_ack_backlog is to use our
own counter to count the number of child ready, or a flag, or whatever
mechanism.

> > 	The sendmsg() problem is on the other side, the client, so a
> > simply connected socket. But I've got a much harder time to reproduce
> > it.
> 
> Haven't looked at it. We need a reliable way do reproduce it.

	I think the "poll()" change would fix that as well.

> Regards
> 
> Marcel

	Thanks...

	Jean
