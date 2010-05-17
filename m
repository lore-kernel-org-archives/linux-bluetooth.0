Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Mon, 17 May 2010 16:06:07 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>, marcel@holtmann.org
Subject: Re: [PATCH] Kernel crash when krfcomm is preempted by l2cap tasklet
Message-ID: <20100517190607.GA19907@vigoh>
References: <AANLkTilNBHEMhl7rFK7DemxPQu3LN2QGWSsL7b-e9Yl3@mail.gmail.com>
 <20100516083122.GA21819@vigoh>
 <AANLkTimyNqIdMoZ6J6InYRzD1JNl1Fsv-CdVpd84pjot@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimyNqIdMoZ6J6InYRzD1JNl1Fsv-CdVpd84pjot@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2010-05-17 12:45:=
50 +0300]:

> Hi Gustavo,
>=20
> Thanks for reviewing the patch. Please check new patches attached and
> comments below:
>=20
> On Sun, May 16, 2010 at 11:31 AM, Gustavo F. Padovan
> <gustavo@padovan.org> wrote:
> > Hi Andrei,
> >
> > * Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2010-05-14 18=
:39:40 +0300]:
> >
> >> Hi all,
> >>
> >> We have a bug with race condition between l2cap tasklet and krfcomm pr=
ocess.
> >>
> >> When sending following sequence:
> >>
> >> ...
> >> No. =A0 =A0 Time =A0 =A0 =A0 =A0Source =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Destination =A0 =A0 =A0 =A0 =A0 Protocol Info
> >> =A0 =A0 =A089 1.951202 =A0 =A0 =A0 =A0 =A0 =A0RFCOMM =A0 Rcvd DISC DLC=
I=3D20
> >> =A0 =A0 =A090 1.951324 =A0 =A0 =A0 =A0 =A0 =A0RFCOMM =A0 Sent UA DLCI=
=3D20
> >> =A0 =A0 =A091 1.959381 =A0 =A0 =A0 =A0 =A0 =A0HCI_EVT =A0 Number of Co=
mpleted Packets
> >> =A0 =A0 =A092 1.966461 =A0 =A0 =A0 =A0 =A0 =A0RFCOMM =A0 Rcvd DISC DLC=
I=3D0
> >> =A0 =A0 =A093 1.966492 =A0 =A0 =A0 =A0 =A0 =A0L2CAP =A0 =A0Rcvd Discon=
nect Request
> >> =A0 =A0 =A094 1.972595 =A0 =A0 =A0 =A0 =A0 =A0L2CAP =A0 =A0Sent Discon=
nect Response
> >>
> >> ...
> >>
> >> krfcommd kernel thread is preempted with l2cap tasklet which remove l2=
cap_conn
> >> (L2CAP connection handler structure). Then rfcomm thread tries to send=
 RFCOMM
