Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bug in l2cap.c
From: Pierre BETOUIN <info16@unsigned.ath.cx>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1137606864.7000.22.camel@localhost>
References: <1137606424.3070.18.camel@lapt41p>
	 <1137606864.7000.22.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XmkmniSusOiowaJDQBEH"
Message-Id: <1137608163.3070.26.camel@lapt41p>
Mime-Version: 1.0
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
Date: Wed, 18 Jan 2006 19:16:03 +0100


--=-XmkmniSusOiowaJDQBEH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

	Hi Marcel,

Le mercredi 18 janvier 2006 =E0 18:54 +0100, Marcel Holtmann a =E9crit :
> Hi Pierre,
>=20
> > Currently pentesting several bluetooth devices, I found a bug in hcidum=
p
> > (tested version : 1.29).=20
>=20
> you know that hcidump is a testing/development utility? It is basically
> not supposed to be fully robust against malicious packets.
True, one more reason to correct this then, I agree with you ;)

> Feel free to provide a patch and not an exploit.
The patch is (nearly) in my previous mail : check it, I gave you the short =
piece=20
of code concerned, should not give you headache fixing it.

> Regards
>=20
> Marcel

Regards,

	Pierre=20

--=20
Pierre BETOUIN
info16@unsigned.ath.cx
http://securitech.homeunix.org
GPG Key : 0x94D9CB23

--=-XmkmniSusOiowaJDQBEH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDzoXjLNWSQpTZyyMRAvt6AJ9mhcDw8g+vN/UL1tthHl34lYmq3wCcC4KR
IO4NuAEvtRQnqFWxFZPGE2o=
=jzTU
-----END PGP SIGNATURE-----

--=-XmkmniSusOiowaJDQBEH--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
