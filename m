Return-Path: <hanipouspilot@gmail.com>
From: Dmitry Tunin <hanipouspilot@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Tunin <hanipouspilot@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: Add a new AR3012 ID 04ca:3014
Date: Sun, 28 Feb 2016 11:04:06 +0300
Message-Id: <1456646646-4099-1-git-send-email-hanipouspilot@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

T: Bus=01 Lev=01 Prnt=01 Port=04 Cnt=03 Dev#= 5 Spd=12 MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=04ca ProdID=3014 Rev=00.02
C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

BugLink: https://bugs.launchpad.net/bugs/1546694

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/ath3k.c | 2 ++
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index e2ccf90..9374738 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -93,6 +93,7 @@ static const struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x04CA, 0x300d) },
 	{ USB_DEVICE(0x04CA, 0x300f) },
 	{ USB_DEVICE(0x04CA, 0x3010) },
+	{ USB_DEVICE(0x04CA, 0x3014) },
 	{ USB_DEVICE(0x0930, 0x0219) },
 	{ USB_DEVICE(0x0930, 0x021c) },
 	{ USB_DEVICE(0x0930, 0x0220) },
@@ -157,6 +158,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x04ca, 0x300d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x300f), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3010), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x3014), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x021c), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 55fbdfc..97f3bba 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -207,6 +207,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x04ca, 0x300d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x300f), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3010), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x3014), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x021c), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
-- 
1.9.1
