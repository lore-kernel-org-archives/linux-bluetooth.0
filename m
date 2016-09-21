Return-Path: <hanipouspilot@gmail.com>
From: Dmitry Tunin <hanipouspilot@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	1535802@bugs.launchpad.net,
	vanakt@gmail.com,
	Dmitry Tunin <hanipouspilot@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: Add a new 04ca:3011 QCA_ROME device
Date: Wed, 21 Sep 2016 19:13:08 +0300
Message-Id: <1474474388-14742-1-git-send-email-hanipouspilot@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

BugLink: https://bugs.launchpad.net/bugs/1535802

T:  Bus=01 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=04ca ProdID=3011 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9ebd73d..6bd63b8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -253,6 +253,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.7.4
