Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Alastair Tse <liquidx@gentoo.org>
To: bluez-users@lists.sourceforge.net
Date: Fri, 28 Jul 2006 00:18:19 +0100
Message-Id: <1154042299.16913.6.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a	Belkin dongle in Debian
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I'm also experiencing the same behaviour as Felix with a Belkin dongle
(Broadcom) with bluez-libs-3.2, bluez-utils-3.2. This is where ISCAN is
not set even though it is enabled in hcid.conf. I've compiled from
source on a Gentoo Linux box.

One additional thing that I would like to add is that I see this in my
syslog:

Jul 28 00:10:15 qoo hcid[23009]: HCI dev 0 registered
Jul 28 00:10:15 qoo hcid[23009]: Device hci0 has been added
Jul 28 00:10:15 qoo hcid[23009]: Register path:/org/bluez/hci0
fallback:0
Jul 28 00:10:15 qoo hcid[23009]: HCI dev 0 up
Jul 28 00:10:15 qoo hcid[23009]: Starting security manager 0
Jul 28 00:10:16 qoo hcid[23009]: Can't write inquiry mode for hci0:
Connection timed out (110)

If I use Felix's workaround by enabling ISCAN using 'hciconfig hci0
piscan' after the device is up, that error message about inquiry mode
does not come up.

Here is my hciconfig -a before using the workaround 'hciconfig hci0
piscan':

liquidx@qoo /usr/portage $ hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:C9:2D:3E:8F ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN
        RX bytes:408 acl:0 sco:0 events:18 errors:0
        TX bytes:320 acl:0 sco:0 commands:18 errors:0
        Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'qoo'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2 LMP Ver: 1.1 (0x1) LMP Subver:
0x1007
        Manufacturer: Broadcom Corporation (15)


Hope this helps with nailing down the problem.

Cheers,

Alastair


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
