Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Oct 2008 02:08:34 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: linux-bluetooth@vger.kernel.org
Subject: Help getting bluetooth disabled
Message-ID: <20081008050833.GA15051@ime.usp.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear developers,

I got this past july a notebook that has what seems to be a strange way
of dealing with wireless devices: there is a button (which I suspect is
called rfkill) that, when pressed, enables *both* bluetooth and wifi,
with the respective leds being lit.

I don't have any bluetooth device. Saving energy here is paramount as
the battery life is quite short.

According to the manual, under Windows Vista (which is what came with
the box, but which I never used), this button is supposed to cycle
between 4 states:

* both disabled;
* bluetooth enabled & wifi enabled;
* bluetooth disabled & wifi enabled;
* bluetooth enabled & wifi disabled.

Unfortunately, under Linux (tested with Ubuntu's 8.10 pre-releases,
which includes a kernel based on 2.6.27-rc*, if I understand it
correctly), it is all or nothing: both disabled or both enabled.

If I launch powertop, it recommends to disable bluetooth with
"hciconfig hci down; rmmod hci_usb", but the led of bluetooth is still
lit and I fear that the device is still drawing power from the battery.

Is there any way to get it to disable completely the device?

Just as extra information, this is an Itautec Note N8320 notebook, with
a Core 2 Duo T7250 CPU, ICH8 chipset and Intel's 3945abg wifi and a
Realtek GigE driven by r8169 module (which I still have not had the
opportunity to use).

If any further information is desired, please let me know. I can post
the dmesg logs, lspci output, lsusb, as I am really willing to get this
situation settled (and possibly working as on Windows as it was reported
by the support people from the manufacturer).

Again, if any further information is needed, please let me know.


Thanks, Rog=C3=A9rio Brito.

P.S.: Please, I would kindly ask to be included in Cc'ies, as I am not
subscribed to the list.
--=20
Rog=C3=A9rio Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFI7EBRCFqbMnwsrrgRAkvaAKDESTtkcFg4Ba7xWMhdZQrWrW2geACfW9qX
NspkfcUy0L54LHzKoBw3JWg=
=/bHo
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
