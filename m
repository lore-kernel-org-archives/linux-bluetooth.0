Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FB0236.3030600@coriand.com>
From: Franz Coriand <franz@coriand.com>
MIME-Version: 1.0
To: BlueZ-Mailingliste <bluez-users@lists.sourceforge.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC742FC7C613136FD93C05F3D"
Subject: [Bluez-users] scanning possible, but no l2ping?
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
Date: Fri, 28 Jan 2005 22:25:42 -0500

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC742FC7C613136FD93C05F3D
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

My problem with my two bluetooth adapter is, it's possible to scan the
area und I get the right result, but it isn't possible to execute l2ping?
I've a desktop computer and my crappy linux watch ... only with the
desktop i've hcidump yet.
I hope it is something with the config wrong?!

Franz

DESKTOP:
========

[root@dervish root]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0F:3D:0B:EE:6C ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:1004 acl:0 sco:0 events:31 errors:0
        TX bytes:379 acl:0 sco:0 commands:21 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'dervish-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

[root@dervish root]# hcitool scan
Scanning ...
        00:60:57:01:10:AE       WatchPad_15

[root@dervish root]# l2ping 00:60:57:01:10:AE
Can't connect.: Connection timed out

hcidump (desktop) during  try to execute l2ping from desktop to watch:
------------------------------------------------------------------------
[root@dervish sbin]# ./hcidump
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff


< HCI Command: Create Connection(0x01|0x0005) plen 13
 > HCI Event: Command Status(0x0f) plen 4
 > HCI Event: Link Key Request(0x17) plen 6
 > HCI Event: Connect Complete(0x03) plen 11



WATCH:
======

# ./hciconfig -a
hci0:   Type: UART
        BD Address: 00:60:57:01:10:AE ACL MTU: 384:80  SCO MTU: 128:80
        UP RUNNING PSCAN ISCAN
        RX bytes:172 acl:0 sco:0 events:17 errors:0
        TX bytes:80 acl:0 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x09 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'WatchPad_15'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0xbc LMP Ver: 1.1 (0x1) LMP Subver: 0xbc
        Manufacturer: Cambridge Silicon Radio (10)


# ./hcitool scan
Scanning ...
        00:0F:3D:0B:EE:6C       dervish-0

# ./l2ping 00:0F:3D:0B:EE:6C
Can't connect.: Connection timed out


hcidump (desktop) during  try to execute l2ping from watch to desktop:
------------------------------------------------------------------------
 > HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
 > HCI Event: Command Status(0x0f) plen 4
 > HCI Event: Link Key Request(0x17) plen 6
 > HCI Event: Role Change(0x12) plen 8
 > HCI Event: Connect Complete(0x03) plen 11


--------------enigC742FC7C613136FD93C05F3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+wI2Rct14D3a7wsRAnUfAJ9lnjHqEndD5rdEZsF8NOY63jvV/gCg1vYC
aqLXKOl/vVH2M2tGdl42TFI=
=RlP0
-----END PGP SIGNATURE-----

--------------enigC742FC7C613136FD93C05F3D--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
