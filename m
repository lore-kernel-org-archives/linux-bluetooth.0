Return-Path: <cyrus@holtmann.org>
From: Manoj Iyer <manoj.iyer@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: btusb: Add vendor specific ID (0a5c:21f4) BCM20702A0
Date: Wed, 11 Apr 2012 13:39:23 -0500
Message-Id: <1334169563-2948-2-git-send-email-manoj.iyer@canonical.com>
In-Reply-To: <1334169563-2948-1-git-send-email-manoj.iyer@canonical.com>
References: <1334169563-2948-1-git-send-email-manoj.iyer@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

usb-devices:
T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=21f4 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=E4D53DF15584
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Reported-by: Dennis Chua <dennis.chua@canonical.com>
Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
---
 drivers/bluetooth/btusb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 480cad9..4ef79d0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -104,6 +104,7 @@ static struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x0a5c, 0x21e3) },
 	{ USB_DEVICE(0x0a5c, 0x21e6) },
 	{ USB_DEVICE(0x0a5c, 0x21f3) },
+	{ USB_DEVICE(0x0a5c, 0x21f4) },
 	{ USB_DEVICE(0x413c, 0x8197) },
 
 	{ }	/* Terminating entry */
-- 
1.7.9.1
