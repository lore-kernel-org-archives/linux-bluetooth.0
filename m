Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <456487C5.3070502@gmail.com>
Date: Wed, 22 Nov 2006 17:24:21 +0000
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
From: Simon Williams <systemparadox@googlemail.com>
Subject: [Bluez-users] Can't init device hci0: Connection timed out (110)
Reply-To: systemparadox@gmail.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

Hello again. I've finally managed to get the device (my 3Com 3CRWB6096 
Version 2.0 PCMCIA Card) to show up in hciconfig (I had the wrong firmware).

Dbus is running, all the bluetooth services are running.
But I get the following...

# hciconfig
hci0:   Type: PCCARD
         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
         DOWN INIT RUNNING
         RX bytes:0 acl:0 sco:0 events:0 errors:0
         TX bytes:4 acl:0 sco:0 commands:1 errors:0

# hciconfig hci0 up
Can't init device hci0: Connection timed out (110)
# hciconfig
hci0:   Type: PCCARD
         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
         DOWN
         RX bytes:0 acl:0 sco:0 events:0 errors:0
         TX bytes:4 acl:0 sco:0 commands:2 errors:0

Is there some way I can manually probe the card for it's address to find 
out if it's bluez or the driver?
Shouldn't it have an address even when it's down?

Please, any other suggestions very much appreciated.
Thanks in advance
Simon

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
