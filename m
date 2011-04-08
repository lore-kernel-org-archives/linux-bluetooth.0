Return-Path: <cyrus@holtmann.org>
From: Keith Packard <keithp@keithp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: 2.6.39-rc2 regression: X201s fails to resume b77dcf8460ae57d4eb9fd3633eb4f97b8fb20716
In-Reply-To: <alpine.LFD.2.00.1104082340020.2724@localhost6.localdomain6>
References: <yun1v1fj024.fsf@aiko.keithp.com> <alpine.LFD.2.00.1104070022280.3971@localhost6.localdomain6> <alpine.LFD.2.00.1104082340020.2724@localhost6.localdomain6>
Date: Fri, 08 Apr 2011 16:13:28 -0700
Message-ID: <yunaag0tjzb.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Apr 2011 23:44:51 +0200 (CEST), Thomas Gleixner <tglx@linutronix.=
de> wrote:

> Can the bluetooth folks please have a look at that ASAP? The obvious
> fast fix for Linus tree is to revert the second hunk for now, but this
> needs to be fixed proper.

Who will submit this patch? I'd rather have your name on it so that
people come complain at you...

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFNn5aYQp8BWwlsTdMRAg7+AKCc7neuNQmv96AZ/sXpqfnf8UJajQCfatzG
GIQoeHiswtlphStgv72ShVw=
=JWE1
-----END PGP SIGNATURE-----
--=-=-=--
