Return-Path: <cyrus@holtmann.org>
Message-ID: <547DC72E.8000308@gmx.de>
Date: Tue, 02 Dec 2014 15:05:34 +0100
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Adding Broadcom Support for BCM 20702AO of Fuijitsu Lifebook
 E751 with .driver_info = BTUSB_BCM_PATCHRAM },
References: <547C2F76.80000@gmx.de> <CA52376B-12C5-4A2E-9922-616A722D1D54@holtmann.org> <547C4D47.6010606@gmx.de> <1FB03768-38C7-4FDA-980A-C63BA5EE2DC2@holtmann.org> <547D817A.7010708@gmx.de> <3A403AB8-AE17-45E8-BABE-D41F8087AE18@holtmann.org>
In-Reply-To: <3A403AB8-AE17-45E8-BABE-D41F8087AE18@holtmann.org>
Content-Type: multipart/mixed;
 boundary="------------090808020503090700090502"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090808020503090700090502
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel,

> check the commit a86c02ea38c53b695209b1181f9e2e18d73eb4e8 in
> bluetooth-next tree.

thanks for your help.I gathered all informations and tried to adapt
the commit. See attachment.

Harvey

- -- 
I am root. If you see me laughing, you'd better have a backup!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlR9xygACgkQi5aqmLBUSgmnywCcDDt9eGvb6Ab/GLVz1WLUTNyH
NKAAnRjpW0xUJRRA3upQPTOJXxJS8P8Z
=uCre
-----END PGP SIGNATURE-----

--------------090808020503090700090502
Content-Type: text/plain; charset=UTF-8;
 name="commit_BT.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="commit_BT.txt"

    Bluetooth: Add support for Broadcom BCM20702A0 in Fuijitsu Lifebook E751
    
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
    
    Signed-off-by: Harvey <harv@gmx.de>
    
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cd634f3..7c13d7a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -106,6 +106,8 @@ static const struct usb_device_id btusb_table[] = {
        { USB_DEVICE(0x413c, 0x8197) },
        { USB_DEVICE(0x13d3, 0x3404),
          .driver_info = BTUSB_BCM_PATCHRAM },
+       { USB_DEVICE(0x0489, 0xe031),
+         .driver_info = BTUSB_BCM_PATCHRAM },
 
        /* Foxconn - Hon Hai */
        { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },

--------------090808020503090700090502--
