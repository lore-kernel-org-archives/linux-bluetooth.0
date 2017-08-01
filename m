Return-Path: <briannorris@chromium.org>
From: Brian Norris <briannorris@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: <linux-kernel@vger.kernel.org>,
	Miao-chen Chou <mcchou@chromium.org>,
	Waldemar Rymarkiewicz <ext.waldemar.rymarkiewicz@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] Bluetooth: btusb: add ID for LiteOn 04ca:3016
Date: Mon, 31 Jul 2017 17:59:39 -0700
Message-Id: <20170801005939.109205-1-briannorris@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Contains a QCA6174A-5 chipset, with USB BT. Let's support loading
firmware on it.

>From usb-devices:
T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=04ca ProdID=3016 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v2:
 * include usb-devices info in commit message

 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1cefff772cd0..24cc8383fdd4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -269,6 +269,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.14.0.rc0.400.g1c36432dff-goog