> >> UA which is reply to RFCOMM DISC and when de-referencing l2cap_conn cr=
ash
> >> happens.
> >>
> >> ...
> >> [ =A0694.175933] Unable to handle kernel NULL pointer dereference at
> >> virtual address 00000000
> >> [ =A0694.184936] pgd =3D c0004000
> >> [ =A0694.187683] [00000000] *pgd=3D00000000
> >> [ =A0694.191711] Internal error: Oops: 5 [#1] PREEMPT
> >> [ =A0694.196350] last sysfs file:
> >> /sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
> >> [ =A0694.260375] CPU: 0 =A0 =A0Not tainted =A0(2.6.32.10 #1)
> >> [ =A0694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
> >> [ =A0694.270721] LR is at 0xd7017303
> >> ...
> >> [ =A0694.525085] Backtrace:
> >> [ =A0694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap])
> >> from [<c02f2cc8>] (sock_sendmsg+0xb8
> >> [ =A0694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>]
> >> (kernel_sendmsg+0x48/0x80)
> >> ...
> >>
> >> I have a patch which fixes the issue but not sure that there is no
> >> better way. Waiting for comments.
> >>
> >> Currently I am investigating possibility to:
> >> - implement l2cap_conn reference counting
> >
> > sock_owned_by_user() gives the same effect as a ref count. See comments=
 below.
> >
>=20
> Yes. For this cases this is enough. But proper refcounting is always
> better than this "effects" ;)
>=20
> >> - use socket backlog queue to process l2cap packets later when socket =
is not
> >> owned by the process.
> >
> > You actually don't need a backlog queue here. You can process the signal
> > packet, skipping the l2cap_chan_del() call;
> >
> ...
> >> + =A0 =A0 /* sk is locked in krfcomm process */
> >> + =A0 =A0 if (sock_owned_by_user(sk)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 BT_DBG("sk %p is owned by user", sk);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 bh_unlock_sock(sk);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> + =A0 =A0 }
> >
> > That's wrong. Use the sock_owned_by_user() only to avoid the
> > l2cap_chan_del() call, so you can process all the rest of the function
> > and send the Disconnect Response.
>=20
> I have changed the patch so that it only prevents l2cap_chan_del
> -		l2cap_chan_del(sk, ECONNREFUSED);
> +		/* delete l2cap channel if sk is not owned by user */
> +		if (!sock_owned_by_user(sk))
> +			l2cap_chan_del(sk, ECONNREFUSED);
>=20
> Then still l2cap_sock_kill(sk) removes sk but in the second patch sk is
> hold with sock_hold(sk) until rfcomm is still processing packet.

Hmm, I missed the l2cap_sock_kill(). So I guess you can invert the if
condition and unlock the socket and return if sock is owned by user,
right?

Marcel, do you agree with that change?

>=20
> > The same check should be added to l2cap_connect_rsp() and
> > l2cap_disconnect_rsp(), since they call l2cap_chan_del() under bh
> > context as well. ;)
>=20
> Added.
>=20
> Regards,
> Andrei Emeltchenko

> From 8531c8add8a378fc24b92f2c2311b01a7b1f63fc Mon Sep 17 00:00:00 2001
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> Date: Mon, 17 May 2010 12:10:46 +0300
> Subject: [PATCH 1/2] Bluetooth: Check sk is not owned before freeing l2ca=
p_conn
>=20
> Check that socket sk is not locked in user process before removing
> l2cap connection handler.
>=20
> krfcommd kernel thread may be preempted with l2cap tasklet which remove
> l2cap_conn structure. If krfcommd is in process of sending of RFCOMM reply
> (like "RFCOMM UA" reply to "RFCOMM DISC") then kernel crash happens.
>=20
> ...
> [  694.175933] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000000
> [  694.184936] pgd =3D c0004000
> [  694.187683] [00000000] *pgd=3D00000000
> [  694.191711] Internal error: Oops: 5 [#1] PREEMPT
> [  694.196350] last sysfs file: /sys/devices/platform/hci_h4p/firmware/hc=
i_h4p/loading
> [  694.260375] CPU: 0    Not tainted  (2.6.32.10 #1)
> [  694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
> [  694.270721] LR is at 0xd7017303
> ...
> [  694.525085] Backtrace:
> [  694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap]) from [=
<c02f2cc8>] (sock_sendmsg+0xb8/0xd8)
> [  694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>] (ke=
rnel_sendmsg+0x48/0x80)
> ...
>=20
> Modified version after comments of Gustavo F. Padovan <gustavo@padovan.or=
g>
>=20
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index bb00015..794f2b7 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2927,7 +2927,9 @@ static inline int l2cap_connect_rsp(struct l2cap_co=
nn *conn, struct l2cap_cmd_hd
>  		break;
> =20
>  	default:
> -		l2cap_chan_del(sk, ECONNREFUSED);
> +		/* delete l2cap channel if sk is not owned by user */
> +		if (!sock_owned_by_user(sk))
> +			l2cap_chan_del(sk, ECONNREFUSED);
>  		break;
>  	}
> =20
> @@ -3135,7 +3137,10 @@ static inline int l2cap_disconnect_req(struct l2ca=
p_conn *conn, struct l2cap_cmd
>  		del_timer(&l2cap_pi(sk)->ack_timer);
>  	}
> =20
> -	l2cap_chan_del(sk, ECONNRESET);
> +	/* delete l2cap channel if sk is not owned by user */
> +	if (!sock_owned_by_user(sk))
> +		l2cap_chan_del(sk, ECONNRESET);
> +
>  	bh_unlock_sock(sk);
> =20
>  	l2cap_sock_kill(sk);
> @@ -3167,7 +3172,10 @@ static inline int l2cap_disconnect_rsp(struct l2ca=
p_conn *conn, struct l2cap_cmd
>  		del_timer(&l2cap_pi(sk)->ack_timer);
>  	}
> =20
> -	l2cap_chan_del(sk, 0);
> +	/* delete l2cap channel if sk is not owned by user */
> +	if (!sock_owned_by_user(sk))
> +		l2cap_chan_del(sk, 0);
> +
>  	bh_unlock_sock(sk);
> =20
>  	l2cap_sock_kill(sk);
> --=20
> 1.7.0.4
>=20

> From 99ffb4e41ff46022cbc52f3c947425791de7fa39 Mon Sep 17 00:00:00 2001
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> Date: Mon, 17 May 2010 12:28:06 +0300
> Subject: [PATCH 2/2] Bluetooth: Prevent sk freeing in tasklet using refco=
unt
>=20
> Socket sk may be freed in tasklet while still be in use in krfcommd
> process. Use refcount to mark sk as used.
>=20
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 794f2b7..bf762d6 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1724,6 +1724,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, s=
truct socket *sock, struct ms
>  	if (msg->msg_flags & MSG_OOB)
>  		return -EOPNOTSUPP;
> =20
> +	sock_hold(sk);
>  	lock_sock(sk);
> =20
>  	if (sk->sk_state !=3D BT_CONNECTED) {
> @@ -1808,6 +1809,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, s=
truct socket *sock, struct ms
> =20
>  done:
>  	release_sock(sk);
> +	sock_put(sk);
>  	return err;
>  }
> =20
> --=20
> 1.7.0.4
>=20


--=20
Gustavo F. Padovan
http://padovan.org
