Return-Path: <cyrus@holtmann.org>
From: Dmitry Tunin <hanipouspilot@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Tunin <hanipouspilot@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] ath3k: add support of 04ca:300f AR3012 device
Date: Sat,  2 May 2015 13:36:58 +0300
Message-Id: <1430563018-6692-1-git-send-email-hanipouspilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BugLink: https://bugs.launchpad.net/bugs/1449730

T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=02 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=04ca ProdID=300f Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/ath3k.c | 2 ++
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 288547a..d446d67 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -88,6 +88,7 @@ static const struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x04CA, 0x3007) },
 	{ USB_DEVICE(0x04CA, 0x3008) },
 	{ USB_DEVICE(0x04CA, 0x300b) },
+	{ USB_DEVICE(0x04CA, 0x300f) },
 	{ USB_DEVICE(0x04CA, 0x3010) },
 	{ USB_DEVICE(0x0930, 0x0219) },
 	{ USB_DEVICE(0x0930, 0x0220) },
@@ -143,6 +144,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x04ca, 0x3007), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x300f), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3010), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d21f3b4..a418fff 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -186,6 +186,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x04ca, 0x3007), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x04ca, 0x300f), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3010), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
-- 
1.9.1

