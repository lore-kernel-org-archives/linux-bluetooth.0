Return-Path: <cyrus@holtmann.org>
From: Keith Packard <keithp@keithp.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: 2.6.39-rc2 regression: X201s fails to resume b77dcf8460ae57d4eb9fd3633eb4f97b8fb20716
In-Reply-To: <20110409000857.GB25581@piper>
References: <yun1v1fj024.fsf@aiko.keithp.com> <alpine.LFD.2.00.1104070022280.3971@localhost6.localdomain6> <alpine.LFD.2.00.1104082340020.2724@localhost6.localdomain6> <yunaag0tjzb.fsf@aiko.keithp.com> <20110409000857.GB25581@piper>
Date: Fri, 08 Apr 2011 19:03:25 -0700
Message-ID: <yunipuouqoi.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Apr 2011 21:08:57 -0300, Vinicius Costa Gomes <vinicius.gomes@ope=
nbossa.org> wrote:

> I took a shot at it and just sent a patch (also attached for convenience)=
=20
> that should solve the problem.

Thanks much! I applied this to -rc2 and it appears to work fine in some
brief testing (a dozen suspend/resume cycles)

> Reported-by: Keith Packard <keithp@keithp.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Tested-by: Keith Packard <keithp@keithp.com>

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFNn75tQp8BWwlsTdMRAh0mAJ4jwgpR9ZxbRzX04/r1CTysGYhk+QCgsk5R
31hQrLnDHOMMx1WH/DAQf7E=
=gDEL
-----END PGP SIGNATURE-----
--=-=-=--
