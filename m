Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <465AC8C7.1020502@imperial.ac.uk>
Date: Mon, 28 May 2007 13:19:19 +0100
From: Konrad Kieling <konrad.kieling@imperial.ac.uk>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4656FDE4.5070001@imperial.ac.uk>
In-Reply-To: <4656FDE4.5070001@imperial.ac.uk>
Subject: Re: [Bluez-users] hid keyboard events get lost
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0983299938=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0983299938==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3BE11B2749ACB3A762480DEA"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3BE11B2749ACB3A762480DEA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hello again,
just to let you know: the ``Freedom Universal Keyboard'' is working
perfectly now, after applying some minor tweaks to the kernel:

1. something to avoid the long negotiation for the mtu size, i commented
   out the following lines in l2cap_build_conf_req
   (net/bluetooth/l2cap.c):

   //	if (pi->imtu !=3D L2CAP_DEFAULT_MTU)
   //		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);

   yes i know, this might not be the way to go, but bt still works with
   my mobile and the headset. maybe someone has an idea for a cleaner
   solution?

2. unfortunately the data coming from the keyboard is missing the first
   byte telling us about keyboard input. in hidp_input_report
   (net/bluetooth/hidp/core.c) insert the following
   lines after variable declaration:

   if ( ( session->input->id.vendor =3D=3D 0x045e ) &&
        ( session->input->id.product =3D=3D 0x0403 ) )
     {
     for ( i =3D 7; i >=3D 0; i -- ) skb->data[i + 1] =3D skb->data[i];
     skb->data[0] =3D 0x01;
     }

   again, is there a way to cope with this problem in a more generic
   way?

ciao,
  konrad






Konrad Kieling wrote:
> hi,
> i have some problems with getting the ``Freedom Universal Keyboard'' to=

> work. after authentication the keyboard is automatically trying to
> connect to my computer. however, the connections never work. heres is
> the output of ``hcidump -V'' (using bluez-utils-3.10.1 and kernel
> 2.6.16.13):
> > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 00:0B:0D:85:30:0B class 0x002540 type ACL
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 00:0B:0D:85:30:0B role 0x01
>     Role: Slave
>   .
>   .
>   .
> > ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 17 scid 0x0040
> < ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
> > ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> < ACL data: handle 42 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
> > ACL data: handle 42 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 1 clen 4
>       MTU 128
> < ACL data: handle 42 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
> > ACL data: handle 42 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 1 clen 4
>       MTU 128
> < ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 42 packets 1
> > ACL data: handle 42 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>     handle 42 reason 0x13
>     Reason: Remote User Terminated Connection
> > HCI Event: Command Status (0x0f) plen 4
>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 42 reason 0x16
>     Reason: Connection Terminated by Local Host
>=20
>=20
> it seems to have problems in negotiating the mtu size. so i tried and
> commented out the lines in hidd which set the preferred mtu size,
>   opts.imtu =3D HIDP_DEFAULT_MTU;
>   opts.omtu =3D HIDP_DEFAULT_MTU;
>=20
> with this version of hidd the connection works perfectly, and even
> keystrokes are transferred, as can be seen in the hcidump:
>   .
>   .
>   .
> > ACL data: handle 43 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 17 scid 0x0040
> < ACL data: handle 43 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
> > ACL data: handle 43 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 48
> < ACL data: handle 43 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 43 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
> > ACL data: handle 43 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> > ACL data: handle 43 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 19 scid 0x0041
> < ACL data: handle 43 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
> > ACL data: handle 43 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
>       MTU 48
> < ACL data: handle 43 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 43 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
>       MTU 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
> > ACL data: handle 43 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 43 flags 0x02 dlen 5
>     L2CAP(d): cid 0x0040 len 1 [psm 17]
>       HIDP: Set protocol: Boot protocol
> < ACL data: handle 43 flags 0x02 dlen 7
>     L2CAP(d): cid 0x0041 len 3 [psm 19]
>       HIDP: Data: Output report
> > ACL data: handle 43 flags 0x02 dlen 5
>     L2CAP(d): cid 0x0040 len 1 [psm 17]
>       HIDP: Handshake: Successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 43 packets 1
> > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 43 mode 0x02 interval 128
>     Mode: Sniff
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 43 mode 0x00 interval 0
>     Mode: Active
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
> > ACL data: handle 43 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 19]
>       HIDP: Data: Input report
>=20
>=20
> hcidump -X also shows, that the packets indeed contain keycodes.
> the device is correctly registered in /proc/bus/input/devices and in
> /sys/class/input/input4. however, the events never arrive in
> /dev/input/event4. the debugging messages of the hidp kernel module
> suggest, that they dont even arrive at this module:
>   May 25 15:57:38 ed007 kernel: Bluetooth: HIDP (Human Interface
>                   Emulation) ver 1.1
>   May 25 16:06:13 ed007 hidd[6345]: Bluetooth HID daemon
>   May 25 16:06:24 ed007 hcid[5321]: link_key_request
>                   (sba=3D00:03:7A:F0:73:B5, dba=3D00:0B:0D:85:30:0B)
>   May 25 16:06:24 ed007 hidd[6345]: New HID device 00:0B:0D:85:30:0B
>                   (Bluetooth Kbd)
>   May 25 16:06:24 ed007 kernel: hidp_add_connection:
>   May 25 16:06:24 ed007 kernel: __hidp_get_session:
>   May 25 16:06:24 ed007 kernel: hidp_add_connection: ctrl mtu 0 intr
>                   mtu 0
>   May 25 16:06:24 ed007 kernel: input: Bluetooth HID Boot Protocol
>                   Device as /class/input/input4
>   May 25 16:06:24 ed007 kernel: __hidp_send_ctrl_message: session
>                   d972f640 data 00000000 size 0
>   May 25 16:06:24 ed007 kernel: hidp_input_event: input d4a1e800 type 1=
7
>                   code 0 value 0
>   May 25 16:06:24 ed007 kernel: hidp_session: session d972f640
>   May 25 16:06:24 ed007 kernel: hidp_process_transmit: session d972f640=

>   May 25 16:06:24 ed007 kernel: hidp_send_frame: sock db45bb40 data
>                   e4fab800 len 1
>   May 25 16:06:24 ed007 kernel: hidp_send_frame: sock db45b840 data
>                   eca4ba00 len 3
>   May 25 16:06:24 ed007 kernel: hidp_process_transmit: session d972f640=

>=20
>=20
> does anyone have a clue why the events get lost on their way? or
> something on this mtu problem?
>=20
> thanks,
>   konrad


--------------enig3BE11B2749ACB3A762480DEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGWsjHvBXlQC0NozQRAtybAJ47CLx6ZKQ+0so+IQUS27DXcQXRGQCggO1n
qq4jWiltsRc0ct4gPQi3Flg=
=mGOh
-----END PGP SIGNATURE-----

--------------enig3BE11B2749ACB3A762480DEA--


--===============0983299938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0983299938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0983299938==--
