Return-Path: <pavel@ucw.cz>
Date: Wed, 22 Mar 2017 10:39:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 05/11] serdev: add serdev_device_wait_until_sent
Message-ID: <20170322093939.GD26771@amd>
References: <20170321223216.11733-1-sre@kernel.org>
 <20170321223216.11733-6-sre@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
In-Reply-To: <20170321223216.11733-6-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> @@ -47,10 +48,13 @@ static void ttyport_write_wakeup(struct tty_port *por=
t)
>  	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> =20
>  	if (!test_and_clear_bit(TTY_DO_WRITE_WAKEUP, &port->tty->flags))
> -		return;
> +		goto out;
> =20
>  	if (test_bit(SERPORT_ACTIVE, &serport->flags))
>  		serdev_controller_write_wakeup(ctrl);
> +
> +out:

I'd do "if (test_and_clear_bit() && test_bit()) serdev_()"
here. Otherwise it looks fine.

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljSRlsACgkQMOfwapXb+vLJBQCfRozd4ckjK/dqrfKBryXwMeAx
aAcAnijtnM9S8FxpfTfaiHL6LWex2sZP
=n4jE
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
