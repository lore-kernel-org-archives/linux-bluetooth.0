Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Wed, 22 Sep 2004 12:05:17 -0700
Message-ID: <003301c4a0d7$1982c5b0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095876765.6223.85.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> try to test your normal stuff to make sure that it doesn't break
> anything else.

So far so good. I'm setting up some automated testers to pound on it for =
a
while.

> > Does this change make the "if (sk->state =3D=3D BT_CLOSED)" =
statement in
> > bluez_accept_dequeue() redundant?
>=20
> I think so. Haven't thought about it so far.
>=20
> > This is important because if somehow a socket is in=20
> BT_CLOSED state and is
> > in the accept queue during shutdown, then=20
> rfcomm_cleanup_listen() can't
> > clean it up (because bluez_accept_dequeue() won't return=20
> it). I think your
> > changes make it impossible for there to ever be an rfcomm=20
> socket (or l2cap
> > socket) in the BT_CLOSED state in the accept queue. If=20
> that's true, then
> > this isn't an issue. Thoughts?
>=20
> Sorry, but I can't follow your point here. Please explain it again.

Bluez_accept_dequeue() won't return a socket if it is in the closed =
state.
So rfcomm_cleanup_listen() will never call close and kill on the socket
because ...accept_dequeue() never returns it (it just unlinks it). And =
then
we would have the use count problem. But if there is no possibility of a
socket being in the closed state on the accept queue (for rfcomm at =
least),
then this isn't an issue.

I think this is fixed - so if I'm still talking nonsense, just ignore =
it. ;)

> > Do you think we've covered the case where there are=20
> incomming connections
> > while things are at various stages of being shut down? I=20
> think we're ok, but
> > I wanted to bring it up.
>=20
> Actually I don't know. In general we should be protected against that
> with our locking.

As far as I could see the locking protects against it. But I did not =
spend
enough time on it to fully understand how it works. If there is a =
problem,
my testing should eventually uncover it.

-Daryl.
