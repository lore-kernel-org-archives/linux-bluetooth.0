Return-Path: <cyrus@holtmann.org>
From: Dmitry Tunin <hanipouspilot@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Tunin <hanipouspilot@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ath3k: Add support of AR3012 0cf3:817b device
Date: Fri, 16 Oct 2015 11:45:26 +0300
Message-Id: <1444985126-4864-1-git-send-email-hanipouspilot@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

T: Bus=04 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#= 3 Spd=12 MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0cf3 ProdID=817b Rev=00.02
C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

BugLink: https://bugs.launchpad.net/bugs/1506615

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/ath3k.c | 2 ++
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index e527a3e..5515b5b 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -104,6 +104,7 @@ static const struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x0CF3, 0x311F) },
 	{ USB_DEVICE(0x0cf3, 0x3121) },
 	{ USB_DEVICE(0x0CF3, 0x817a) },
+	{ USB_DEVICE(0x0CF3, 0x817b) },
 	{ USB_DEVICE(0x0cf3, 0xe003) },
 	{ USB_DEVICE(0x0CF3, 0xE004) },
 	{ USB_DEVICE(0x0CF3, 0xE005) },
@@ -164,6 +165,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x0cf3, 0x311F), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0CF3, 0x817a), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0CF3, 0x817b), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe005), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe006), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 27830da..a884c5a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -206,6 +206,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0cf3, 0x311f), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3121), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x817a), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0x817b), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe003), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0xe005), .driver_info = BTUSB_ATH3012 },
-- 
1.9.1
