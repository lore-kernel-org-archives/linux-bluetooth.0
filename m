Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP chnnel
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <E1EFR9z-0001K1-00.bizon_art-mail-ru@f48.mail.ru>
References: <E1EFR9z-0001K1-00.bizon_art-mail-ru@f48.mail.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XBX5fJ9+TrM3RyPASFbz"
Message-Id: <1126689639.2113.16.camel@baroque.rococosoft.com>
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
Date: Wed, 14 Sep 2005 10:20:39 +0100


--=-XBX5fJ9+TrM3RyPASFbz
Content-Type: text/plain; charset=iso-8859-5
Content-Transfer-Encoding: quoted-printable

Try replacing SOCK_RAW with SOCK_SEQPACKET. SOCK_RAW is only for raw HCI
sockets.

On Wed, 2005-09-14 at 10:54 +0400, =B0=E0=E2=D5=DC =B1=D8=D7=EE=DA=DE=D2 wr=
ote:
> Hellow all.
>=20
>     I`m try to write application that send and recive data over L2CAP cha=
nnel, between PC and my custom arm board. I have a next problem. I dont und=
erstand haw create a socket, if PC must inquirying and connect to my board.=
 Device must remain slave in piconnect.
>     I`m try run next simpl daemon on my custom arm board:
>=20
> 	struct sockaddr_l2 L2capAddr;
> 	int iSockFd;
> 	iSockFd =3D socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP);
> 	if (iSockFd =3D=3D -1) {
> 		TRACE1("opening L2CAP socket: %s", strerror(errno));
> 		return -1;
> 	};
> 	L2capAddr.l2_bdaddr =3D *BDADDR_ANY;
> 	/*L2capAddr.l2_bdaddr =3D *strtoba( strdup("78:A1:1F:96:A0:00"));*/
> 	L2capAddr.l2_family =3D AF_BLUETOOTH;
> 	L2capAddr.l2_psm    =3D htobs(SDP_PSM); // I sigth this valuer in Tsimba=
l code
> 	if(0 > bind(iSockFd, (struct sockaddr *)&L2capAddr, sizeof(L2capAddr)))
> 	{
> 		TRACE1("binding L2CAP socket: %s", strerror(errno));
> 		return -1;
> 	}
> 	incoming =3D listen(iSockFd, ACTIVE_CONN_MAX);
>=20
> But ACL connection don`t establishing. The hcidump on board give next cha=
t
>=20
> > HCI Event: Connect Request (0x04) plen 10
>   78 A1 1F 96 A0 00 04 5F 00 01
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   78 A1 1F 96 A0 00 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: Link Key Request (0x17) plen 6
>   78 A1 1F 96 A0 00
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>   78 A1 1F 96 A0 00
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0C 04 00 78 A1 1F 96 A0 00
> > HCI Event: PIN Code Request (0x16) plen 6
>   78 A1 1F 96 A0 00
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>   78 A1 1F 96 A0 00 10 xx xx xx xx xx xx xx xx xx xx xx xx xx
>   xx xx xx
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0D 04 00 78 A1 1F 96 A0 00
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   78 A1 1F 96 A0 00 01
> > HCI Event: Command Status (0x0f) plen 4
>   0C 01 09 04
> > HCI Event: Link Key Notification (0x18) plen 23
>   78 A1 1F 96 A0 00 xx xx xx xx xx xx xx xx xx xx xx xx xx xx
>   xx xx xx
> > HCI Event: Connect Complete (0x03) plen 11
>   00 28 00 78 A1 1F 96 A0 00 01 00
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>   28 00 18 CC
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>   78 A1 1F 96 A0 00 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 0F 04
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>   00 28 00 18 CC
> > HCI Event: Max Slots Change (0x1b) plen 3
>   28 00 05
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 4
>   28 00 00 00
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0D 04 12 28 00 00 00 00 00
> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
>   00
> > HCI Event: Command Complete (0x0e) plen 4
>   01 1A 0C 00
> > HCI Event: QoS Setup Complete (0x0d) plen 21
>   00 28 00 00 01 00 00 00 00 00 00 00 00 FF FF FF FF FF FF FF
>   FF
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> < ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 2 status 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 28 00 01 00
> > HCI Event: Disconn Complete (0x05) plen 4
>   00 28 00 13
>=20
> And my board don`t response on HCI inquiryng from PC. I must restart hcia=
ttach.
> I think, i incorrectly open L2CAP socket. Somebody help me please.
>=20
>=20
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.=20
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
--=20
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

--=-XBX5fJ9+TrM3RyPASFbz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDJ+tnlgMqgVzLyWcRAqEPAKCB2e71L/RfIPeeyUMx0pSHnyPEVwCfTga/
M3X7W9NJbEogP8/DW8t5Imk=
=UBZn
-----END PGP SIGNATURE-----

--=-XBX5fJ9+TrM3RyPASFbz--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
