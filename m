Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Mon, 20 Sep 2004 11:52:43 -0700
Message-ID: <002a01c49f43$03879960$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095705177.5731.36.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> > Making bluez_accept_dequeue() return sockets regardless of=20
> state is a
> > potential solution. Accept() for rfcomm and l2cap would=20
> then need to be
> > modified to kill already closed sockets. The existing loop=20
> in the accept()'s
> > would need to be modified or a new one added to handle
> > bluez_accept_dequeue() not always returning an open socket.
>=20
> I don't like that idea and the problem is not in=20
> ...cleanup_listen() and
> so I am not sure if it will really help us.

Fair enough. Though I'm talking about changing bluez_accept_dequeue(), =
not
necessarily cleanup_listen().

> > I may not have been clear about my thoughts on=20
> rfcomm_sock_cleanup_listen().
> > If bluez_accept_dequeue() did return sockets regardless of=20
> state, then
> > rfcomm_sock_cleanup_listen() should work (unless calling=20
> close on an already
> > closed socket causes trouble). When it calls=20
> rfcomm_sock_kill(), sock_put()
> > gets called which calls destruct() which should decrement=20
> the use count.
>=20
> The ...cleanup_listen() kicks in when you stop the listening=20
> server, but
> that is far too late. The problematic part already happened.=20
> We close a
> connection that wasn't accepted. We must fix it there and not=20
> afterwards
> like somekind of garbage collection. This is the kernel and not some
> weird Jave/C++ code.

With my suggestion above the condition would be handled by either =
accept()
or cleanup_listen(), whichever is called first. Though I guess you could
still consider that to be garbage collection.

> > What if bluez_accept_dequeue() called sk->shutdown() on=20
> sockets which are
> > already closed in the accept queue?
>=20
> I am not sure about the side effects, but this can be a=20
> solution. What I
> think is that setting the socket to BT_CLOSED is wrong. Maybe using
> BT_DISCONN is better, but this involves changing the state machine.

Calling sk->shutdown() is bluez_accept_dequeue() would be virtually the =
same
timing (i.e. garbage collecting likeness) as the suggestion above =
(returning
the closed socket in ...accept_dequeue). It would happen only when =
accept()
or cleanup_listen() are called.

> > I'll try out l2cap later for you. We should see the same thing.
>=20
> I am not sure anymore. Maybe this is only RFCOMM related.

I sent another e-mail a moment ago...  It doesn't happen with l2cap (or =
at
least I wasn't able to get it to happen).

-Daryl.
