Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Alexander Ploumistos <alex.ploumistos@gmail.com>
Date: Tue, 10 Feb 2015 17:54:43 +0200
Message-ID: <CAM86y2vc-EUswU+D6EeEAeKQWDVuDVGOvpLTgKjB-R4VzxyshA@mail.gmail.com>
Subject: [PATCH] Add support for Atheros AR5B195 combo Mini PCIe cards (AR3011 Bluetooth)
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: jwboyer@redhat.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

The AR5B195 Mini PCIe card is made up by an AR9285 Wi-Fi chip and an
AR3011 Bluetooth chip. The operating procedure of the device, as well
as the rationale behind the patch is documented in
https://wireless.wiki.kernel.org/en/users/Drivers/ath3k#ar3011_with_sflash_configurations

The bluetooth device is exposed to the host as a generic USB device
(04f2:aff1 Chicony Electronics Co., Ltd, in this case) and requires
firmware to be uploaded to it, so that it can be re-enumerated as an
AR3011 device. This translates to adding the Vendor and Product IDs to
the btusb.c blacklist and to the ath3k.c list of supported devices.

I made the patch against the source of kernel-3.18.6-200, currently in
Fedora updates-testing and I've also tested it with a couple of 3.18.5
kernels.

Some more info and external references can be found in RHBZ:
https://bugzilla.redhat.com/show_bug.cgi?id=1190947

Signed-off-by: Alexander Ploumistos <alexpl@fedoraproject.org>

---

diff -rupN a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
--- a/drivers/bluetooth/ath3k.c    2014-12-08 00:21:05.000000000 +0200
+++ b/drivers/bluetooth/ath3k.c    2015-02-10 05:48:26.202889885 +0200
@@ -65,6 +65,7 @@ static const struct usb_device_id ath3k_
     /* Atheros AR3011 with sflash firmware*/
     { USB_DEVICE(0x0489, 0xE027) },
     { USB_DEVICE(0x0489, 0xE03D) },
+    { USB_DEVICE(0x04F2, 0xAFF1) },
     { USB_DEVICE(0x0930, 0x0215) },
     { USB_DEVICE(0x0CF3, 0x3002) },
     { USB_DEVICE(0x0CF3, 0xE019) },
diff -rupN a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
--- a/drivers/bluetooth/btusb.c    2014-12-08 00:21:05.000000000 +0200
+++ b/drivers/bluetooth/btusb.c    2015-02-10 05:49:38.590890251 +0200
@@ -142,6 +142,7 @@ static const struct usb_device_id blackl
     /* Atheros 3011 with sflash firmware */
     { USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
     { USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
+    { USB_DEVICE(0x04f2, 0xaff1), .driver_info = BTUSB_IGNORE },
     { USB_DEVICE(0x0930, 0x0215), .driver_info = BTUSB_IGNORE },
     { USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
     { USB_DEVICE(0x0cf3, 0xe019), .driver_info = BTUSB_IGNORE },
