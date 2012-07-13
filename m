Return-Path: <cyrus@holtmann.org>
From: "Henrik Rydberg" <rydberg@euromail.se>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH v3] Bluetooth: Add MacBookPro10,1 support
Date: Fri, 13 Jul 2012 16:41:59 +0200
Message-Id: <1342190519-824-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for the 2012 15'' MacBook Pro Retina, also known as
MacBookPro10,1. The bluetooth device presents itself as

T:  Bus=02 Lev=04 Prnt=04 Port=02 Cnt=01 Dev#=  8 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=05ac ProdID=8286 Rev=00.74
S:  Manufacturer=Apple Inc.
S:  Product=Bluetooth USB Host Controller
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Patch originally written and tested by clipcarl (forums.opensuse.org).
Thanks to Ryan Bourgeois <bluedragonx@gmail.com> for providing the usb
device data.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Gustavo,

I understand you might not need this patch any longer, but just in
case, for 3.5 and backports, here it is.

Thanks,
Henrik

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 83ebb24..6cc54da 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -84,6 +84,9 @@ static struct usb_device_id btusb_table[] = {
 	/* Apple MacMini5,1 */
 	{ USB_DEVICE(0x05ac, 0x8281) },
 
+	/* Apple MacBookPro10,1 */
+	{ USB_DEVICE(0x05ac, 0x8286) },
+
 	/* AVM BlueFRITZ! USB v2.0 */
 	{ USB_DEVICE(0x057c, 0x3800) },
 
-- 
1.7.11.1

