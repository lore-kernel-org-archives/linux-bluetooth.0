Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thomas Kear <thomas.kear@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 30 Oct 2006 11:23:06 +1300
References: <200610261319.41239.thomas.kear@gmail.com>
	<1162152981.4720.9.camel@localhost>
In-Reply-To: <1162152981.4720.9.camel@localhost>
MIME-Version: 1.0
Message-Id: <200610301123.09943.thomas.kear@gmail.com>
Subject: Re: [Bluez-users] hidd connect permissions
Reply-To: thomas.kear@gmail.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0035126972=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0035126972==
Content-Type: multipart/signed; boundary="nextPart1251615.u7C6eDCVlQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1251615.u7C6eDCVlQ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for that.  Removed my phone from the linkkeys file, connected=20
with 'hidd --connect 00:12:EE:07:95:48', re-paired and all was well. =20
Discovered my phone even asks if you want to open the remote control app wh=
en=20
hidd requests it.

On Monday 30 October 2006 9:16 am, Marcel Holtmann wrote:
> Hi Thomas,
>
> > # hidd -n --server
> > hidd[32412]: Bluetooth HID daemon
> > hidd[32412]: Rejected connection from unknown device 00:12:EE:07:95:48
> > (same result running as non-root user)
>
> connect from the Linux machine once again. It needs to store the HID
> descriptor and authorize the phone first.
>
> Regards
>
> Marcel

--nextPart1251615.u7C6eDCVlQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFRSnN8/Qi7qeDfygRAhCTAJwPFM5B/foQMSsujVnkHVlWw4Zn1ACeJIFx
1dkDKw5J0dchLq2VbZRD0NE=
=fy4Z
-----END PGP SIGNATURE-----

--nextPart1251615.u7C6eDCVlQ--


--===============0035126972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0035126972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0035126972==--
