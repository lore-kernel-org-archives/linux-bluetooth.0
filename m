Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ulrich Wisser <u.wisser@publisher.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1091568946.3759.18.camel@dorette.Entenhausen>
Mime-Version: 1.0
Subject: [Bluez-users] SuSE 9.1 Pro and Epox Barton wireless desktop
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
Date: Tue, 03 Aug 2004 23:35:47 +0200

Hello,

has anybody got that combination running?
When I plug in my BT-DG03BF USB bluetooth dongle "hcitool dev" does not
show any device. Please find the /var/log/messages below.

Any idea how to get the dongle working? The keyboard and mouse?

TIA

Ulrich


Jul 31 10:34:38 dorette kernel: usb 1-1: new full speed USB device using
address                 3
Jul 31 10:34:38 dorette /etc/hotplug/usb.agent[3868]: need a device for
this com                mand
Jul 31 10:34:38 dorette kernel: input: USB HID v1.11 Keyboard
[0a12:1000] on usb                -0000:00:07.2-1
Jul 31 10:34:39 dorette kernel: drivers/usb/input/hid-core.c: ctrl urb
status -3                2 received
Jul 31 10:34:39 dorette /etc/hotplug/usb.agent[3889]: need a device for
this com                mand
Jul 31 10:34:39 dorette kernel: input: USB HID v1.11 Mouse [0a12:1000]
on usb-00                00:00:07.2-1




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
