Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 18 Nov 2006 15:12:06 -0800
From: Andres Vargas - zodman <zod@linuxmerida.org>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <20061118151206.68ea4a79@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] some error
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

on dmesg:

hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection A5:A5:00:5B:02:00
hci_acl_tx_to: hci0 ACL tx timeout
hci_acl_tx_to: hci0 killing stalled ACL connection A5:A5:00:5B:02:00
hci_cmd_task: hci0 command tx timeout
hci_cmd_task: hci0 command tx timeout
hci_cmd_task: hci0 command tx timeout
hci_cmd_task: hci0 command tx timeout
hci_cmd_task: hci0 command tx timeout

lagrutadelzod:/home/andy# hciconfig -a
hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN 
        RX bytes:1333 acl:16 sco:0 events:41 errors:0
        TX bytes:719 acl:21 sco:0 commands:28 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: 
        Link mode: SLAVE ACCEPT 
Can't read local name on hci0: Connection timed out (110)



why succes this ???

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
