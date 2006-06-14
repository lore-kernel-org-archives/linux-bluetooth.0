Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 14 Jun 2006 08:24:39 -0400
To: bluez-users@lists.sourceforge.net
Message-ID: <20060614122439.GA5078@merconline.com>
MIME-Version: 1.0
From: jblack@merconline.com (James Blackwell)
Subject: [Bluez-users] sdpd reliably crashes when scanned by Garmin iQue M5
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0851653676=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0851653676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all!

I'm having a bit of a problem with sdpd (actually, have had for about two
yes). Each time I scan my laptop with my Garmin iQueue M5 (pocketpc), sdpd
seems to lock up. This problem doesn't show itself when I scan outwards
=66rom the laptop to other bluetooth devices. obexftp seems to also work
fine. I can even connect to the 3G network over my cell phone to get on
the internet. But any time I launch BTExplorer and try and scan my laptop,
sdpd goes to 100% cpu usage.

             System: Ubuntu Dapper
bluez-utils version: bluez-utils_2.24-0ubuntu6_i386.deb
             Laptop: Sony Vaio VGN-T350P w/ Builtin Bluetooth
             Kernel: 2.6.15-23-686 #1 SMP PREEMPT

I think the device is an internal usb device identified as:
Bus 003 Device 002: ID 044e:3007 Alps Electric Co., Ltd
(bDeviceProtocol is Bluetooth and the iProduct is "UGX"


Here is a systace of the last thing sdpd did before it ended up in a loop:

Process 5854 attached - interrupt to quit

select(3, [0 1 2], NULL, NULL, NULL)    =3D 1 (in [0])
accept(0, {sa_family=3DAF_BLUETOOTH,
        sa_data=3D"\1\0E\2\1O\5\0\364\267\r\222\4\10"}, [10]) =3D 4
select(5, [0 1 2 4], NULL, NULL, NULL)  =3D 1 (in [4])
recv(4, "\6\0\36\0\33", 5, MSG_PEEK)    =3D 5
recv(4, "\6\0\36\0\0335\3\31\1\0\7\3505\21\t\0\1\t\0\4\t\0\t\t\0"..., 32,
        0) =3D 32
getpeername(4, {sa_family=3DAF_BLUETOOTH,
    sa_data=3D"\1\0E\2\1O\5\0\364\267\r\222\4\10"}, [10]) =3D 0
getsockopt(4, SOL_TCP, TCP_NODELAY, "\0\10\240\2\377\377\0\0", [8]) =3D 0
getsockname(4, {sa_family=3DAF_BLUETOOTH,
    sa_data=3D"\1\0\335\320(J\1\0\0\10\240\2\377\377"}, [10]) =3D 0
brk(0x8090000)                          =3D 0x8090000
mmap2(NULL, 200704, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
    =3D 0xb7e18000
brk(0x8080000)                          =3D 0x8080000
mremap(0xb7e18000, 200704, 200704, MREMAP_MAYMOVE) =3D 0xb7e18000
mremap(0xb7e18000, 200704, 200704, MREMAP_MAYMOVE) =3D 0xb7e18000
mremap(0xb7e18000, 200704, 204800, MREMAP_MAYMOVE) =3D 0xb7de6000
mremap(0xb7de6000, 204800, 204800, MREMAP_MAYMOVE) =3D 0xb7de6000
mremap(0xb7de6000, 204800, 204800, MREMAP_MAYMOVE) =3D 0xb7de6000
mremap(0xb7de6000, 204800, 204800, MREMAP_MAYMOVE) =3D 0xb7de6000
mremap(0xb7de6000, 204800, 208896, MREMAP_MAYMOVE) =3D 0xb7de6000
mremap(0xb7de6000, 208896, 208896, MREMAP_MAYMOVE) =3D 0xb7de6000
mremap(0xb7de6000, 208896, 208896, MREMAP_MAYMOVE) =3D 0xb7de6000
mremap(0xb7de6000, 208896, 208896, MREMAP_MAYMOVE) =3D 0xb7de6000
Process 5854 detached


Thanks in advance and Regards,
James


--=20
My home page:   <a href=3D"http://jblack.linuxguru.net">James Blackwell</a>
Gnupg 06357400  F-print AAE4 8C76 58DA 5902 761D  247A 8A55 DA73 0635 7400

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEkAAGilXacwY1dAARAmEmAJ4ktmsp7w1nxmYo2YseYVglQt5dMACcDbyM
Bx0yavsYG84Aesq1QCkGFdA=
=5gxi
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--


--===============0851653676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0851653676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0851653676==--
