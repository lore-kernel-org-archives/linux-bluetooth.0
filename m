Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jun 2011 17:48:22 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>,
	Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>,
	Simon Wood <simon@mungewell.org>
Subject: Re: [PATCHv3 3/3] Add sixaxis plugin: USB pairing and LEDs settings
Message-Id: <20110609174822.3e922722.ospite@studenti.unina.it>
In-Reply-To: <BANLkTimJ20rf8rJVPROLiJidq3dtVRGuig@mail.gmail.com>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
	<1307538557-9287-4-git-send-email-ospite@studenti.unina.it>
	<20110608175251.GC20343@piper>
	<20110609155731.bd2c5a8b.ospite@studenti.unina.it>
	<BANLkTimJ20rf8rJVPROLiJidq3dtVRGuig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__9_Jun_2011_17_48_22_+0200_Ls037v=Jla_DenRm"
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Thu__9_Jun_2011_17_48_22_+0200_Ls037v=Jla_DenRm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jun 2011 11:30:56 -0400
Anderson Lizardo <anderson.lizardo@openbossa.org> wrote:

> Hi,
>=20
> On Thu, Jun 9, 2011 at 9:57 AM, Antonio Ospite <ospite@studenti.unina.it>=
 wrote:
> > Would you mind if I keep these three stdlib ones in? I use this code
> > verbatim in another program which does not link against Glib.
>=20
> But you use e.g. "g_strcmp0()", GIOChannel etc. How is that?
>=20
> Also remember sed is your friend :)
>=20

I was referring to the "low level" functions:
  get_feature_report()
  set_feature_report()
  get_device_bdaddr()
  set_master_bdaddr()

sorry, I use them in a command line tool which opens the hidraw node
directly without udev.

But as you say, it is not a big deal to substitute them, if you like a
more uniform style in the bluez plugin then I'll comply.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__9_Jun_2011_17_48_22_+0200_Ls037v=Jla_DenRm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3w60cACgkQ5xr2akVTsAG6hwCfWy1bqaNEBBVpj7wiJQUqxDQx
4c8An05AvTFkh9DaIhcyt2kp4THbY2L2
=i0Wa
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Jun_2011_17_48_22_+0200_Ls037v=Jla_DenRm--
