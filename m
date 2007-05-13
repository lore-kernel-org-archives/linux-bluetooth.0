Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464756E9.4090307@gentoo.org>
Date: Sun, 13 May 2007 21:20:25 +0300
From: =?UTF-8?B?UGV0dGVyaSBSw6R0eQ==?= <betelgeuse@gentoo.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4646071D.6020303@gentoo.org> <464750FD.3080409@gentoo.org>
In-Reply-To: <464750FD.3080409@gentoo.org>
Subject: Re: [Bluez-devel] a2dpd getting into an endless loop when it fails
 to get a socket and not dying on CTRL+c
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1717118893=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1717118893==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6A5944CEE655C86E8BFA0537"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A5944CEE655C86E8BFA0537
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Petteri R=C3=A4ty kirjoitti:
> Petteri R=C3=A4ty kirjoitti:
>> Basically it seems to go into an endless loop when it can't get the
>> socket and I must then kill it with kill -9 <pid>.
>>
>=20
> Attached is a patch that fixes this.
>=20
> Regards,
> Petteri
>=20
>=20

Can someone explain why this code is in the main loop in the first
place. I would think that the sockets need to be created only once.

	// Master socket
	sockfd =3D make_server_socket();
	if(sockfd<0) {
		DBG("Cannot get UNIX socket");
		return -1;
	}

	avdtpfd =3D a2dp_make_listen_socket(25);
	if(avdtpfd<0) {
		DBG("Cannot get AVDTP socket");
		return -1;
	}

Regards,
Petteri


--------------enig6A5944CEE655C86E8BFA0537
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGR1bpcxLzpIGCsLQRAoIpAJ97ZOdKqlbLBr4Klcn8Vl3PJuH/wQCfTosT
/SSIzBwxHd4Ucoe0MS7Gbco=
=nud1
-----END PGP SIGNATURE-----

--------------enig6A5944CEE655C86E8BFA0537--


--===============1717118893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1717118893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1717118893==--
