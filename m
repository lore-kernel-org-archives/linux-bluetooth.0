Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Mon, 20 Sep 2004 10:58:55 -0700
Message-ID: <002601c49f3b$7f80c990$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095411534.3280.17.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> At the moment I must admit that I have no idea how to fix=20
> this in a sane
> way. It seems that this bug is in there from the beginning and a wrong
> fix can cause unexpected side effects.
>=20
> I don't think that the problem is in rfcomm_sock_cleanup_listen(),
> because the wrong use count is already present after step 3.=20
> So when we
> close a connected DLC that is not accepted yet, we still have=20
> it on the
> accept queue then we have a problem. Maybe there is a bug in our state
> machine and this is not socket related.

Incoming connections must be added to the accept queue (unless I'm =
really
missing something). So the issue is just what to do when the remote side
closes them before accept() gets to them.

Making bluez_accept_dequeue() return sockets regardless of state is a
potential solution. Accept() for rfcomm and l2cap would then need to be
modified to kill already closed sockets. The existing loop in the =
accept()'s
would need to be modified or a new one added to handle
bluez_accept_dequeue() not always returning an open socket.

I may not have been clear about my thoughts on =
rfcomm_sock_cleanup_listen().
If bluez_accept_dequeue() did return sockets regardless of state, then
rfcomm_sock_cleanup_listen() should work (unless calling close on an =
already
closed socket causes trouble). When it calls rfcomm_sock_kill(), =
sock_put()
gets called which calls destruct() which should decrement the use count.

What if bluez_accept_dequeue() called sk->shutdown() on sockets which =
are
already closed in the accept queue?

I'll try out l2cap later for you. We should see the same thing.

-Daryl.
