Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: Cedric Hottier <chottier@nerim.net>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btobex and fisio820/825
Message-ID: <20030808095615.GC1520@smartdata.ch>
References: <200304122336.49369.chottier@nerim.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
In-Reply-To: <200304122336.49369.chottier@nerim.net>
From: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 8 Aug 2003 11:56:15 +0200


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> I tried to transfer some pictures from my PC to my fisio 825 with btobex.
> I had to change a little bit the obex.c file to make it work.
>=20
> I removed the first OBEX_ObjectAddHeader call :
> 	//OBEX_ObjectAddHeader(handle, object,
> 	//	OBEX_HDR_CONNECTION, hd, 4, OBEX_FL_FIT_ONE_PACKET);
> and I replaced OBEX_FL_FIT_ONE_PACKET by 0 in the others OBEX_ObjectAddHe=
ader=20
> call.

I have tested btobex with my T68i, and a custom device running BlueZ,
and I have the same problem as you.

Your patch correct the problem, and after that, btobex is working with
both my T68i and our custom device.

Marcel, can you see if this is a correct patch, or where is the problem
with btobex ?

Thanks in advance.

		Olivier
--=20
Olivier Bornet                      http://www.smartdata.ch/
Olivier.Bornet@smartdata.ch         SMARTDATA SA
Phone: +41-27-723'55'03             Rue du Coll=E8ge 5A
GPG key ID: C53D9218                CH-1920 Martigny

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/M3O/dj3R/MU9khgRAomRAJ0dDGfZDMCacLR0IxY3DFtgylfFpACZAdzu
1o3rvB78rEYPxJvI7aYUK2c=
=GVb8
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
