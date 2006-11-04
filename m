Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Jon Barnett <jbarnett@pobox.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1162654243.3863.12.camel@localhost>
References: <1162654243.3863.12.camel@localhost>
Date: Sat, 04 Nov 2006 12:46:54 -0500
Message-Id: <1162662415.3863.26.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Headset has sound problems
Reply-To: jbarnett@pobox.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0426581930=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0426581930==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ku3UGvCl9t7n0CT8SdDK"


--=-ku3UGvCl9t7n0CT8SdDK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

As an update, I found the following from dmesg:
snd-bt-sco revision 1.12 $
snd-bt-sco: snd-bt-scod thread starting
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 16002 count: 4000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
snd-bt-sco: Shift problem detected! Fixing to 1.
snd-bt-sco: Shift problem detected! Fixing to 0.
... (continued for a while)
snd-bt-sco: Shift problem detected! Fixing to 0.
snd-bt-sco: Shift problem detected! Fixing to 1.
snd-bt-sco: Shift problem detected! Fixing to 0.
snd-bt-sco: Shift problem detected! Fixing to 1.
snd-bt-sco: Shift problem detected! Fixing to 0.
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: Disposing of previous socket count 3
snd-bt-sco: file_count is 1 (expected 3)


On Sat, 2006-11-04 at 10:30 -0500, Jon Barnett wrote:
> I have kernel 2.6.18.1. I recently upgraded alsa both in the kernel
> and userland to 1.0.13.


--=-ku3UGvCl9t7n0CT8SdDK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFTNIOu2cEic/xsEARAn3pAKDdjM7HVBaRoYDUFZ6PEv9zFCuU/ACggKCH
DhGoky+b4JzDVlG8+sFERoM=
=QC7n
-----END PGP SIGNATURE-----

--=-ku3UGvCl9t7n0CT8SdDK--



--===============0426581930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0426581930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0426581930==--
