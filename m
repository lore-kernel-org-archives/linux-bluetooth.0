Return-Path: <pavel@ucw.cz>
Date: Mon, 17 Oct 2016 23:52:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ifaenson@broadcom.com, marcel@holtmann.org,
	kernel list <linux-kernel@vger.kernel.org>, gustavo@padovan.org,
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	sre@kernel.org
Subject: Re: hci_ldisc: suspicious/buggy code
Message-ID: <20161017215241.GA2465@amd>
References: <20161017213205.GA25141@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
In-Reply-To: <20161017213205.GA25141@amd>
List-ID: <linux-bluetooth.vger.kernel.org>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-10-17 23:32:06, Pavel Machek wrote:
> Hi!
>=20
> hci_uart_set_flow_control() contains some rather suspicious
> code. AFAICT:
>=20
> set =3D 0.
>=20
> Then we do set &=3D (magic constant). But as set is 0, it stays zero. It
> just does not make sense. [Nor does it make sense to do |=3D on known
> value of zero just after else. But that's probably just some artifact
> of editing.]
>=20
> (And if you edit the code anyway, temporary variable to store
> TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 | TIOCM_OUT2 | TIOCM_LOOP would
> make sense.)

I think this might be the fix, but it breaks h4p protocol on n900...

  	     	      	       	      	     	 	  Pavel

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 0506806..b549c47 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -271,8 +271,8 @@ void hci_uart_set_rts(struct hci_uart *hu, bool enable)
 		status =3D tty->driver->ops->tiocmget(tty);
 		BT_DBG("Current tiocm 0x%x", status);
=20
-		set &=3D ~(TIOCM_OUT2 | TIOCM_RTS);
-		clear =3D ~set;
+		clear |=3D (TIOCM_OUT2 | TIOCM_RTS);
+		set =3D ~clear;
 		set &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
 		       TIOCM_OUT2 | TIOCM_LOOP;
 		clear &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |

> /* Flow control or un-flow control the device */
> void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> {
> 	...
> 	unsigned int set =3D 0;
> 	unsigned int clear =3D 0;
>=20
> 	if (enable) {
> 	   	...
> 		set &=3D ~(TIOCM_OUT2 | TIOCM_RTS);
> 		clear =3D ~set;
> 		set &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> 		       TIOCM_OUT2 | TIOCM_LOOP;
> 		clear &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> 			 TIOCM_OUT2 | TIOCM_LOOP;
> 		status =3D tty->driver->ops->tiocmset(tty, set, clear);
> 		BT_DBG("Clearing RTS: %s", status ? "failed" : "success");
> 	} else {
> 	       ...=09
> 		set |=3D (TIOCM_OUT2 | TIOCM_RTS);
>=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgFSCkACgkQMOfwapXb+vJONQCglCJk62vVJ++osXWi0zqkOKR7
g5IAniHUd9qi72qNIXACgFFELxC1P+aN
=TXJS
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
