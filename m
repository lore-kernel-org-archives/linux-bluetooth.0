Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: martin f krafft <madduck@madduck.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth on a MIPS-System
Message-ID: <20041007145542.GA15417@albatross.madduck.net>
References: <41651D72.7040806@corscience.de> <1097147273.7325.26.camel@pegasus> <41652A40.4080209@corscience.de> <1097152912.7325.30.camel@pegasus> <41654062.5050009@corscience.de> <1097154841.7325.36.camel@pegasus> <41654D83.1090306@corscience.de> <1097158664.7325.38.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <1097158664.7325.38.camel@pegasus>
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
Date: Thu, 7 Oct 2004 16:55:42 +0200


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marcel Holtmann <marcel@holtmann.org> [2004.10.07.1617 +0200]:
> this rfcomm.o is not a kernel module. It is a compiled object file
> from the bluez-hcidump package.

It certainly is a kernel module in 2.6.8.1:

  /lib/modules/2.6.8-cirrus/kernel/net/bluetooth/rfcomm/rfcomm.ko

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"with sufficient thrust, pigs fly just fine. however, this is not
 necessarily a good idea. it is hard to be sure where they are going
 to land, and it could be dangerous sitting under them as they fly
 overhead."
                                                           -- rfc 1925

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBZVjuIgvIgzMMSnURAr4oAKC3cNBQ5v0u9Pg8tyQSqSCEdTxW6gCg09gb
a4G1IZB1wrMxtxvgvhxZ97c=
=yXrd
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
