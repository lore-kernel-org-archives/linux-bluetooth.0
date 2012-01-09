Return-Path: <cyrus@holtmann.org>
Message-ID: <4F0ACADF.1060906@cestona.ro>
Date: Mon, 09 Jan 2012 12:09:19 +0100
From: Thilo Cestonaro <thilo@cestona.ro>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for BCM20702A0 [0489:e031]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add another vendor specific ID for BCM20702A0.

output of usb-devices:
T:  Bus=02 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e031 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=EC55F9EADE09
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
---
  drivers/bluetooth/btusb.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 55ac349..07622141a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -101,6 +101,7 @@ static struct usb_device_id btusb_table[] = {
      { USB_DEVICE(0x0c10, 0x0000) },

      /* Broadcom BCM20702A0 */
+    { USB_DEVICE(0x0489, 0xe031) },
      { USB_DEVICE(0x0a5c, 0x21e3) },
      { USB_DEVICE(0x413c, 0x8197) },

-- 
1.7.5.4

