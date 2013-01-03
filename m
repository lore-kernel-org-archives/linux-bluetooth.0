Return-Path: <cyrus@holtmann.org>
Sender: AceLan Kao <acelan@gmail.com>
From: AceLan Kao <acelan.kao@canonical.com>
To: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH 2/2] Bluetooth: Add support for Foxconn / Hon Hai [0489:e056]
Date: Thu,  3 Jan 2013 12:25:00 +0800
Message-Id: <1357187100-9658-2-git-send-email-acelan.kao@canonical.com>
In-Reply-To: <1357187100-9658-1-git-send-email-acelan.kao@canonical.com>
References: <1357187100-9658-1-git-send-email-acelan.kao@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for the AR9462 chip

T: Bus=01 Lev=02 Prnt=02 Port=05 Cnt=01 Dev#= 4 Spd=12 MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0489 ProdID=e056 Rev=00.01
C: #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I: If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/bluetooth/ath3k.c |    2 ++
 drivers/bluetooth/btusb.c |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 0649513..0bb42e6 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -83,6 +83,7 @@ static struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x0489, 0xe057) },
 	{ USB_DEVICE(0x13d3, 0x3393) },
 	{ USB_DEVICE(0x0489, 0xe04e) },
+	{ USB_DEVICE(0x0489, 0xe056) },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE02C) },
@@ -112,6 +113,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3393), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU22 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE03C), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ba617d6..170d20d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -141,6 +141,7 @@ static struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3393), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
-- 
1.7.10.4
