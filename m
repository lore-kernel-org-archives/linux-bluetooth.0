Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 10 Aug 2006 13:05:26 -0300
From: redondos <redondos@gmail.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060810160526.GC16806@refinery.twat.com.ar>
References: <20060803043158.GA13259@refinery.twat.com.ar>
MIME-Version: 1.0
In-Reply-To: <20060803043158.GA13259@refinery.twat.com.ar>
Subject: Re: [Bluez-users] Cannot transfer files via OBEX
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0349394910=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0349394910==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's pointless, no matter how many different configurations I try, I       =
=20
just can't upload anything to the phone. Am I doing something wrong? Is    =
=20
it supposed to be possible to upload, say, a theme using obexft -b         =
=20
<device> -B <channel> -c Themes -p <theme-name>?                           =
=20

The dump always shows a piece of the file (hex dump) and then:
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 12 pf 1 ilen 0 fcs 0xa2
> HCI Event: Disconn Complete (0x05) plen 4                                =
=20
    status 0x00 handle 1 reason 0x08
    Reason: Connection Timeout

Fredy: Can I see your scripts for doing such things, please?

--=20
redondos

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE21lGJZ/yCc25j3IRAtBeAKCxRyrC4TEP9qgu34OjzGs/VDvfSgCdEd/T
RendjTJ/uIAKxi5YfggQxr0=
=cbxu
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--


--===============0349394910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0349394910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0349394910==--
