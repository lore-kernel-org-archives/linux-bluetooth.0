Return-Path: <cyrus@holtmann.org>
From: Heinrich Siebmanns <harv@gmx.de>
To: linux-bluetooth@vger.kernel.org
Cc: Heinrich Siebmanns <harv@gmx.de>
Subject: [PATCH]     Bluetooth: Add support for Broadcom BCM20702A0 in Fuijitsu Lifebook E751
Date: Tue,  2 Dec 2014 19:46:57 +0100
Message-Id: <1417546017-25257-1-git-send-email-harv@gmx.de>
In-Reply-To: <8967C48B-00C1-43E8-A8EC-C41642288122@holtmann.org>
References: <8967C48B-00C1-43E8-A8EC-C41642288122@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

    This requires the flag BTUSB_BCM_PATCHRAM to work.

    Relevant details from /sys/kernel/debug/usb/devices:

    T:  Bus=03 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
    D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=0489 ProdID=e031 Rev= 1.12
    S:  Manufacturer=Broadcom Corp
    S:  Product=BCM20702A0
    S:  SerialNumber=3859F9CD2AEE
    C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
    I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
    E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
    E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
    E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
    I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
    I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
    I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
    I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
    E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
    E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
    I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

    The firmware was extracted from a Windows 7 32-bit installation
    and converted from 'hex' to 'hcd' for use in Linux.

    The firmware is named "BCM20702A0_001.001.024.0156.0204.hex"
    and is located in "%SYSTEMROOT%\system32\drivers\"
    (md5 d126e6c4e0e669d76c38cf9377f76b7f)
    (sha1 145d1850b2785a953233b409e7ff77786927c7d2)

    The same firmware file is also available as a download at
    http://support.ts.fujitsu.com/Download/
    contained in "FTS_WIDCOMMBluetoothSoftware_6309000_1072149.zip"

    'hcd' file should be placed at "brcm/BCM20702A0-0489-e031.hcd"
    inside the firmware directory (e.g. "/lib/firmware")

    Signed-off-by: Heinrich Siebmanns <harv@gmx.de>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9efdace..33a92ec 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -108,6 +108,8 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x413c, 0x8197) },
 	{ USB_DEVICE(0x13d3, 0x3404),
 	  .driver_info = BTUSB_BCM_PATCHRAM },
+        { USB_DEVICE(0x0489, 0xe031),
+          .driver_info = BTUSB_BCM_PATCHRAM },
 
 	/* Foxconn - Hon Hai */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
-- 
2.1.3

