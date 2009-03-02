Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btusb: new device id needing BTUSB_WRONG_SCO_MTU quirk
Date: Mon, 02 Mar 2009 13:51:55 +0100
Message-ID: <87hc2c3x5g.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

My Lenovo Thinkpad X301 locks up consistently when I mount an obexfs
file system over btusb and forget to unmount it before switching off the
other end.  There are no messages printed on the console.  The box
doesn't have a serial port so I haven't checked with a serial console.

Looking through btusb.c I noticed the quirks for other Thinkpad models
with a Broadcom chip.  It just doesn't match the presumably newer chip
in the X301:

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=2145 Rev= 3.99
S:  Manufacturer=Lenovo Computer Corp
S:  Product=ThinkPad Bluetooth with Enhanced Data Rate II
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)


This made me try "modprobe btusb force_scofix=1" which seems to fix the
problem.  No lock ups observed with this module parameter.  hciconfig
reports before and after:

nemi:/tmp# hciconfig 
hci0:   Type: USB
        BD Address: 00:23:4D:F0:D9:1A ACL MTU: 1021:8 SCO MTU: 64:1
        UP RUNNING PSCAN 
        RX bytes:999 acl:0 sco:0 events:31 errors:0
        TX bytes:851 acl:0 sco:0 commands:31 errors:0

nemi:/tmp# modprobe -r btusb
nemi:/tmp# modprobe btusb force_scofix=1
nemi:/tmp# hciconfig 
hci0:   Type: USB
        BD Address: 00:23:4D:F0:D9:1A ACL MTU: 1021:8 SCO MTU: 64:8
        UP RUNNING PSCAN 
        RX bytes:999 acl:0 sco:0 events:31 errors:0
        TX bytes:851 acl:0 sco:0 commands:31 errors:0


If any of this makes any sense, then I suggest applying the attached
patch to btusb.c.

Signed-off-by: Bjørn Mork <bjorn@mork.no>

---
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b5fbda6..4355133 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -99,6 +99,7 @@ static struct usb_device_id blacklist_table[] = {
 	/* IBM/Lenovo ThinkPad with Broadcom chip */
 	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = BTUSB_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x0a5c, 0x2145), .driver_info = BTUSB_WRONG_SCO_MTU },
 
 	/* HP laptop with Broadcom chip */
 	{ USB_DEVICE(0x03f0, 0x171d), .driver_info = BTUSB_WRONG_SCO_MTU },
