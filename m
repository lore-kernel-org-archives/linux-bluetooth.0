Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 03 Jun 2007 16:44:43 +0200
Message-Id: <1826221353@web.de>
MIME-Version: 1.0
From: 01flipstar@web.de
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] bluez-utils on old kernel
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

Hello everybody,

I'm trying to add bluetooth support to my arm based NAS which runs on
a 2.6.10 Kernel.

I compiled the bluez-libs and utils (3.11) but hcitool dev won't
show any devices and when I exec hciconfig I get

icybox / # /system/overlay/apps/bluez-utils/sbin/hciconfig
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN INIT RUNNING
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

so I think the device is somehow active but I can't nether reset nor
do anything usefull with the bw-dongel.

I then tried to apply the latest kernelpatch to the 2.6.10 kernel
which gives lots of errors

bash-2.05b# patch -p1 < patches/patch-2.6.21-mh1
patching file drivers/bluetooth/hci_ldisc.c
Hunk #1 succeeded at 306 (offset -1 lines).
Hunk #2 FAILED at 474.
1 out of 2 hunks FAILED -- saving rejects to file
drivers/bluetooth/hci_ldisc.c.rej
patching file drivers/bluetooth/hci_uart.h
Hunk #1 succeeded at 31 (offset 3 lines).
patching file drivers/bluetooth/hci_usb.c
Hunk #1 FAILED at 114.
Hunk #2 FAILED at 148.
2 out of 2 hunks FAILED -- saving rejects to file
drivers/bluetooth/hci_usb.c.rej
patching file include/net/bluetooth/l2cap.h
Hunk #1 succeeded at 141 (offset 12 lines).
Hunk #2 succeeded at 215 with fuzz 1 (offset -2 lines).
patching file Makefile
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file Makefile.rej
patching file net/bluetooth/hci_conn.c
Hunk #1 succeeded at 73 (offset 1 line).
Hunk #2 succeeded at 93 with fuzz 2 (offset -14 lines).
Hunk #4 succeeded at 306 (offset -42 lines).
Hunk #5 FAILED at 326.
Hunk #7 FAILED at 423.
Hunk #8 FAILED at 452.
3 out of 8 hunks FAILED -- saving rejects to file
net/bluetooth/hci_conn.c.rej
patching file net/bluetooth/hci_core.c
Hunk #1 succeeded at 203 (offset -13 lines).
Hunk #3 FAILED at 853.
Hunk #4 succeeded at 1006 (offset -28 lines).
Hunk #5 succeeded at 1061 (offset 1 line).
Hunk #6 succeeded at 1047 (offset -28 lines).
Hunk #7 succeeded at 1141 (offset 1 line).
1 out of 7 hunks FAILED -- saving rejects to file
net/bluetooth/hci_core.c.rej
patching file net/bluetooth/hci_event.c
Hunk #1 FAILED at 783.
Hunk #2 FAILED at 793.
.
.
.

My question is: is it possoble to upgrade the kernel (bluetooth) step by
step because a jump from 2.6.10 to 2.6.21 is quite big i guess.
Or do i make something else wrong?

Thanks for your help.

bye
Philipp

_______________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=021192


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
