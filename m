Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412022343.07311.pavouk@pavouk.org>
Subject: [Bluez-users] bc2 vs bc2es firmware
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 2 Dec 2004 23:43:07 +0100

Hello,

I see USB dongle with Chip version: BlueCore02 (ES2).
What means ES2?

=46riend tried to flash firmware from manufacturer (rainsun), but it fails.
btdfu tells ""No such device".

This is in log:
=2D-----------------
Dec =A02 23:13:33 a /etc/hotplug/usb.agent: ... no modules for USB product=
=20
a12/ffff/209
Dec =A02 23:13:47 a kernel: usb 4-2: usbfs: USBDEVFS_CONTROL failed cmd btd=
fu=20
rqt 33 rq 1 len 1023 ret -32
Dec =A02 23:14:04 a kernel: usb 4-2: usbfs: USBDEVFS_CONTROL failed cmd btd=
fu=20
rqt 33 rq 1 len 1023 ret -110
Dec =A02 23:14:05 a kernel: usb 4-2: usbfs: USBDEVFS_CONTROL failed cmd btd=
fu=20
rqt 161 rq 3 len 6 ret -110
=2E..
Dec =A02 23:14:12 a /etc/hotplug/usb.agent: Setup bluetooth for USB product=
=20
a12/1/373
=2D-------------------

It's possible, that in DFU mode will be other ID?
a12/1/373 versus a12/ffff/209

Can be this dongle flashed with GENERIC firmware?

=2D-------------------------
root@a:~# hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:0A:84:00:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x=
175
        Manufacturer: Cambridge Silicon Radio (10)
root@a:~# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0A:84:00:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
        HCI 14.7
        Chip version: BlueCore02 (ES2)
        Max key size: 56 bit
        SCO mapping:  HCI
=2D--------------------------

Best regards,

Pavel Ruzicka


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
