Return-Path: <pavel@ucw.cz>
Date: Mon, 17 Oct 2016 23:32:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ifaenson@broadcom.com, marcel@holtmann.org,
	kernel list <linux-kernel@vger.kernel.org>, gustavo@padovan.org,
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	sre@kernel.org
Subject: hci_ldisc: suspicious/buggy code
Message-ID: <20161017213205.GA25141@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
List-ID: <linux-bluetooth.vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

hci_uart_set_flow_control() contains some rather suspicious
code. AFAICT:

set =3D 0.

Then we do set &=3D (magic constant). But as set is 0, it stays zero. It
just does not make sense. [Nor does it make sense to do |=3D on known
value of zero just after else. But that's probably just some artifact
of editing.]

(And if you edit the code anyway, temporary variable to store
TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 | TIOCM_OUT2 | TIOCM_LOOP would
make sense.)

Thanks,
								Pavel


/* Flow control or un-flow control the device */
void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
{
	...
	unsigned int set =3D 0;
	unsigned int clear =3D 0;

	if (enable) {
	   	...
		set &=3D ~(TIOCM_OUT2 | TIOCM_RTS);
		clear =3D ~set;
		set &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
		       TIOCM_OUT2 | TIOCM_LOOP;
		clear &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
			 TIOCM_OUT2 | TIOCM_LOOP;
		status =3D tty->driver->ops->tiocmset(tty, set, clear);
		BT_DBG("Clearing RTS: %s", status ? "failed" : "success");
	} else {
	       ...=09
		set |=3D (TIOCM_OUT2 | TIOCM_RTS);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgFQ1UACgkQMOfwapXb+vLV2wCguvPsslveA+aw+U6/G/Btlyik
DyUAnjB4f7X8H2SaVDZptoMneC2km0Qf
=XTgV
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
