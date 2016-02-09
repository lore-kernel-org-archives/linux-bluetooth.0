Return-Path: <hanipouspilot@gmail.com>
From: Dmitry Tunin <hanipouspilot@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-firmware@kernel.org,
	dams.38@hotmail.fr,
	Dmitry Tunin <hanipouspilot@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: Add new AR3012 ID 0489:e095
Date: Wed, 10 Feb 2016 00:49:11 +0300
Message-Id: <1455054551-3884-1-git-send-email-hanipouspilot@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

T: Bus=01 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#= 3 Spd=12 MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0489 ProdID=e095 Rev=00.01
C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

This device requires ar3k/AthrBT_0x31010100.dfu and
ar3k/ramps_0x31010100_40.dfu firmware files that are not in
linux-firmware yet.

BugLink: https://bugs.launchpad.net/bugs/1542944

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/ath3k.c | 2 ++
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index ebd641b..8472010 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -82,6 +82,7 @@ static const struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x0489, 0xe05f) },
 	{ USB_DEVICE(0x0489, 0xe076) },
 	{ USB_DEVICE(0x0489, 0xe078) },
+	{ USB_DEVICE(0x0489, 0xe095) },
 	{ USB_DEVICE(0x04c5, 0x1330) },
 	{ USB_DEVICE(0x04CA, 0x3004) },
 	{ USB_DEVICE(0x04CA, 0x3005) },
@@ -144,6 +145,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x0489, 0xe05f), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe076), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe078), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe095), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a191e31..f4b8d08 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -196,6 +196,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe05f), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe076), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe078), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe095), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04c5, 0x1330), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
-- 
1.9.1
