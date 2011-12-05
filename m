Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Dec 2011 22:15:29 +0000
From: eran <eran@over-here.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Adding USB device 13d3:3375 as an Atheros
 AR3012.
Message-ID: <20111205221529.GA21676@over-here.org>
References: <20111123100356.GB9838@over-here.org>
 <20111123190500.GA7179@samus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111123190500.GA7179@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eran <eran@over-here.org>

The bluetooth module in the Asus UX31/UX21 is based on Atheros AR3012
and requires a firmware to be uploaded before it's usable.

output of usb-devices for this module:
T:  Bus=01 Lev=02 Prnt=02 Port=07 Cnt=03 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3375 Rev=00.02
S:  Manufacturer=Atheros Communications
S:  Product=Bluetooth USB Host Controller
S:  SerialNumber=Alaska Day 2006
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb


Signed-off-by: Eran <eran@over-here.org>
---
 drivers/bluetooth/ath3k.c |    2 ++
 drivers/bluetooth/btusb.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 106beb1..b94aae6 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -70,6 +70,7 @@ static struct usb_device_id ath3k_table[] = {
 
 	/* Atheros AR3012 with sflash firmware*/
 	{ USB_DEVICE(0x0CF3, 0x3004) },
+	{ USB_DEVICE(0x13d3, 0x3375) },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xE02C) },
@@ -86,6 +87,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
 
 	/* Atheros AR3012 with sflash firmware*/
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
 
 	{ }	/* Terminating entry */
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f9b7260..a64f15a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -122,6 +122,7 @@ static struct usb_device_id blacklist_table[] = {
 
 	/* Atheros 3012 with sflash firmware */
 	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
 
 	/* Atheros AR5BBU12 with sflash firmware */
 	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
-- 
1.7.2.5

