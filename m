Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Rodrigo Serra" <rmserra@fibertel.com.ar>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-Id: <S1212517AbUKJXaC/20041110233010Z+222887@avas-mr07.fibertel.com.ar>
Subject: [Bluez-users] Zaurus SL6000L + CF+ Personal Network Card Rev 2.5 Rev H
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Nov 2004 20:30:00 -0300

Hello

I have a problem to configure bluez on my SL6000L with Socket Bluetooth card
Rev H.
I downloaded and install from http://bluez.sourceforge.net/download/zaurus/
the following packages:

bluez-kernel-2.4.18-mh15_arm.ipk 
bluez-libs_2.10_arm.ipk
bluez-utils_2.10_arm.ipk

When i try to run: hciattach /dev/ttyS3 socket 230400 the following error is
occurred:

Can't set device: Protocol not supported
Can't initialize device: Protocol not supported

Somebody know what happen? Please help me.

SL6000L ROM Version 1.12, USA.
CODE on card back: 8510-00159H

Output of cardctl status command:
Socket 0:
  3.3V 16-bit PC Card
  function 0: [ready]

Output of card ident command:
Socket 0:
  product info: "Socket", "CF+ Personal Network Card Rev 2.5"
  manfid: 0x0104, 0x0096
  function: 2 (serial)

Output of lsmod command:
Module                  Size  Used by
hci_uart                3760   0 
rfcomm                 33664   0 
l2cap                  16352   2  [rfcomm]
bluez                  32896   1  [hci_uart rfcomm l2cap]
pxa_bi                 21728   0  (unused)
net_fd                 25024   1 
usbdcore               34544   0  [pxa_bi net_fd]
usbdmonitor             5248   0 
sharp_mmcsd_m          31520   2 
vtty                    7920   0  (unused)
usb_ohci_tc6393        24544   0  (unused)
usbcore                52048   1  [usb_ohci_tc6393]



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
