Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 18 Jul 2006 16:13:57 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060718141357.GO10190@suse.de>
Mime-Version: 1.0
Subject: [Bluez-devel] Belkin F8T013 needs SCO MTU fix.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi all,

It looks like the Belkin F8T013 needs the SCO MTU fix from
http://bluetooth-alsa.sourceforge.net/sco-mtu.patch like the F8T012 does.
With the patch, i can use btsco to record and play back from a Belkin
F8T060xHDST just fine.

Details:

lsusb:
Bus 001 Device 003: ID 050d:0013 Belkin Components

root@strolchi:~# hciconfig -a
hci1:   Type: USB
        BD Address: 00:0A:3A:67:58:A1 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:661 acl:0 sco:0 events:20 errors:0
        TX bytes:328 acl:0 sco:0 commands:20 errors:0
        Features: 0xff 0xfb 0x8d 0xfe 0x9f 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (none) (1)'
        Class: 0x100100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2073 LMP Ver: 2.0 (0x3) LMP Subver: 0=
x410e
        Manufacturer: Broadcom Corporation (15)

-- =

Stefan Seyfried                     | "Please, just tell people
QA / R&D Team Mobile Devices        |               to use KDE."
SUSE LINUX Products GmbH, N=FCrnberg  |          -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
