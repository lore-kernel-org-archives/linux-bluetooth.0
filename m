Return-Path: <jt@bougret.hpl.hp.com>
Date: Wed, 4 Feb 2004 09:58:32 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: L2CAP non-blocking socket nasty race conditions
Message-ID: <20040204175832.GB16590@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040204015825.GA2217@bougret.hpl.hp.com> <1075879044.13285.151.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075879044.13285.151.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Feb 04, 2004 at 08:17:24AM +0100, Marcel Holtmann wrote:
> Hi Jean,
> 
> > 	I've just managed to reproduce and track a few bug that so far
> > were escaping me. There is a race condition in the accept() code for
> > non-blocking L2CAP sockets, and a similar one in sendmsg. Or maybe
> > it's just that my code is too fast ;-)
> 
> do you have a simple test code to reproduce it?

	No, the code is not that simple and I don't really want it
out. However, I think any trivial program using non-blocking sockets
will show that.
	Anyway, I think the bug report was detailed enough.

> > 	This is the accept race :
> > 	1) L2CAP socket in non blocking mode, because program waiting
> > on multiple outputs.
> > 	2) Wait on socket to be readable with poll/select.
> > 	3) When socket is ready, accept() it and do what we have to do.
> > 	4) When the race occur, accept() return an error (EAGAIN).
> > 	5) We don't touch the socket and go back to poll/select.
> > 	6) Poll/select returns immediately (socket is still readable).
> > 	7) We attempt the accept(), EAGAIN, goto (5)
> 
> Is this an endless loop? Or do accept() succeeds after some time?

	After around 500 iterations, it will succeed. I guess it
depend on your CPU speed.

> BTW why must a listen socket non-blocking? The listen() command itself
> doesn't block and I don't see any need for a non-blocking listen socket.

	Yes, listen() will not block. However I also want the accept()
to be non-blocking, because I don't want it to prevent it servincing
my other socekts. What's the point of writting all the rest of my code
non-blocking if accept() take 100ms to complete ? The only way to get
a non-blocking accept() is to have the listen socket in non-blocking
mode.

> > 	I didn't managed to fully identify the sendmsg race, but I
> > goes like this :
> > 	1) Open L2CAP socket in non blocking mode, because program
> > waiting on multiple outputs.
> > 	2) Connect to BT peer.
> > 	3) Wait on socket to be writeable with poll/select.
> > 	4) When socket is ready, sendmsg() and do what we have to do.
> > 	5) When the race occur, sendmsg() return an error (ENOTCONN).
> > 	...
> > 
> > 	I looked at way to fix the code, but it's not a quick fix and
> > there is multiple way to attack the problem. So, if one of you could
> > have a look at it...
> 
> Is this on a listen/accepted socket or is this a simple connection?

	The sendmsg() problem is on the other side, the client, so a
simply connected socket. But I've got a much harder time to reproduce
it.

> > 	Below you will find a self explanatory log of the kernel
> > showing the problem with accept. The first accept was successful (no
> > problem), the second one was racy.
> 
> >From the logfile function names I assume this is a 2.6 kernel. Do you
> see the same behaviour on 2.4?

	I saw the behaviour initially in 2.4.21, reproduced it on
2.4.23-rc2, investigated with 2.6.2-rc1, and verified that the code
was functionally similar in 2.4.23-rc2.

> Regards
> 
> Marcel

	Thanks...

	Jean
