Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 May 2010 11:31:22 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Christian Birchinger <joker@netswarm.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Auto trust entry remove
Message-Id: <20100524113122.c084d160.ospite@studenti.unina.it>
In-Reply-To: <20100524085344.GA18433@netswarm.net>
References: <20100524083330.GA18128@netswarm.net>
	<20100524085344.GA18433@netswarm.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__24_May_2010_11_31_22_+0200_.B.rp0Va1D=dJDt."
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Mon__24_May_2010_11_31_22_+0200_.B.rp0Va1D=dJDt.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 24 May 2010 10:53:44 +0200
Christian Birchinger <joker@netswarm.net> wrote:

> Ok, i copied over the "spd" and "profiles" entries from
> the previous installation. Now it no longer removes the
> trust after a reconnect. It's just stuck in a reconnect
> loop (about 10 times) and then the controller gives up
> and powers down.

Christian, I can only say that it works for me with the kernel patches
from http://lists.ozlabs.org/pipermail/cbe-oss-dev/2010-May/007274.html
and an updated sixaxis-cable patch which I haven't published yet
because it was not final and I didn't want to leave temporary stuff,
which could be soon deprecated, archived on the Internet; that may
confuse people.

Let me know if you want me to send this updated sixaxis-cable to you
privately.

Have you tried removing everything from /var/lib/bluetooth ?

Regards,
   Antonio.

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Mon__24_May_2010_11_31_22_+0200_.B.rp0Va1D=dJDt.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkv6R2oACgkQ5xr2akVTsAFdrwCgjY+bYGyGv5d/WoYRQtBxfKtY
fooAmwaS4n7zwuNhjiDGtrqcpBZzwG3r
=W5E4
-----END PGP SIGNATURE-----

--Signature=_Mon__24_May_2010_11_31_22_+0200_.B.rp0Va1D=dJDt.--
