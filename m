Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Adam Tauno Williams <adam@morrison-ind.com>
To: bluez-users@lists.sourceforge.net
Date: Mon, 30 Jul 2007 15:37:25 -0400
Message-Id: <1185824245.11755.5.camel@aleph.whitemice.org>
Mime-Version: 1.0
Subject: [Bluez-users] Palm Treo Pairing Problem (openSUSE 10.2)
Reply-To: adam@morrison-ind.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1298928373=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1298928373==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Iwu5JQpV6wd6dQO0rh2z"


--=-Iwu5JQpV6wd6dQO0rh2z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

openSUSE 10.2
---------------
bluez-cups-3.7-29
bluez-utils-3.7-29.2
bluez-firmware-1.2-20
bluez-gnome-0.6-7
bluez-libs-3.7-14.1
bluez-hcidump-1.33-8

I have used bluetooth/LINUX in the past;  but now I'm utterly unable to
pair devices (Palm Treo and a USB Blueetooth dongle).  I've used this
dongle on other machines and successfully paired.  The devices see each
other but no matter what the PIN code I enter on the Palm results in
"Unable to add Aleph to your trusted device list"

awilliam@aleph:~> cat /etc/bluetooth/hcid.conf
device {
        iscan disable;
        pscan disable;

        name "Aleph";
        class 0x120100;
        lm accept;
        lp rswitch,hold,sniff,park;
        auth enable;
        encrypt disable;

}
options {
        security auto;
        passkey "000000";
        pairing multi;
        autoinit yes;
}


aleph:/home/awilliam # /usr/sbin/hciconfig -a hci0
hci0:   Type: USB
        BD Address: 00:02:72:C2:28:BA ACL MTU: 377:10 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN=20
        RX bytes:1377 acl:0 sco:0 events:45 errors:0
        TX bytes:458 acl:0 sco:0 commands:31 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
        Link policy: RSWITCH HOLD SNIFF PARK=20
        Link mode: SLAVE ACCEPT=20
        Name: 'Aleph'
        Class: 0x70010c
        Service Classes: Object Transfer, Audio, Telephony
        Device Class: Computer, Laptop
        HCI Ver: 1.2 (0x2) HCI Rev: 0x14 LMP Ver: 1.2 (0x2) LMP Subver:
0x309
        Manufacturer: Broadcom Corporation (15)

aleph:/home/awilliam # hcitool scan
Scanning ...
        00:07:E0:C2:C4:83       Scott Timmer
aleph:/home/awilliam # l2ping 00:07:E0:C2:C4:83
Ping: 00:07:E0:C2:C4:83 from 00:02:72:C2:28:BA (data size 44) ...
no response from 00:07:E0:C2:C4:83: id 0
0 bytes from 00:07:E0:C2:C4:83 id 1 time 19.97ms
0 bytes from 00:07:E0:C2:C4:83 id 2 time 30.44ms
0 bytes from 00:07:E0:C2:C4:83 id 3 time 30.41ms
0 bytes from 00:07:E0:C2:C4:83 id 4 time 133.39ms
0 bytes from 00:07:E0:C2:C4:83 id 5 time 29.35ms
0 bytes from 00:07:E0:C2:C4:83 id 6 time 24.34ms
0 bytes from 00:07:E0:C2:C4:83 id 7 time 25.30ms
0 bytes from 00:07:E0:C2:C4:83 id 8 time 28.29ms
0 bytes from 00:07:E0:C2:C4:83 id 9 time 42.27ms
0 bytes from 00:07:E0:C2:C4:83 id 10 time 17.24ms
0 bytes from 00:07:E0:C2:C4:83 id 11 time 24.21ms
0 bytes from 00:07:E0:C2:C4:83 id 12 time 27.17ms
0 bytes from 00:07:E0:C2:C4:83 id 13 time 31.15ms
0 bytes from 00:07:E0:C2:C4:83 id 14 time 26.12ms
0 bytes from 00:07:E0:C2:C4:83 id 15 time 25.09ms
0 bytes from 00:07:E0:C2:C4:83 id 16 time 26.07ms
0 bytes from 00:07:E0:C2:C4:83 id 17 time 12.06ms
18 sent, 17 received, 5% loss
aleph:/home/awilliam #=20

All I see in the log is "Jul 30 15:31:46 aleph hcid[10209]:
pin_code_request (sba=3D00:02:72:C2:28:BA, dba=3D00:07:E0:C2:C4:83)" when I
try to pair from the Palm.
--=20
Adam Tauno Williams, Systems & Network Administrator
Michigan Open Source Group - http://www.mosg.org
Whitemice Consulting - http://www.whitemiceconsulting.com

--=-Iwu5JQpV6wd6dQO0rh2z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGrj31LRePpNle04MRAtR7AJ9MnhLYLhncTZeFPFsURmWQxTgqtwCfbyHc
sCBsa34RftoxEdz/NpHc1HU=
=/XsO
-----END PGP SIGNATURE-----

--=-Iwu5JQpV6wd6dQO0rh2z--



--===============1298928373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1298928373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1298928373==--
