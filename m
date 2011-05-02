Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 May 2011 22:56:37 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove btio.c compilation warning
Message-Id: <20110502225637.bacff427.ospite@studenti.unina.it>
In-Reply-To: <4dbf1776.0bd9650a.1733.7e99@mx.google.com>
References: <y>
	<4dbf1776.0bd9650a.1733.7e99@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__2_May_2011_22_56_38_+0200_n2OSh4=+ipOd9Eie"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Mon__2_May_2011_22_56_38_+0200_n2OSh4=+ipOd9Eie
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon,  2 May 2011 16:43:26 -0400
anderson.briglia@openbossa.org wrote:

> From: Anderson Briglia <anderson.briglia@openbossa.org>
>=20
> This patch fixes a compilation warning regarding btio/btio.c
> compilation.

Just a general observation, when fixing compilation warnings/errors it
is useful to put the actual message from the compiler in the commit log,
this helps reviewers validating the patch as they see exactly which
issue the fix addresses, but not only: there are chances the commit
message will be indexed by search engines and we'll be helping others
with similar issues searching for a solution on the web.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Mon__2_May_2011_22_56_38_+0200_n2OSh4=+ipOd9Eie
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2/GoYACgkQ5xr2akVTsAFmlgCgi76GR7jLHRlGigMdDGri1kHi
vKgAnjUeub8pwerr4CUUgJLr6YGPtqWI
=KfFI
-----END PGP SIGNATURE-----

--Signature=_Mon__2_May_2011_22_56_38_+0200_n2OSh4=+ipOd9Eie--
