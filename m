Return-Path: <cyrus@holtmann.org>
From: Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Anthony Wong <anthony.wong@canonical.com>,
	Wen-chien Jesse Sung <jesse.sung@canonical.com>
Subject: [PATCH 2/5] Bluetooth: Add support for 13d3:3388 and 13d3:3389
Date: Wed, 19 Jun 2013 23:28:35 +0800
Message-Id: <1371655718-1753-2-git-send-email-jesse.sung@canonical.com>
In-Reply-To: <1371655718-1753-1-git-send-email-jesse.sung@canonical.com>
References: <1371655718-1753-1-git-send-email-jesse.sung@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wen-chien Jesse Sung <jesse.sung@canonical.com>

BugLink: https://launchpad.net/bugs/1065400

These devices require external patchram firmware to work.

T: Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#= 3 Spd=12 MxCh= 0
D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=13d3 ProdID=3388 Rev=01.12
S: Manufacturer=Broadcom Corp
S: Product=BCM43142A0
S: SerialNumber=DC85DE2C85A6
C: #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I: If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I: If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8cab88c..0532304 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -103,6 +103,8 @@ static struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x0b05, 0x17b5) },
 	{ USB_DEVICE(0x04ca, 0x2003) },
 	{ USB_DEVICE(0x0489, 0xe042) },
+	{ USB_DEVICE(0x13d3, 0x3388), .driver_info = BTUSB_BCM_PATCHRAM },
+	{ USB_DEVICE(0x13d3, 0x3389), .driver_info = BTUSB_BCM_PATCHRAM },
 	{ USB_DEVICE(0x413c, 0x8197), .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Foxconn - Hon Hai */
-- 
1.8.1.2
