Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: martin f krafft <madduck@madduck.net>
To: bluez users list <bluez-users@lists.sourceforge.net>
Message-ID: <20050208143303.GA5194@cirrus.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Subject: [Bluez-users] connection timeout after interrupted software
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
Date: Tue, 8 Feb 2005 15:33:03 +0100


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I use a bluetooth software that establishes connections with my
phone via libbluetooth.so.1. Sometimes this software has to be
killed. When I do this, it leaves the bluetooth stack in a broken
state:

  # hcitool scan
  Scanning ...
  Inquiry failed: Connection timed out

How can I prevent this? What is the best way to rectify the
situation? So far, only reloading the hci_usb kernel module (I use
a dongle) and reconfiguring hci0 works. Since some of my machines
have monolithic kernels, this requires a restart. I'd prefer if
there was a different solution.

Thanks for any advice.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
seminars, n.:
  from "semi" and "arse", hence, any half-assed discussion.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCCM2fIgvIgzMMSnURArA4AJ0ZnceN4wWIl/xJnYGXpAmCz4E23wCcDYiq
pQdgl3jZYbl4mxgpPPfUJ38=
=xylB
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
