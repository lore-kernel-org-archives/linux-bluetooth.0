Return-Path: <lauro@polilinux.com.br>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: Add USB ID 13D3:3487 to ath3k
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 09 Dec 2015 11:51:55 -0200
From: lauro@polilinux.com.br
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <44c3bb67d7b1acc9c9ed8a9df1c37d72@polilinux.com.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Add hw id to ath3k usb device list and btusb blacklist.

T:  Bus=01 Lev=01 Prnt=01 Port=08 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3487 Rev=00.02
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Requires these firmwares:
ar3k/AthrBT_0x11020100.dfu and ar3k/ramps_0x11020100_40.dfu
Firmwares are available in linux-firmware.

Device found in a laptop ASUS model N552VW. It's an Atheros AR9462 chip.

Signed-off-by: Lauro Costa <lauro@polilinux.com.br>
---
  drivers/bluetooth/ath3k.c | 2 ++
  drivers/bluetooth/btusb.c | 1 +
  2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index fa893c3..9ad37e1 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -118,6 +118,7 @@ static const struct usb_device_id ath3k_table[] = {
  	{ USB_DEVICE(0x13d3, 0x3423) },
  	{ USB_DEVICE(0x13d3, 0x3432) },
  	{ USB_DEVICE(0x13d3, 0x3474) },
+	{ USB_DEVICE(0x13d3, 0x3487) },

  	/* Atheros AR5BBU12 with sflash firmware */
  	{ USB_DEVICE(0x0489, 0xE02C) },
@@ -180,6 +181,7 @@ static const struct usb_device_id ath3k_blist_tbl[] 
= {
  	{ USB_DEVICE(0x13d3, 0x3423), .driver_info = BTUSB_ATH3012 },
  	{ USB_DEVICE(0x13d3, 0x3432), .driver_info = BTUSB_ATH3012 },
  	{ USB_DEVICE(0x13d3, 0x3474), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3487), .driver_info = BTUSB_ATH3012 },

  	/* Atheros AR5BBU22 with sflash firmware */
  	{ USB_DEVICE(0x0489, 0xE036), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a191e31..c2e3278 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -232,6 +232,7 @@ static const struct usb_device_id blacklist_table[] 
= {
  	{ USB_DEVICE(0x13d3, 0x3423), .driver_info = BTUSB_ATH3012 },
  	{ USB_DEVICE(0x13d3, 0x3432), .driver_info = BTUSB_ATH3012 },
  	{ USB_DEVICE(0x13d3, 0x3474), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3487), .driver_info = BTUSB_ATH3012 },

  	/* Atheros AR5BBU12 with sflash firmware */
  	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
-- 
1.9.0
