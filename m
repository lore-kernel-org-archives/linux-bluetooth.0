Return-Path: <cyrus@holtmann.org>
From: Vincent Elger Zwanenburg <vincentezw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] drivers/bluetooth: Toshiba Qualcomm AR9565 (ath3k) bluetooth fix
Date: Mon, 04 Aug 2014 11:35:41 +0100
Message-ID: <1500387.0D3PNSTLgV@venture>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From:  Vincent Elger Zwanenburg <vincentz@topmail.ie>
Date:   Mon Aug 4 01:34:27 2014 +0100

Fixes bluetooth support on Toshiba C55-B-138 notebooks by 1) adding an ignore 
line into btusb.c for its PID/VID combination and 2) assigning the VID/PID 
combination in ath3k.c to load the BTUSB_ATH3012 driver.

relevant usb-devices command output:

T:  Bus=01 Lev=02 Prnt=05 Port=00 Cnt=01 Dev#= 10 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0930 ProdID=0227 Rev=00.02
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: Vincent Elger Zwanenburg <vincentz@topmail.ie>
---
diff -uprN -X linux-3.16-rc7-vanilla/Documentation/dontdiff linux-3.16-rc7-
vanilla/drivers/bluetooth/ath3k.c /usr/src/linux-
mine/drivers/bluetooth/ath3k.c
--- linux-3.16-rc7-vanilla/drivers/bluetooth/ath3k.c    2014-07-27 
20:41:55.000000000 +0100
+++ /usr/src/linux-mine/drivers/bluetooth/ath3k.c       2014-08-03 
04:24:37.449746557 +0100
@@ -75,6 +75,7 @@ static const struct usb_device_id ath3k_
        /* Atheros AR3012 with sflash firmware*/
        { USB_DEVICE(0x0489, 0xe04d) },
        { USB_DEVICE(0x0489, 0xe04e) },
+       { USB_DEVICE(0x0930, 0x0227) },
        { USB_DEVICE(0x0489, 0xe057) },
        { USB_DEVICE(0x0489, 0xe056) },
        { USB_DEVICE(0x0489, 0xe05f) },
@@ -123,6 +124,7 @@ static const struct usb_device_id ath3k_
 
        /* Atheros AR3012 with sflash firmware*/
        { USB_DEVICE(0x0489, 0xe04e), .driver_info = BTUSB_ATH3012 },
+       { USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0489, 0xe04d), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0489, 0xe056), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0489, 0xe057), .driver_info = BTUSB_ATH3012 },
diff -uprN -X linux-3.16-rc7-vanilla/Documentation/dontdiff linux-3.16-rc7-
vanilla/drivers/bluetooth/btusb.c /usr/src/linux-
mine/drivers/bluetooth/btusb.c
--- linux-3.16-rc7-vanilla/drivers/bluetooth/btusb.c    2014-07-27 
20:41:55.000000000 +0100
+++ /usr/src/linux-mine/drivers/bluetooth/btusb.c       2014-08-03 
04:12:09.386738905 +0100
@@ -158,6 +158,7 @@ static const struct usb_device_id blackl
        { USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x04ca, 0x300b), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
+       { USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0930, 0x0220), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
        { USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },

