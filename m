Return-Path: <cyrus@holtmann.org>
From: Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Anthony Wong <anthony.wong@canonical.com>,
	Gavin Guo <gavin.guo@canonical.com>,
	Wen-chien Jesse Sung <jesse.sung@canonical.com>
Subject: [PATCH 5/5] Bluetooth: Add support for Broadcom 413c:8143
Date: Wed, 19 Jun 2013 23:28:38 +0800
Message-Id: <1371655718-1753-5-git-send-email-jesse.sung@canonical.com>
In-Reply-To: <1371655718-1753-1-git-send-email-jesse.sung@canonical.com>
References: <1371655718-1753-1-git-send-email-jesse.sung@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gavin Guo <gavin.guo@canonical.com>

The device require external patchram firmware to work and need to
add corresponding id in the btusb.c.

T:  Bus=03 Lev=01 Prnt=01 Port=08 Cnt=03 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8143 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=20689D1FAF94
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

BugLink: http://bugs.launchpad.net/bugs/1166113

Signed-off-by: Gavin Guo <gavin.guo@canonical.com>
Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 96dec55..9df87ca 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -106,6 +106,7 @@ static struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3388), .driver_info = BTUSB_BCM_PATCHRAM },
 	{ USB_DEVICE(0x13d3, 0x3389), .driver_info = BTUSB_BCM_PATCHRAM },
 	{ USB_DEVICE(0x413c, 0x8197), .driver_info = BTUSB_BCM_PATCHRAM },
+	{ USB_DEVICE(0x413c, 0x8143), .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Broadcom BCM43142A0 */
 	{ USB_DEVICE(0x04ca, 0x2007), .driver_info = BTUSB_BCM_PATCHRAM },
-- 
1.8.1.2
