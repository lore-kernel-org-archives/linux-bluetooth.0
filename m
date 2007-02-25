Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 24 Feb 2007 23:26:53 -0800 (PST)
From: tim culwins <mail0123456789101112@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <634191.19416.qm@web31701.mail.mud.yahoo.com>
Subject: [Bluez-users] tryig to get bluetooth keyboad to work
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

i have a think outside keyboard for pdas that im
trying to use on ubuntu. it can connect and auto
reconnect most of the time. but sometimes when i hit a
key to auto reconnect the light on my dongle stops
flashing and bluetooth stops working. If i unplug and
replug the dongle it starts working again. 
i dont have this problem with my bluetooth mouse. 

any ideas?

heres my hciconfig

hci0:   Type: USB
        BD Address: 00:11:67:4F:EE:F9 ACL MTU: 678:8
SCO MTU: 64:10
        UP RUNNING PSCAN ISCAN 
        RX bytes:4879 acl:194 sco:0 events:67 errors:0
        TX bytes:756 acl:19 sco:0 commands:34 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'ISSCBTA'
        Class: 0x3e0100
        Service Classes: Networking, Rendering,
Capturing, Object Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2
(0x2) LMP Subver: 0x1fe
        Manufacturer: Integrated System Solution Corp.
(57)



 
____________________________________________________________________________________
Sucker-punch spam with award-winning protection. 
Try the free Yahoo! Mail Beta.
http://advision.webevents.yahoo.com/mailbeta/features_spam.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
