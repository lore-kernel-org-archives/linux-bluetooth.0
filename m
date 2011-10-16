Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Oct 2011 08:27:00 +1100
From: NeilBrown <neilb@suse.de>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Help understanding Agent 'capabilities'.
Message-ID: <20111017082700.2ef1b1d4@notabene.brown>
In-Reply-To: <20111013112830.GA20868@fusion.localdomain>
References: <20111013165526.0dbbe0fc@notabene.brown>
	<CABBYNZJs4zXqhPkSV6HUbLzFk7_-cuf-+kVgmw+A0hcMRCXLxw@mail.gmail.com>
	<20111013221432.625e1bfd@notabene.brown>
	<20111013112830.GA20868@fusion.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/ILvvvdXVRN7iC+wliAw/s6o"; protocol="application/pgp-signature"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Sig_/ILvvvdXVRN7iC+wliAw/s6o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Oct 2011 14:28:30 +0300 Johan Hedberg <johan.hedberg@gmail.com>
wrote:

> Hi Neil,
>=20
> On Thu, Oct 13, 2011, NeilBrown wrote:
> > What is the easiest way to find out what bluetooth version the controll=
er is
> > using?  I tried looking around and didn't find anything obvious.
>=20
> E.g. the output of "hciconfig hci0 version" should show you this.
>=20
> Johan

and so it does.=20
One of the devices I was using is indeed 2.0. The other is 3.0

Thanks a lot.

NeilBrown


--Sig_/ILvvvdXVRN7iC+wliAw/s6o
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTptMKjnsnt1WYoG5AQI5EA/7BrsQFPrIfMy6aaf/ZyL3mQbhnhKEWd2l
Vu5Uc9zlZkRQjlD1ob7IcuGqcpCwpZxeNSsna1z4+KF2mDnc0PvC5t6sLbeYJWSW
uiZvLd8eJ+Ex+gYf8g3WahCG32R556WZ48sXr+J5TjJPWy3f+Bq8h1fQGqMqoWdI
ENVKxZXJW8BN1OkfKd8WlYmyDD6KNlqi5Ce3aLuXPjEa/QDhwHh0VH3MWygq+TGD
u/nNqKuRQWEFta4QubFDADUmTfJbu+HEYBvN+sVtqs52TS/gEc+MPIUwlsEZMVUv
WCK88nja9B9T54DQ9vwjrlgQKW0k8o3NtntXHlZBU+xZtabuGcYNsDwegO1qcHAC
REn/0FbUd5rdha8yXIEkincbvorBnbvYwyrs8ycOZ9MfLJPOs+wMht28vdsid6zA
I/etL31jyZZI++8jQIhFKxdVf4VTxhMu1wy1MjOL/97jEsbrQVaweUdPaxwbckrZ
5BthJRAwvtlwfwEajNwtVUON2fop80Wy4/p8rcd3UaY8WpKh0S+hoh+86sO4n1h6
qqwsamDe5Zhae7Bhhvrrda1lGJD/qx/M8CGjQ+7IjSkrsHUv9msyKRocVqpHVYdJ
1VThR9fwqy2zVhF2A9HFpeH7Opht9SetzprF/B0reMV+RhJyw1R5CqqhEO+mZkZJ
l3iAEvero3s=
=5P+x
-----END PGP SIGNATURE-----

--Sig_/ILvvvdXVRN7iC+wliAw/s6o--
