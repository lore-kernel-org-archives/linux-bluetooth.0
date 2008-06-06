Return-Path: <cyrus@holtmann.org>
Message-ID: <48491A97.1080508@email.it>
Date: Fri, 06 Jun 2008 13:08:07 +0200
From: Pietro Battiston <toobaz@email.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Problem with hamlet exagerate adapter
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have problems with a Hamlet USB-bluetooth dongle.

It is correctly recognized (I run a 64 bit Ubuntu Hardy) and I was able
to connect to two different cellular phones, and send pictures from pc
to phone and vice versa. However, it sometimes stops working. I
conjectured this is a problem with the reception of large amounts of
data, but I'm not sure.

For example, when I tried to sync my Nokia phone (using multisync), the
syncml-obex-client always gave an error, but sometimes it did
immediately, other times it started transferring and then stopped.
Similarly, when I try to explore the content of the phones, it starts
ok, I can even see the folders, then after a while it stops
(particularly often if I try to copy some files on the PC; in that case
nautilus also gets stuck to 100% of CPU). Often, when it stops, I'm not
even able no more to just send pictures, and I have to unplug the dongle
(/etc/init.d/bluetooth restart seems not being enough).

Here's the output of "hciconfig hci0 version":
hci0:    Type: USB
    BD Address: 00:10:60:D1:64:C2 ACL MTU: 384:8 SCO MTU: 64:8
    HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver: 0x7a6
    Manufacturer: Cambridge Silicon Radio (10)

If there is any other useful data that I can collect, I'd be glad to
help. I have absolutely no idea of how to debug a bluetooth connection,
and dmesg shows nothing interesting.

Pietro Battiston

(P.S: is this the right mailing list to send bugs to or should I write
to "developers"?)

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
