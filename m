Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: # =?ISO-8859-1?Q?Bj=F6rn?= Specht # <bspecht@gmx.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BlueZ rfcomm channel
Message-ID: <20050121112238.0c724746@CleverSophie>
In-Reply-To: <41EFB84B.8070403@dark-reality.de>
References: <20050120142851.72c326f4@CleverSophie>
	<41EFB84B.8070403@dark-reality.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Fri__21_Jan_2005_11_22_38_+0100_5.a6z8S3FtypEgii;
 protocol="application/pgp-signature"; micalg=pgp-sha1
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
Date: Fri, 21 Jan 2005 11:22:38 +0100

--Signature_Fri__21_Jan_2005_11_22_38_+0100_5.a6z8S3FtypEgii
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

THX Lars,=20

I also found some stuff in rctest.c . I will have a go with that,too.

Cheers
Bj=F6rn

On Thu, 20 Jan 2005 14:55:23 +0100
Lars Grunewaldt <lgw@dark-reality.de> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> # Bj=F6rn Specht # wrote:
> | Hi guys,
> |
> | I am working on BlueZ for a few days now and it is hard to start
> working with it for me. I want to write a program (Client/Server) in C
> which uses the rfcomm socket and I want to use a channel to transfer
> data between these two computers.
> | The HCI_inquiry function is running and finds the other PC. How can I
> establish a connection between these two computers with the rfcomm socket=
s?
>=20
> have a look at the example programs. it should be something like:
>=20
> (this is for connection to a headset with rfcomm, but it should be
> similar. There are other examples in bluez-tools, if I'm not mistaken.
>=20
> static int rfcomm_connect(bdaddr_t * src, bdaddr_t * dst, uint8_t channel)
> {
> ~        struct sockaddr_rc addr;
> ~        int s;
>=20
> ~        if ((s =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < =
0) {
> ~                return -1;
> ~        }
>=20
> ~        memset(&addr, 0, sizeof(addr));
> ~        addr.rc_family =3D AF_BLUETOOTH;
> ~        bacpy(&addr.rc_bdaddr, src);
> ~        addr.rc_channel =3D 0;
> ~        if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> ~                close(s);
> ~                return -1;
> ~        }
>=20
> ~        memset(&addr, 0, sizeof(addr));
> ~        addr.rc_family =3D AF_BLUETOOTH;
> ~        bacpy(&addr.rc_bdaddr, dst);
> ~        addr.rc_channel =3D channel;
> ~        if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
> ~                close(s);
> ~                return -1;
> ~        }
>=20
> ~        return s;
> }
>=20
> have fun,
> ~  Lars
>=20
>=20
> - --
> Lars Grunewaldt
> * software development
> * multimedia design
> skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
> web: http://www.dark-reality.de
> mail: lgw@dark-reality.de
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>=20
> iD8DBQFB77hLQWC6DTWkDAoRAqv0AJoCI5XuhYrqFGAM9qvqmbJr/VEQawCcD0uj
> 34s/2fQhdoiN+maE7liaH2M=3D
> =3DPhyO
> -----END PGP SIGNATURE-----
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20

--Signature_Fri__21_Jan_2005_11_22_38_+0100_5.a6z8S3FtypEgii
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB8NfwrdSygrmIeLARAgpYAJ9m2C11HbOyShlaLtdIKENQs2cvgACdGEhc
N8Y3FJWNHod2k41ctpzJ+os=
=07Pz
-----END PGP SIGNATURE-----

--Signature_Fri__21_Jan_2005_11_22_38_+0100_5.a6z8S3FtypEgii--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
