Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Mon, 20 Sep 2004 15:38:01 -0700
Message-ID: <003101c49f62$7e2f7fb0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095715737.5731.70.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> > I just tried an experiment where I listen for a while before calling
> > accept(). I can raise the use cound by connecting,=20
> disconnecting, etc (as
> > before). As soon as accept() is called, the excess use=20
> count goes away.
> >=20
> > Before accept() is called, the server will start refusing=20
> connections after
> > you fill up the accept queue. The queue is emptied with a=20
> single call to
> > accept().
>=20
> so this means when we disconnect we must ensure that we also=20
> remove this
> connection from the accept queue if it is pending there.
>=20
> What I know think is that calling the bt_accept_unlink() function only
> from bt_accept_dequeue() is wrong. If bt_sk(sk)->parent is set and we
> ran into a disconnect then we must unlink it by ourself. Does=20
> this make
> sense?

This makes sense to me, but I'm not convinced that it's enough of a =
problem
to warrant major changes. And I'm probably not the best person to ask. =
;)

Do we know how the tcp stack handles this kind of thing? (I had a quick =
look
at a text on sockets and it didn't specifically cover the case of
connections getting closed which are in the queue. But it was clear that =
the
precise behaviour of the queue varies for tcp-ip from unix to unix.)

Most servers (I think) would sit with accept() blocking and then spend a
very brief time handing off the new connection before blocking on =
accept()
again. So this wouldn't cause much trouble.

I suppose this could affect a very simple server which is =
single-threaded
(and so could spend significant time between accept() calls). Or a very =
busy
server. I'm not sure that this is really a major issue for bluetooth =
(the
bandwith and number of real connections is quite limited compared to
tcp-ip).

-Daryl.
