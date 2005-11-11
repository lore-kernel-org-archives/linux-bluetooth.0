Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <EFCD68F7BFDB06468769D4D9EAAA938709664693@scsmsx401.amr.corp.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] sniff mode
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
Date: Fri, 11 Nov 2005 11:03:07 -0800

Hello, I'm trying to get sniff mode working between two devices.  My
understanding is that this is not directly supported by bluez
(http://mhonarc.axis.se/bluetooth-dev/msg03437.html), so I'm trying to
send the relevant HCI commands directly -- but I can't seem to get it to
work. A quick trace of all the information is below...  basically, it
seems to send the command ok, but it just comes back with an error
(which I think I have translated to just "HCI parameter error").  Any
thoughts on what might be going wrong? =20

Cheers,
	Trevor


stargate93:/root/ # hcitool con
Connections:
        < ACL 00:04:3E:01:83:C2 handle 7 state 1 lm MASTER=20
stargate93:/root/ # cat sniff
hcitool cmd 0x02 0x0003 0x00 0x07 0x02 0x02 0x01 0x01 0x01 0x02 0x03
0x04
stargate93:/root/ # ./sniff
< HCI Command: ogf 0x02, ocf 0x0003, plen 10
  00 07 02 02 01 01 01 02 03 04=20
> HCI Event: 0x0f plen 4
  11 01 03 08=20
stargate93:/root/ # hciconfig -a
hci0:   Type: USB
        BD Address: AE:2D:00:23:01:96 ACL MTU: 120:20 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN=20
        RX bytes:4671 acl:70 sco:0 events:202 errors:0
        TX bytes:2772 acl:70 sco:0 commands:84 errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
        Link policy: SNIFF=20
        Link mode: SLAVE ACCEPT=20
        Name: 'stargate-93@192.168.76.93'
        Class: 0x820108
        Service Classes: Networking
        Device Class: Computer, Server
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver:
0x757
        Manufacturer: Silicon Wave (11)
=20


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
