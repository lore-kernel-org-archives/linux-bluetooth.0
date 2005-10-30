Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1180763.kL0HVBaoVS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200510301643.31873.rene.mayrhofer@gibraltar.at>
Subject: [Bluez-devel] snd-bt-sco module prevents ACPI S3
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 30 Oct 2005 16:43:29 +0000

--nextPart1180763.kL0HVBaoVS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

[Please CC me in replies, I am not subscribed to this list.]

I am a happy user of the alsa bluetooth driver, i.e. snd-bt-sco and btsco.=
=20
There are just two things that seem to be broken in snd-bt-sco (CVS version=
=20
as of a month ago):

1. It's name in the lsmod list is different from the module name, i.e.=20
modprobe and rmmod must be used with different names.
2. It breaks ACPI S3 (suspend to RAM), making it pretty much unusable on=20
laptops where S3 is used (like mine). Unloading snd-bt-sco does not work (I=
=20
do that with a few other modules); as soon as it has been loaded once (even=
=20
if it has not been used and/or has been unloaded), the kernel (2.6.14-rc5) =
is=20
unable to enter ACPI S3.=20

with best regards,
Rene

--nextPart1180763.kL0HVBaoVS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDZPgzq7SPDcPCS94RAgneAJ0SRIJZWZc9Cbba/9fFGTbpPNnLawCfSn/6
WxykKVyjrxHVZc14qCfeVJo=
=vbpu
-----END PGP SIGNATURE-----

--nextPart1180763.kL0HVBaoVS--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
