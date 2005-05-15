Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Tobias Lang <tobias-lang@gmx.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Hama BT1000 Headset Problems
Message-Id: <20050515192044.659654d3.tobias-lang@gmx.de>
In-Reply-To: <428761F9.7070805@xmission.com>
References: <20050515145042.70745815.tobias-lang@gmx.de>
	<428761F9.7070805@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__15_May_2005_19_20_44_+0200_6Zfsv/RI6b8Th+=9"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 15 May 2005 19:20:44 +0200

--Signature=_Sun__15_May_2005_19_20_44_+0200_6Zfsv/RI6b8Th+=9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 15 May 2005 08:51:37 -0600
Brad Midgley <bmidgley@xmission.com> wrote:

> Tobias
>=20
> > However, when I ignore the fact, that I haven't paired yet
>=20
> this sounds strange. when you click the connect button on the headset,=20
> what does btsco print out?
>=20
> brad

The print out is like this:
$~: btsco 00:0B:2E:06:15:74 -v
	btsco v0.4b
	Device is 1:0
	Voice setting: 0x0060
	RFCOMM channel 6 connected
	speaker volume: 15 mic volume: 15
	i/o needed: connecting sco...
	connected SCO channel
	Done setting sco fd
	recieved AT+VGS=3D15                                 #Changeing Volume
	Sending up speaker change 15
	recieved AT+CKPD=3D200                              #When pressing the HS =
button

I also get one beep out of the HS, when starting XMMS playback via ALSA. Ho=
wever the
playback doesn't really start. The timecode on the XMMS player stops after =
1sec.

Tobi

--Signature=_Sun__15_May_2005_19_20_44_+0200_6Zfsv/RI6b8Th+=9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCh4TwjxmcDuHlx5oRAjZAAJ4slgUtxNuEfX+zM7dUHWDEP9+lLQCffpxd
6LPf206myJj1/dj11C0HyLM=
=p2IV
-----END PGP SIGNATURE-----

--Signature=_Sun__15_May_2005_19_20_44_+0200_6Zfsv/RI6b8Th+=9--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
