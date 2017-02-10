Return-Path: <haagch@frickel.club>
From: Christoph Haag <haagch@frickel.club>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	Christoph Haag <haagch@frickel.club>
Subject: [PATCH] Bluetooth: btusb: add support for 0bb4:0306
Date: Fri, 10 Feb 2017 01:31:42 +0100
Message-Id: <20170210003142.3871-1-haagch@frickel.club>
List-ID: <linux-bluetooth.vger.kernel.org>

It's a custom USB ID for the broadcom bt adapter in the HTC Vive.

T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  7 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bb4 ProdID=0306 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM2045A0
S:  SerialNumber=AC3743E110CE
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Christoph Haag <haagch@frickel.club>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2f633df9f4e6..afb48aebe9c5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -124,6 +124,9 @@ static const struct usb_device_id btusb_table[] = {
 	/* Broadcom BCM20702A0 */
 	{ USB_DEVICE(0x413c, 0x8197) },
 
+	/* Broadcom BCM2045A0 found in the HTC Vive */
+	{ USB_DEVICE(0x0bb4, 0x0306) },
+
 	/* Broadcom BCM20702B0 (Dynex/Insignia) */
 	{ USB_DEVICE(0x19ff, 0x0239), .driver_info = BTUSB_BCM_PATCHRAM },
 
-- 
2.11.1
