Return-Path: <cyrus@holtmann.org>
Sender: AceLan Kao <acelan@gmail.com>
From: AceLan Kao <acelan.kao@canonical.com>
To: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: Add support for Atheros [13d3:3362]
Date: Fri, 13 Apr 2012 17:39:57 +0800
Message-Id: <1334309997-882-1-git-send-email-acelan.kao@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add another vendor specific ID for Atheros AR3012 device.
This chip is wrapped by IMC Networks.

output of usb-devices:
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3362 Rev=00.02
S:  Manufacturer=Atheros Communications
S:  Product=Bluetooth USB Host Controller
S:  SerialNumber=Alaska Day 2006
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 drivers/bluetooth/ath3k.c |    2 ++
 drivers/bluetooth/btusb.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index ae9edca..639a161 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -75,6 +75,7 @@ static struct usb_device_id ath3k_table[] = {
 	{ USB_DEVICE(0x0CF3, 0x311D) },
 	{ USB_DEVICE(0x13d3, 0x3375) },
 	{ USB_DEVICE(0x04CA, 0x3005) },
+	{ USB_DEVICE(0x13d3, 0x3362) },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE02C) },
@@ -94,6 +95,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
 	{ USB_DEVICE(0x0cf3, 0x311D), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
 
 	{ }	/* Terminating entry */
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9af450a..a497544 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -134,6 +134,7 @@ static struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
-- 
1.7.9.1
