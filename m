Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Tue, 21 Sep 2004 15:44:50 -0700
Message-ID: <001d01c4a02c$9aaeab00$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095805605.5762.24.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> maybe this one helps:
>=20
> --- 1.29/net/bluetooth/rfcomm/sock.c    2004-06-04 02:41:47 +02:00
> +++ edited/net/bluetooth/rfcomm/sock.c  2004-09-22 00:12:34 +02:00
> @@ -104,8 +104,13 @@
>                 if (d->state =3D=3D BT_CONNECTED)
>                         rfcomm_session_getaddr(d->session,=20
> &bt_sk(sk)->src, NULL);
>                 sk->sk_state_change(sk);
> -       } else
> +       } else {
> +               if (d->state =3D=3D BT_CLOSED) {
> +                       bt_accept_unlink(sk);
> +                       sk->sk_zapped =3D 1;
> +               }
>                 parent->sk_data_ready(parent, 0);
> +       }
> =20
>         bh_unlock_sock(sk);
>  }

No luck.

Same behaviour as without the close and kill calls.

I noticed in l2cap.c that after l2cap_chan_del() is called (which now =
does
the accept_unlink()), l2cap_sock_kill() is often called which decrements =
its
use count which was incremented in l2cap_sock_alloc() (much like in =
rfcomm).
But in rfcomm, there don't appear to be any calls to ...sock_kill() for
similar circumstances.

-Daryl.
