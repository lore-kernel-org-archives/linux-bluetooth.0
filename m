Return-Path: <fourdollars@gmail.com>
From: "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add support for 0489:0xe0a2 QCA_ROME device
Date: Wed, 14 Jun 2017 14:42:00 +0800
Message-Id: <1497422520-26184-1-git-send-email-sylee@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

T:  Bus=01 Lev=01 Prnt=01 Port=06 Cnt=03 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0a2 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: Shih-Yuan Lee (FourDollars) <sylee@canonical.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7fa373b..a337f56 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -266,6 +266,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0cf3, 0xe301), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
 
 	/* Broadcom BCM2035 */
-- 
2.7.4
