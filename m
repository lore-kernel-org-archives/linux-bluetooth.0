Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Olivier Bornet <Olivier.Bornet@puck.ch>
To: Terence Rudkin <trexx@pobox.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
Message-ID: <20040120081245.GA1871@smartdata.ch>
References: <1074457244.3254.17.camel@localhost.localdomain> <1074458664.6070.73.camel@pegasus> <1074480891.2817.10.camel@localhost.localdomain> <1074514935.6070.80.camel@pegasus> <1074568150.7831.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
In-Reply-To: <1074568150.7831.5.camel@localhost.localdomain>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 20 Jan 2004 09:12:45 +0100


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Terence,

> > do you have patched the USB HID driver?
> I am not sure.

Look at the thread:

   http://sourceforge.net/mailarchive/message.php?msg_id=3D6881178

You need to patch your kernel for having hid2hci working. Note also that
at this time, you can only switch from hid to hci, and not from hci to
hid.

Hope this help.

Good day.

		Olivier
--=20
Olivier Bornet                 |      fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results       |      english  : http://puck.ch/e
http://puck.ch/                |      deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch         |      italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://wwwkeys.pgp.net

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFADOL9dj3R/MU9khgRAscYAKCk5IxNtv7ZP3+KHUuuyQR+5l6GugCbBD17
LmfJW9itgelwdMrB7gl0YX0=
=Z/S9
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
