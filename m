Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Tue, 21 Sep 2004 14:26:45 -0700
Message-ID: <001c01c4a021$b21545c0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <001801c4a01b$12116eb0$1a01010a@baked>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> > The L2CAP solution looks very sane to me, but I am not sure=20
> about the
> > RFCOMM part and we may will have a locking problem. This=20
> really needs
> > intensive testing.
>=20
> Excellent. Thank you very much.
>=20
> I'll let you know how it works for me.

Looks like the rfcomm part isn't quite there. The accept queue doesn't =
fill
up, but the use count still increases. And /proc/bluetooth/rfcomm still
lists all of the closed sockets.

I added rfcomm_sock_close() and rfcomm_sock_kill() right after your =
addition
to rfcomm_sk_state_change() and it seems to work. The affects of
rfcomm_sock_alloc() (called by ...connect_ind()) needed to be dealt =
with. I
changed it as follows:

--- mh_sock.c	2004-09-21 14:21:36.000000000 -0700
+++ sock.c	2004-09-21 14:21:47.000000000 -0700
@@ -104,8 +104,11 @@
 			rfcomm_session_getaddr(d->session,
&bluez_pi(sk)->src, NULL);
 		sk->state_change(sk);
 	} else {
-		if (d->state =3D=3D BT_CLOSED)
+		if (d->state =3D=3D BT_CLOSED) {
 			bluez_accept_unlink(sk);
+			rfcomm_sock_close(sk);
+			rfcomm_sock_kill(sk);
+		}
 		parent->data_ready(parent, 0);
 	}
=20
I am not sure about the possible negative side effects of this. What do =
you
think?

-Daryl.
