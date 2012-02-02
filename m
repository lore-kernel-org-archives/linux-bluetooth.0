Return-Path: <cyrus@holtmann.org>
From: Manoj Iyer <manoj.iyer@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Add vendor specific ID (0a5c 21f3) for BCM20702A0.
Date: Thu,  2 Feb 2012 09:32:36 -0600
Message-Id: <1328196756-3087-2-git-send-email-manoj.iyer@canonical.com>
In-Reply-To: <1328196756-3087-1-git-send-email-manoj.iyer@canonical.com>
References: <1328196756-3087-1-git-send-email-manoj.iyer@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

T: Bus=01 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#= 5 Spd=12 MxCh= 0
D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=0a5c ProdID=21f3 Rev=01.12
S: Manufacturer=Broadcom Corp
S: Product=BCM20702A0
S: SerialNumber=74DE2B344A7B
C: #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I: If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I: If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I: If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
Tested-by: Dennis Chua <dennis.chua@canonical.com>
---
 drivers/bluetooth/btusb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f00f596..10e33be 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -102,6 +102,7 @@ static struct usb_device_id btusb_table[] = {
 
 	/* Broadcom BCM20702A0 */
 	{ USB_DEVICE(0x0a5c, 0x21e3) },
+	{ USB_DEVICE(0x0a5c, 0x21f3) },
 	{ USB_DEVICE(0x413c, 0x8197) },
 
 	{ }	/* Terminating entry */
-- 
1.7.8.3
