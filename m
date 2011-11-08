Return-Path: <cyrus@holtmann.org>
Message-ID: <4EB8D188.2040407@canonical.com>
Date: Tue, 08 Nov 2011 14:51:52 +0800
From: Jesse Sung <jesse.sung@canonical.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org, 854399@bugs.launchpad.net,
	padovan@profusion.mobi
Subject: Re: [PATCH] Bluetooth: Add support for Broadcom BCM20702A0.
References: <4E7840CF.5010805@canonical.com> <20111031193354.GG10164@joana>
In-Reply-To: <20111031193354.GG10164@joana>
Content-Type: multipart/mixed;
 boundary="------------060703070508080009020903"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060703070508080009020903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/01/2011 03:33 AM, Gustavo Padovan wrote:
> Hi Jesse,
>
> * Jesse Sung<jesse.sung@canonical.com>  [2011-09-20 15:29:19 +0800]:
>
>> Add a new entry (413c:8197) to device ID table.
>
> Can I get the output of usbdevices in the commit message, please. Then we can
> prove that adding it to the device ID table is really necessary.
>
> 	Gustavo

Hi Gustavo,

Sure! Modified patch attached. :)

Thanks,
Jesse


--------------060703070508080009020903
Content-Type: text/x-patch;
 name="0001-Bluetooth-Add-support-for-Broadcom-BCM20702A0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Bluetooth-Add-support-for-Broadcom-BCM20702A0.patch"

>From 7ced2be26f17eadc63c6b7fe0d37f948d4fef87c Mon Sep 17 00:00:00 2001
From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Date: Tue, 8 Nov 2011 14:30:22 +0800
Subject: [PATCH] Bluetooth: Add support for Broadcom BCM20702A0

Since this device declares itself as vendor specific, must add
a new entry to device ID table to support it.

usb-device output of this device:

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8197 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=D0DF9AA9C9F1
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9db2476..151a2d2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -100,6 +100,9 @@ static struct usb_device_id btusb_table[] = {
 	/* Canyon CN-BTU1 with HID interfaces */
 	{ USB_DEVICE(0x0c10, 0x0000) },
 
+	/* Broadcom BCM20702A0 */
+	{ USB_DEVICE(0x413c, 0x8197) },
+
 	{ }	/* Terminating entry */
 };
 
-- 
1.7.7.1


--------------060703070508080009020903--
