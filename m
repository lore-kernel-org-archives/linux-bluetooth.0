Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040723020716.88264.qmail@web40806.mail.yahoo.com>
From: Scott Mace <scottymace@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] New Device that works
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 22 Jul 2004 19:07:16 -0700 (PDT)

I didn't see this on your list of working hardware. 
It's a USB bluetooth dongle branded CompUSA.  It sells
for around $30  Anyway, here are the outputs:
hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:60:A4:CB:33 ACL MTU: 192:8 
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:282820 acl:1988 sco:4638 events:1935
errors:0
        TX bytes:538062 acl:2788 sco:4295 commands:98
errors:0
        Features: 0xff 0xff 0x0f 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Bluez (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1
(0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:60:A4:CB:33 ACL MTU: 192:8 
SCO MTU: 64:8
        HCI 16.4 (bc02x)


It worked with no fiddling in Gentoo using
kbluetoothd.
Scott


	
		
__________________________________
Do you Yahoo!?
Vote for the stars of Yahoo!'s next ad campaign!
http://advision.webevents.yahoo.com/yahoo/votelifeengine/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
