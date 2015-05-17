Return-Path: <cyrus@holtmann.org>
From: Dmitry Tunin <hanipouspilot@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Tunin <hanipouspilot@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] ath3k: add support of 13d3:3474 AR3012 device
Date: Sun, 17 May 2015 17:24:04 +0300
Message-Id: <1431872644-9452-1-git-send-email-hanipouspilot@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BugLink: https://bugs.launchpad.net/bugs/1427680

T: Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#= 4 Spd=12 MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=13d3 ProdID=3474 Rev=00.01
C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/ath3k.c | 2 ++
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 288547a..29f34c7 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -111,6 +111,7 @@ static const struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3408) },
 	{ USB_DEVICE(0x13d3, 0x3423) },
 	{ USB_DEVICE(0x13d3, 0x3432) },
+	{ USB_DEVICE(0x13d3, 0x3474) },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE02C) },
@@ -166,6 +167,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x13d3, 0x3408), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3423), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3432), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3474), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU22 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE036), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b9f2821..4103a8b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -210,6 +210,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3408), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3423), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3432), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3474), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
-- 
1.9.1

