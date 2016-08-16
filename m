Return-Path: <kaihengfeng@gmail.com>
From: Kai-Heng Feng <kaihengfeng@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kai.heng.feng@canonical.com,
	jesse.sung@canonical.com
Subject: [PATCH] Bluetooth: btusb: Add support for 0cf3:e009
Date: Tue, 16 Aug 2016 12:50:06 +0800
Message-Id: <1471323006-26712-1-git-send-email-kai.heng.feng@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Device 0cf3:e009 is one of the QCA ROME family.

T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=04 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e009 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c58a00c..80ae854 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -248,6 +248,7 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* QCA ROME chipset */
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x0cf3, 0xe009), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
-- 
2.8.1
