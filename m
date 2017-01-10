Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add support for 413c:8143
Date: Tue, 10 Jan 2017 15:41:13 +0800
Message-Id: <1484034073-12440-1-git-send-email-jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a Boardcom module and requires patchram to work.

T: Bus=01 Lev=03 Prnt=03 Port=01 Cnt=02 Dev#= 5 Spd=12 MxCh= 0
D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=413c ProdID=8143 Rev= 1.12
S: Manufacturer=Broadcom Corp
S: Product=BCM20702A0
S: SerialNumber=20689D1FAF94
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr= 0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E: Ad=84(I) Atr=02(Bulk) MxPS= 32 Ivl=0ms
E: Ad=04(O) Atr=02(Bulk) MxPS= 32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2f633df..e721108 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -122,6 +122,7 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x0c10, 0x0000) },
 
 	/* Broadcom BCM20702A0 */
+	{ USB_DEVICE(0x413c, 0x8143), .driver_info = BTUSB_BCM_PATCHRAM },
 	{ USB_DEVICE(0x413c, 0x8197) },
 
 	/* Broadcom BCM20702B0 (Dynex/Insignia) */
-- 
2.7.4

