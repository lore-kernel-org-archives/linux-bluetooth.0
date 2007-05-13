Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46474B6A.1040705@gentoo.org>
Date: Sun, 13 May 2007 20:31:22 +0300
From: =?UTF-8?B?UGV0dGVyaSBSw6R0eQ==?= <betelgeuse@gentoo.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <432beae0705121846x7b181d3fm180205dfa783e975@mail.gmail.com><432beae0705121900q237f835ahf6d2ac63c619415@mail.gmail.com>	<CE5216C10C83944D9FD37B65CD33F3970CF4D7@mplex01.mpl.access-company.com>
	<CE5216C10C83944D9FD37B65CD33F3970CF4D8@mplex01.mpl.access-company.com>
In-Reply-To: <CE5216C10C83944D9FD37B65CD33F3970CF4D8@mplex01.mpl.access-company.com>
Subject: Re: [Bluez-devel] RE : RE : Problems connecting to a bluetooth
 headset faoMarcel
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1602616364=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1602616364==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig008FB4C33147849E95FB2539"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig008FB4C33147849E95FB2539
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Frederic Dalleau kirjoitti:
>=20
>>> A2DPD[18:44:14.790]: a2dp_make_listen_socket: (errno=3D13:Permission
>>> denied)Cannot bind socket 6 for psm 25
>=20
>> I'm wondering what causes this, the bind call is failing with errno=3D=
EPERM.
>> Do you know of something in bluez config or something security related=

> that could prevent binding if not root?
>=20
> I should have RTFM
> http://people.csail.mit.edu/albert/bluez-intro/x145.html#port-numbers
> Thanks,
> Frederic
>=20
>=20

from http://bluetooth-alsa.sourceforge.net/build.html
"... and run a2dpd (it's not advised to run it as root)."

Hehe. I wonder what the developers do then as it doesn't work as a
normal user.

Regards,
Petteri


--------------enig008FB4C33147849E95FB2539
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGR0tqcxLzpIGCsLQRAvFdAKCDzDNSXk9AG2BDlKb/Kh5f9rX6ZQCeItcC
m/OplDyDjPAmN/gGJWY4O8o=
=ZPJd
-----END PGP SIGNATURE-----

--------------enig008FB4C33147849E95FB2539--


--===============1602616364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1602616364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1602616364==--
