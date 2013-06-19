Return-Path: <cyrus@holtmann.org>
From: Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Anthony Wong <anthony.wong@canonical.com>,
	Adam Lee <adam.lee@canonical.com>,
	Wen-chien Jesse Sung <jesse.sung@canonical.com>
Subject: [PATCH 4/5] Bluetooth: Add support for 105b:e065
Date: Wed, 19 Jun 2013 23:28:37 +0800
Message-Id: <1371655718-1753-4-git-send-email-jesse.sung@canonical.com>
In-Reply-To: <1371655718-1753-1-git-send-email-jesse.sung@canonical.com>
References: <1371655718-1753-1-git-send-email-jesse.sung@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Adam Lee <adam.lee@canonical.com>

BugLink: https://launchpad.net/bugs/1161261

These devices require external patchram firmware to work.

T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  9 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=105b ProdID=e065 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM43142A0
S:  SerialNumber=0090A295B4C6
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Adam Lee <adam.lee@canonical.com>
Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a6adbfe..96dec55 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -109,6 +109,7 @@ static struct usb_device_id btusb_table[] = {
 
 	/* Broadcom BCM43142A0 */
 	{ USB_DEVICE(0x04ca, 0x2007), .driver_info = BTUSB_BCM_PATCHRAM },
+	{ USB_DEVICE(0x105b, 0xe065), .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01), .driver_info = BTUSB_BCM_PATCHRAM },
-- 
1.8.1.2
