Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Joonas =?ISO-8859-1?Q?H=E4m=E4l=E4inen?= <kerberos@mbnet.fi>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1064703452.10689.38.camel@Aielien>
Mime-Version: 1.0
Subject: [Bluez-users] Bluefw problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 28 Sep 2003 01:57:33 +0300

Hello everyone.

I have problem to get my usb dongle to work in my computers. I have two
computers, one on Slackware 9.0 and another on Mandrake 9.0 (comp has
also WinME.) Did rpm install to mdk, and sources to slack, but results
are similar. Everything works just fine, by faq/helps, but when I should
actually start use that dongle, things go wrong.

I have Allnet bluetooth dongle, not sure what else I could tell about
it, or how to get that info... uses some broadcom software, at least
what windows shows. If I do hciconfig or hciconfig hci0 up I don't get
any reply to first one, and to second one tells that no such device. If
I first boot into WinME and then reboot comp to mdk, it works just
fine... so something is missing, but what, and where?

There is piece of syslog of my slackware, if it gives any idea to anyone
what goes wrong...


Sep 27 17:53:34 Armada kernel: BlueZ Core ver 2.2 Copyright (C)
2000,2001 Qualcomm Inc
Sep 27 17:53:34 Armada kernel: Written 2000,2001 by Maxim Krasnyansky
<maxk@qualcomm.com>
Sep 27 17:53:34 Armada insmod: Note: /etc/modules.conf is more recent
than /lib/modules/2.4.20/modules.dep
Sep 27 17:59:03 Armada kernel: hub.c: new USB device 00:04.2-1, assigned
address 2
Sep 27 17:59:06 Armada /etc/hotplug/usb.agent: Setup bluetooth hci_usb
for USB product a5c/2033/a0
Sep 27 17:59:06 Armada modprobe: Note: /etc/modules.conf is more recent
than /lib/modules/2.4.20/modules.dep
Sep 27 17:59:06 Armada kernel: bluetooth.c: USB Bluetooth support
registered
Sep 27 17:59:06 Armada kernel: usb.c: registered new driver bluetty
Sep 27 17:59:06 Armada kernel: bluetooth.c: USB Bluetooth converter
detected
Sep 27 17:59:06 Armada kernel: bluetooth.c: Bluetooth converter now
attached to ttyUB0 (or usb/ttub/0 for devfs)
Sep 27 17:59:06 Armada kernel: bluetooth.c: USB Bluetooth tty driver
v0.13
Sep 27 17:59:06 Armada insmod: Note: /etc/modules.conf is more recent
than /lib/modules/2.4.20/modules.dep
Sep 27 17:59:06 Armada modprobe: Note: /etc/modules.conf is more recent
than /lib/modules/2.4.20/modules.dep
Sep 27 17:59:06 Armada kernel: BlueZ HCI USB driver ver 2.1 Copyright
(C) 2000,2001 Qualcomm Inc
Sep 27 17:59:06 Armada kernel: Written 2000,2001 by Maxim Krasnyansky
<maxk@qualcomm.com>
Sep 27 17:59:06 Armada kernel: usb.c: registered new driver hci_usb
Sep 27 17:59:06 Armada insmod: Note: /etc/modules.conf is more recent
than /lib/modules/2.4.20/modules.dep
Sep 27 17:59:06 Armada /etc/hotplug/usb.agent: Setup bluefw for USB
product a5c/2033/a0
Sep 27 17:59:06 Armada /etc/hotplug/usb.agent: Module setup bluefw for
USB product a5c/2033/a0
Sep 27 17:59:06 Armada bluefw[12263]: Loading firmware to usb device
0a5c:2033
Sep 27 18:01:08 Armada hcid[12276]: HCI daemon ver 2.3 started
Sep 27 18:03:54 Armada kernel: usb.c: USB disconnect on device 00:04.2-1
address 2
Sep 27 18:03:54 Armada kernel: bluetooth.c: Bluetooth converter now
disconnected from ttyUB0
Sep 27 18:04:16 Armada kernel: hub.c: new USB device 00:04.2-2, assigned
address 3
Sep 27 18:04:16 Armada kernel: bluetooth.c: USB Bluetooth converter
detected
Sep 27 18:04:16 Armada kernel: bluetooth.c: Bluetooth converter now
attached to ttyUB0 (or usb/ttub/0 for devfs)
Sep 27 18:04:19 Armada /etc/hotplug/usb.agent: Setup bluetooth hci_usb
for USB product a5c/2033/a0
Sep 27 18:04:19 Armada /etc/hotplug/usb.agent: Setup bluefw for USB
product a5c/2033/a0
Sep 27 18:04:19 Armada /etc/hotplug/usb.agent: Module setup bluefw for
USB product a5c/2033/a0
Sep 27 18:04:19 Armada bluefw[12342]: Loading firmware to usb device
0a5c:2033
Sep 27 18:05:33 Armada kernel: usb.c: USB disconnect on device 00:04.2-2
address 3
Sep 27 18:05:33 Armada kernel: bluetooth.c: Bluetooth converter now
disconnected from ttyUB0


Hoping your aid,
Joonas H=E4m=E4l=E4inen



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
