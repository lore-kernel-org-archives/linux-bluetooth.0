Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Broadcom Corporation (Firmware 105.105.074) USB
	dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Hans Bausewein <hans@comerwell.xs4all.nl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041030094327.GA8724@comerwell.xs4all.nl>
References: <20041030094327.GA8724@comerwell.xs4all.nl>
Content-Type: multipart/mixed; boundary="=-eWxXt17Mh2asurursNGX"
Message-Id: <1099136877.6912.41.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 30 Oct 2004 13:47:57 +0200


--=-eWxXt17Mh2asurursNGX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Hans,

> My new USB dongle (MyCom label, but it's a Broadcom) does not work with
> Linux Debian (unstable) kernel 2.4.27 or 2.6.8 and bluez-utils 2.10-1
> (Debian package). It loads, but scanning does not work.
> 
> p2:~# hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:02:72:C0:11:1C ACL MTU: 377:10  SCO MTU: 16:0
>         UP RUNNING 
>         RX bytes:163 acl:0 sco:0 events:21 errors:0  
>         TX bytes:583 acl:0 sco:0 commands:21 errors:0
>         Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT 
> Can't read local name on hci0. Input/output error(5)
> 
> 
> p2:~# hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:02:72:C0:11:1C ACL MTU: 377:10  SCO MTU: 16:0
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x69 LMP Ver: 1.2 (0x2) LMP Subver:
> 0x694a
>         Manufacturer: Broadcom Corporation (15)
> 
> p2:~# hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:02:72:C0:11:1C ACL MTU: 377:10  SCO MTU: 16:0
>         Firmware 105.105.074
> 
> p2:~# lsusb
> Bus 001 Device 009: ID 0a5c:3503 Broadcom Corp.
> Bus 001 Device 008: ID 0a5c:3502 Broadcom Corp.
> Bus 001 Device 007: ID 0a5c:2009 Broadcom Corp.
> Bus 001 Device 006: ID 0a5c:3535 Broadcom Corp.
> Bus 001 Device 001: ID 0000:0000

please send us the content of /proc/bus/usb/devices and you can try the
attached patch.

> Or should I better swap the device for a (more expensive) MSI ?

The CSR based dongles actually make less problems. If you don't need it
anymore, you can donate it to me, because I really need these kind of
dongles for testing.

Regards

Marcel


--=-eWxXt17Mh2asurursNGX
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/hci_usb.c 1.58 vs edited =====
--- 1.58/drivers/bluetooth/hci_usb.c	2004-10-27 23:42:21 +02:00
+++ edited/drivers/bluetooth/hci_usb.c	2004-10-30 13:42:04 +02:00
@@ -101,8 +101,12 @@
 	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = HCI_IGNORE },
 
 	/* Broadcom BCM2035 */
+	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
 
+	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
+	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET | HCI_BROKEN_ISOC },
+
 	/* ISSC Bluetooth Adapter v3.1 */
 	{ USB_DEVICE(0x1131, 0x1001), .driver_info = HCI_RESET },
 

--=-eWxXt17Mh2asurursNGX--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
