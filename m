Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm use count
Date: Tue, 14 Sep 2004 14:58:57 -0700
Message-ID: <000f01c49aa6$0958f510$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095153493.5695.129.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

That didn't work, but I think I found the problem. Not sure what the =
correct
solution is though.

Rfcomm_sock_cleanup_listen() calls bluez_accept_dequeue() in a loop =
until
bluez_accept_dequeue() has no more sockets to return. For each socket =
that
bluez_accept_dequeue() returns, rfcomm_sock_cleanup_listen() closes and
kills it. Killing it unlinks it from rfcomm_sk_list.

But if the socket is already closed (sk->state =3D=3D BT_CLOSED), then
bluez_accept_dequeue() does not return the socket (it just continues to =
the
next one in the queue). Bluez_accept_dequeue() does unlink it from the
accept queue, but not from rfcomm_sk_list.

I suppose the first question is: Is the bug in cleanup/dequeue, or is =
the
bug elsewhere (i.e.: things shouldn't ever be in quite that state when
cleanup_listen is called)?

Also, should rfcomm_sock_destruct() be called to decrement the use =
count?

-Daryl.

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
> Sent: September 14, 2004 2:18 AM
> To: Daryl Van Vorst
> Cc: 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] Rfcomm use count
>=20
>=20
> Hi Daryl,
>=20
> > I just noticed that bluez_accept_unlink() was called with a=20
> socked that was
> > in state BT_CLOSED, so it can't be the second if(). It=20
> would have been
> > called from the first if().
> >=20
> > Clearly, I'm on glue.
> >=20
> > Still, does the order of bluez_accept_unlink() and=20
> sock_release() matter?
>=20
> I haven't done a full audit yet, but try to switch the order and see
> what happens. From a first look at it it makes sense to only=20
> release the
> socket when all the work is done, because otherwise=20
> lock_sock() makes no
> sense.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
