Return-Path: <hanipouspilot@gmail.com>
From: Dmitry Tunin <hanipouspilot@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Tunin <hanipouspilot@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add a new AR3012 ID 13d3:3472
Date: Fri,  4 Mar 2016 01:32:19 +0300
Message-Id: <1457044339-2447-1-git-send-email-hanipouspilot@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

T: Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#= 4 Spd=12 MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=13d3 ProdID=3472 Rev=00.01
C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

BugLink: https://bugs.launchpad.net/bugs/1552925

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/ath3k.c | 2 ++
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 9374738..47ca4b3 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -120,6 +120,7 @@ static const struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3408) },
 	{ USB_DEVICE(0x13d3, 0x3423) },
 	{ USB_DEVICE(0x13d3, 0x3432) },
+	{ USB_DEVICE(0x13d3, 0x3472) },
 	{ USB_DEVICE(0x13d3, 0x3474) },
 
 	/* Atheros AR5BBU12 with sflash firmware */
@@ -185,6 +186,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x13d3, 0x3408), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3423), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3432), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3472), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3474), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU22 with sflash firmware */
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 97f3bba..0d4e372 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -234,6 +234,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3408), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3423), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3432), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3472), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3474), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
-- 
1.9.1
