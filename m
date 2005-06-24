Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Question to using sdptool
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <OFB3085819.655FE670-ONC125702A.0040152A-C125702A.00445A7F@dcx.dcx>
References: 
	 <OFB3085819.655FE670-ONC125702A.0040152A-C125702A.00445A7F@dcx.dcx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gBXq3mZL+xlURlUUMnZN"
Message-Id: <1119621425.3878.216.camel@baroque.rococosoft.com>
Mime-Version: 1.0
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
Date: Fri, 24 Jun 2005 14:57:05 +0100


--=-gBXq3mZL+xlURlUUMnZN
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Fri, 2005-06-24 at 14:26 +0200, andreas.knuth@daimlerchrysler.com
wrote:
> I am trying to generate some testcases for testing the BT-solution in our
> products. Therefore some small questions.
>=20
> I am using two BT-dongles on one host.
> At moment when I'm execute "sdptool add <service>" or "sdptool  -i hci1 a=
dd
> <service>" both hcix gets the service.
> Question:
> Does provide bluez more then one sdp-daemon - especially to each local
> BT-address one dedicated daemon?
> Or is it possible to have two separated sdp-data bases - one for each loc=
al
> address?

It doesn't really make sense to have one sdpd per device. Services
aren't really bound to a device, rather the machine to which the device
is attached.

> One Question to the options on the command line listed via "sdptool".
> When I try to use the option "--source" I get the error   >> unrecognized
> option '--source'  <<. I am remember me that this option was implemented =
in
> the past.
> Now i found the working option -i for specifying the the outgoing
> connection for sdptool requests :-) Does someone plan to update the help
> description?

Fixed in CVS.

> If the option -i for using with sdptool is correct : when I execute
> "sdptool -i hci1 browse" then bluez is doing on hci0 an inquiring and wit=
h
> the results on hci1 the sdp-requests. Is this process as expected?

Hmmm. It seems there is no way to pass the interface to
sdp_general_inquiry(). Perhaps it is best to add a new function,
sdp_directed_general_inquiry()? Marcel what do you think?

> One wish to the bluez developer:
> The old link-key file (etc/bluetooth/link_key) contained also the time
> (+date) of generating the corresponding key. In the new one
> (/var/lib/bluetooth/.../linkkeys) the time (+date)is missing.
> It was a helpful feature for testing. It is possible to implement this
> again?
>=20
> Thanx
>=20
> Mit freundlichen Gr=FC=DFen / kind regards
>=20
> Andreas Knuth
>=20
> -------------------------------------------------------------------------=
-
> DAIMLERCHRYSLER
> Andreas Knuth
> Telematics Development
> Telematic Architecture and Network (EP/ETS)
> MTC 20/3 Floor 2  M02
> Tel.: +49-(0)7031-90-44232
> Fax: +49-(0)7031-90-44463
> HPC: X 908, 71059 Sindelfingen
> : mailto:andreas.knuth@daimlerchrysler.com
> PGP Fingerprint =3D 2879 2776 4046 B175 1B11  B00E E87E 3EB9 BE68 2194
>=20
> The information contained in this transmission, which may  be
> confidential and proprietary, is only for the intended
> recipients. Unauthorized use is strictly prohibited. If you
> receive this transmission  in error,  please notify  me immediately
> by telephone  or electronic mail and confirm that  you deleted
> this transmission and  the reply from your  electronic mail system.
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
--=20
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

--=-gBXq3mZL+xlURlUUMnZN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCvBExlgMqgVzLyWcRAmsMAJ9coMC0aTs4gtKJcehLqf52SARviwCaApOa
+5yUEtOUFFXTdYp9Qedy4pw=
=HhaV
-----END PGP SIGNATURE-----

--=-gBXq3mZL+xlURlUUMnZN--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
