Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez-sdp depreciated? Was Which fedora core?
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1100813353.7164.87.camel@pegasus>
References: <cnhnd6$toe$1@sea.gmane.org>  <1100769119.7164.17.camel@pegasus>
	 <1100798738.3439.4.camel@localhost.localdomain>
	 <1100803683.7164.74.camel@pegasus>
	 <1100808919.3433.12.camel@localhost.localdomain>
	 <1100813353.7164.87.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0nVYDIWWSVK7Nu8bG4yk"
Message-Id: <1100861560.7136.49.camel@baroque.rococosoft.com>
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
Date: Fri, 19 Nov 2004 10:52:40 +0000


--=-0nVYDIWWSVK7Nu8bG4yk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Philip, Marcel,

On Thu, 2004-11-18 at 22:29 +0100, Marcel Holtmann wrote:
> Hi Philip,
>=20
> > > no it is not, because bluez-sdp and bluez-pan are deprecated.
> > >=20
> > I have been connecting my Palm T2 to my network using bluez to create a
> > kind of dial-up network via bluetooth using bluez.
> >=20
> > Below is my configuration script taken from core 2.
> >=20
> > #
> > # Start configuration of Bluetooth network
> > hciconfig hci0 up
> > hcid
> > modprobe rfcomm
> > dund --listen --msdun --channel 1 10.2.0.1:10.2.0.10
> > echo '1' > /proc/sys/net/ipv4/ip_forward
> > /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> > /sbin/iptables -A FORWARD -i ppp0 -j ACCEPT
> > /sbin/iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEP=
T
> >=20
> > Bluez-sdp appears to be fundamental to its operation. All is ok until I
> > reach dund, that line returns:-
> > dund: error while loading shared libraries: libsdp.so.2: cannot open
> > shared object file: No such file or directory
> >=20
> > This is without installing bluez-sdp from core 2, if it is installed I
> > get an sdp error in the system logs at this line.
> >=20
> > I have looked through the bluez site and searched google but cannot fin=
d
> > any explanation of why it has been depreciated, or what has replaced it=
.
>=20
> the library part of bluez-sdp is now in bluez-libs and libsdp don't
> exists anymore. And the sdpd is part of the bluez-utils package.

You can fool your installation into thinking libsdp is there by
softlinking it to libbluetooth. Hacky but it works.

# ln -s /usr/lib/libbluetooth.so /usr/lib/libsdp.so

Cheers,
Steve
--=20
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

--=-0nVYDIWWSVK7Nu8bG4yk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBndB4lgMqgVzLyWcRAl2ZAJ9MmiHwvzes1FyfCrDPIoIDVBKz6gCfRn1h
EGGwc+0dYI12ZQP8lhDFqT8=
=rQML
-----END PGP SIGNATURE-----

--=-0nVYDIWWSVK7Nu8bG4yk--



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
