Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm use count
Date: Mon, 13 Sep 2004 12:06:13 -0700
Message-ID: <000e01c499c4$bd4482c0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000F_01C4998A.10E5AAC0"
In-Reply-To: 
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C4998A.10E5AAC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

I have attached a log for you to look at if you have some time. If not,
maybe just answer my question below. :)

Here's what I see:

One stray socket. I added the socket pointer to the proc output.
Proc/bluetooth/rfcomm:
sk  2C:02:5F:16:05:00 3A:A4:58:16:05:00 9 1 c3b69340

I have a setup where I kill my app after a random time interval while
several devices are connecting, disconnecting, and transfering data, =
etc.

Here's a brief version of the log:

1. Program gets kill signal (time 15:09:30)
2. HCI devices get shut down
3. Some data remaining for transmission is sent.
4. One listen socket is closed (I think this is the one which is not =
being
used)
5. Some sockets/dlcs get closed
6. An incomming connection is received (rfcomm_connect_ind is called, =
and a
socket is created which matches the one in proc)
7. Some more sockets/dlcs get closed
8. The listen (probably the one which is being used) gets closed

I don't see any lines from rfcomm_sock_accept after the =
rfcomm_connect_ind
line. And rfcomm_sock_release is never called for the new connection.

My knowledge here is limited, and I may be mis-interpreting the log. But =
it
appears that a socket is allocated for the new connection as long as =
there
is room in the wait queue. And if that connection is never accepted, is =
it
the job of rfcomm_sock_cleanup_listen() to deal with it? That is, it is =
not
the kernel's duty (outside of the rfcomm module) to deal with the =
allocated
socket?

So, I think, it appears that rfcomm_sock_cleanup_listen isn't working =
right.

Not sure if rfcomm_sock_accept is still looping or not while this is =
going
on.

More digging needed...

Thanks,

-Daryl.

> -----Original Message-----
> From: Daryl Van Vorst [mailto:daryl@wideray.com]=20
> Sent: September 13, 2004 9:37 AM
> To: 'Marcel Holtmann'
> Subject: RE: [Bluez-devel] Rfcomm use count
>=20
>=20
> Hi Marcel,
>=20
> > I haven't had time to look at your problem in the last two weeks and
> > dealing with ARM related stuff still not fits into my left=20
> > free time for
> > the next weeks. Is this behaviour reproduceable on x86=20
> machines and do
> > you have a small text program to trigger this effect? And=20
> > what I really
> > care about, is this problem also available with a 2.6 kernel?
>=20
> Thanks for the response.
>=20
> I have not yet tried to reproduce it on an x86. And=20
> unfortunately I don't have a good way to trigger the effect.=20
> I have spent quite a lot of time trying to come up with a=20
> simple way (or any way) to reliably reproduce the problem.=20
> Depending on how the next while plays out, I may try to=20
> reproduce it on an x86.
>=20
> I would like to be working with a 2.6 kernel, but time=20
> constraints have prevented moving to it (would require=20
> porting drivers). Maybe on an x86 if time permits.
>=20
> I'm currently sifting through RFCOMM debug output. When I get=20
> something interesting I'll send it along. I should have=20
> something shortly.
>=20
> -Daryl.
>=20
>=20

------=_NextPart_000_000F_01C4998A.10E5AAC0
Content-Type: application/x-gzip;
	name="messages.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="messages.gz"

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
Xl4Ao1US7+gy+kGn/znOD/8HBhBwsX3VAAA=

------=_NextPart_000_000F_01C4998A.10E5AAC0--
