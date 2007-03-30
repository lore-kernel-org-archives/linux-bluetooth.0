Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Malte Steiner <steiner@mobileart.org>
To: bluez-users@lists.sourceforge.net
Date: Fri, 30 Mar 2007 15:19:54 +0200
Message-Id: <1175260794.6213.18.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] belkin dongle trouble
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

Hello,

I usually got good results with Bluez and Belkin Class 1 Dongles but I
got a new ones which seems to confuse the system, when plugged following
is logged:

Mar 30 15:04:52 localhost kernel: ohci_hcd 0000:00:03.0: wakeup
Mar 30 15:04:52 localhost kernel: usb 1-1: new full speed USB device
using ohci_hcd and address 6
Mar 30 15:04:53 localhost kernel: usb 1-1: configuration #1 chosen from
1 choice
Mar 30 15:04:53 localhost kernel: pegasus: v0.6.13 (2005/11/13),
Pegasus/Pegasus II USB Ethernet driver


So the new Belkins lies and pretend to be another device? Of course
Bluez cant see a bluetooth device and the computer even has to restarted
to recognize further USB devices connecting properly.
While shutting down the computers usually hangs after the plugging with
the new dongles at

Stopping bluetooth: rfcomm

good Belkins are the model

F8T012

the bad ones are called 

F8T012xx1

Any advices?

Cheers and thanks in advance,

Malte


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
