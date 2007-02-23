Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-F34E1C6DE97697902591ADBF8E0@phx.gbl>
From: "Kelvin Xu" <kyoxu@hotmail.com>
To: bluez-users@lists.sourceforge.net
Date: Fri, 23 Feb 2007 17:01:56 +0800
Mime-Version: 1.0
Subject: [Bluez-users] Bluez config on ARM
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


Dear all,

I am currently running Bluez on a ARM board. The hciconfig does not seems to 
be reading from the hcid.conf file. How do i current this?

Below is the output of my hciconfig -a

hci0:   Type: USB
        BD Address: 00:15:E9:7B:A0:B9 ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:702 acl:0 sco:0 events:23 errors:0
        TX bytes:83 acl:0 sco:0 commands:23 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2035'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x2788 LMP Ver: 1.2 (0x2) LMP Subver: 
0x309
        Manufacturer: Broadcom Corporation (15)

Regards,
Kelvin

_________________________________________________________________
Get an advanced look at the new version of Windows Live Messenger. 
http://get.live.com/messenger/overview


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
