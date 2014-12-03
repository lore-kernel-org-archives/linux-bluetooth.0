Return-Path: <cyrus@holtmann.org>
From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Adam Lee <adam.lee@canonical.com>,
	Bruce Ma <bruce.ma@canonical.com>
Subject: [PATCH 5/6] Bluetooth: Add support for 04ca:2007
Date: Wed,  3 Dec 2014 14:45:44 +0800
Message-Id: <1417589145-30467-5-git-send-email-jesse.sung@canonical.com>
In-Reply-To: <1417589145-30467-1-git-send-email-jesse.sung@canonical.com>
References: <1417589145-30467-1-git-send-email-jesse.sung@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.1.0"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Adam Lee <adam.lee@canonical.com>

This is a multi-part message in MIME format.
--------------2.1.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


BugLink: https://launchpad.net/bugs/1153448

These devices require external patchram firmware to work.

T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=04ca ProdID=2007 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM43142A0
S:  SerialNumber=20689DD16A22
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Adam Lee <adam.lee@canonical.com>
Signed-off-by: Bruce Ma <bruce.ma@canonical.com>
Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)


--------------2.1.0
Content-Type: text/x-patch; name="0005-Bluetooth-Add-support-for-04ca-2007.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0005-Bluetooth-Add-support-for-04ca-2007.patch"

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d2923a8..740c854 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -110,6 +110,10 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x413c, 0x8143),
 	  .driver_info = BTUSB_BCM_PATCHRAM },
 
+	/* Broadcom BCM43142A0 */
+	{ USB_DEVICE(0x04ca, 0x2007),
+	  .driver_info = BTUSB_BCM_PATCHRAM },
+
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
 	  .driver_info = BTUSB_BCM_PATCHRAM },

--------------2.1.0--


