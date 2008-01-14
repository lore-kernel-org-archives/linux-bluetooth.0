Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Jan 2008 16:28:29 +0100
From: Marco Zavagno <m.zavagno@eurotech.it>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080114152829.GD6064@localdomain>
MIME-Version: 1.0
Cc: Rodolfo Giometti <giometti@enneenne.com>
Subject: [Bluez-devel] bt-sco problem
Reply-To: Marco Zavagno <m.zavagno@eurotech.it>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0899409573=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0899409573==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I'm using a Mitsumi WML-C29AH bluetooth serial adapter.
Every bt function works well but when I try to send/recieve audio data
using bluetooth-alsa package I've got noisy audio during playback and
very noisy audio during recording operations.=20
I'm using a 2.6.22 kernel on arm pxa cpu with alsa-utils 1.0.15 and
bluez-libs and bluez-utils-alsa 3.22.
The adapter is binded to bluez stack using "hciattach /dev/ttyS1 csr 921600=
".

To setup the system I paired the bt headset, created an .asoundrc file insi=
de=20
my home directory and execute bluetoothd-service-audio.
Then I try to record/playback audio using aplay/arecord utils but noise iss=
ue=20
arise. At this point if I perform a hciconfig on the system the TX counter =
for
SCO packets always reports 0.

I'm also using same setup with a USB BT adapter and everything works well.
Any idea?=20

Thanx in advance

--=20
Only that in you which is me can hear what I'm saying.
		-- Baba Ram Dass
++
Marco Zavagno
Eurotech - The complete embedded PC solution
www.eurotech.it

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHi3+dm2ufZSfClXARAmqmAKDIVioFlsCI3l49MFXicl+6nAj1ggCgxUkQ
WCIw1scSIznEn7Co1W1JJQk=
=SPU0
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--


--===============0899409573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0899409573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0899409573==--
