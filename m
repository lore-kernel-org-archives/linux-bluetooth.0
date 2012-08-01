Return-Path: <cyrus@holtmann.org>
From: "Chen, Peng" <pengchen@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "gustavo@padovan.org" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Waller, Carolyn" <carolyn@qca.qualcomm.com>, "Jeang, Daniel"
	<dyjeong@qca.qualcomm.com>, "Shanmugam Kamatchi, Bala"
	<bkamatch@qca.qualcomm.com>, "Yao, Costa" <cqyao@qca.qualcomm.com>, "Fan,
 Hong" <hongfan@qca.qualcomm.com>, "Balasubramanian, Senthil Kumar"
	<senthilb@qca.qualcomm.com>, "Wu, Frank" <fanwu@qca.qualcomm.com>
Subject: RE: [patch]Add Vendor/Device ID for AR3012
Date: Wed, 1 Aug 2012 01:49:15 +0000
Message-ID: <0EC13EFF38B7C84DB595405A8233E35B099B2EF2@nasanexd01b.na.qualcomm.com>
References: <0EC13EFF38B7C84DB595405A8233E35B099AE930@nasanexd01b.na.qualcomm.com>,<1342610820.24426.4.camel@aeonflux>,<0EC13EFF38B7C84DB595405A8233E35B099B1C02@nasanexd01b.na.qualcomm.com>
In-Reply-To: <0EC13EFF38B7C84DB595405A8233E35B099B1C02@nasanexd01b.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hotmann,=0A=
=0A=
How about this patch? Is there any problem?=0A=
=0A=
=0A=
Best Regards=0A=
Peng=0A=
=0A=
________________________________________=0A=
From: Chen, Peng=0A=
Sent: Monday, July 23, 2012 2:25 PM=0A=
To: Marcel Holtmann=0A=
Cc: gustavo@padovan.org; linux-bluetooth@vger.kernel.org; Waller, Carolyn; =
Jeang, Daniel; Shanmugam Kamatchi, Bala; Yao, Costa; Fan, Hong; Balasubrama=
nian, Senthil Kumar; Wu, Frank=0A=
Subject: RE: [patch]Add Vendor/Device ID for AR3012=0A=
=0A=
Hi Holtmann,=0A=
=0A=
Sorry. I am not familiar with using git to send mail right now.=0A=
_________________________=0A=
=0A=
=0A=
>From a1653337899ad56b23b52c43824445b8f23a24fd Mon Sep 17 00:00:00 2001=0A=
From: Peng Chen <pengchen@qca.qualcomm.com>=0A=
Date: Mon, 23 Jul 2012 12:56:20 +0800=0A=
Subject: [PATCH]     Bluetooth: add support for atheros 0489:e057=0A=
=0A=
    Add support for the AR3012 chip found on Foxconn.=0A=
=0A=
    usb-devices shows:=0A=
=0A=
    T:  Bus=3D06 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D 44 Spd=3D12 =
  MxCh=3D 0=0A=
    D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1=0A=
    P:  Vendor=3D0489 ProdID=3De057 Rev=3D 0.02=0A=
    C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA=0A=
    I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
    E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms=0A=
    E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms=0A=
    E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms=0A=
    I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms=0A=
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms=0A=
    I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms=0A=
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms=0A=
    I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms=0A=
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms=0A=
    I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms=0A=
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms=0A=
    I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms=0A=
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms=0A=
    I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
    E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms=0A=
    E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms=0A=
=0A=
Signed-off-by: Peng Chen <pengchen@qca.qualcomm.com>=0A=
---=0A=
 drivers/bluetooth/ath3k.c |    2 ++=0A=
 drivers/bluetooth/btusb.c |    1 +=0A=
 2 files changed, 3 insertions(+)=0A=
=0A=
diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c=0A=
index 10308cd..11f36e5 100644=0A=
--- a/drivers/bluetooth/ath3k.c=0A=
+++ b/drivers/bluetooth/ath3k.c=0A=
@@ -79,6 +79,7 @@ static struct usb_device_id ath3k_table[] =3D {=0A=
        { USB_DEVICE(0x13d3, 0x3362) },=0A=
        { USB_DEVICE(0x0CF3, 0xE004) },=0A=
        { USB_DEVICE(0x0930, 0x0219) },=0A=
+       { USB_DEVICE(0x0489, 0xe057) },=0A=
=0A=
        /* Atheros AR5BBU12 with sflash firmware */=0A=
        { USB_DEVICE(0x0489, 0xE02C) },=0A=
@@ -104,6 +105,7 @@ static struct usb_device_id ath3k_blist_tbl[] =3D {=0A=
        { USB_DEVICE(0x13d3, 0x3362), .driver_info =3D BTUSB_ATH3012 },=0A=
        { USB_DEVICE(0x0cf3, 0xe004), .driver_info =3D BTUSB_ATH3012 },=0A=
        { USB_DEVICE(0x0930, 0x0219), .driver_info =3D BTUSB_ATH3012 },=0A=
+       { USB_DEVICE(0x0489, 0xe057), .driver_info =3D BTUSB_ATH3012 },=0A=
=0A=
        /* Atheros AR5BBU22 with sflash firmware */=0A=
        { USB_DEVICE(0x0489, 0xE03C), .driver_info =3D BTUSB_ATH3012 },=0A=
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c=0A=
index e272214..4e007ac 100644=0A=
--- a/drivers/bluetooth/btusb.c=0A=
+++ b/drivers/bluetooth/btusb.c=0A=
@@ -133,6 +133,7 @@ static struct usb_device_id blacklist_table[] =3D {=0A=
        { USB_DEVICE(0x13d3, 0x3362), .driver_info =3D BTUSB_ATH3012 },=0A=
        { USB_DEVICE(0x0cf3, 0xe004), .driver_info =3D BTUSB_ATH3012 },=0A=
        { USB_DEVICE(0x0930, 0x0219), .driver_info =3D BTUSB_ATH3012 },=0A=
+       { USB_DEVICE(0x0489, 0xe057), .driver_info =3D BTUSB_ATH3012 },=0A=
=0A=
        /* Atheros AR5BBU12 with sflash firmware */=0A=
        { USB_DEVICE(0x0489, 0xe02c), .driver_info =3D BTUSB_IGNORE },=0A=
--=0A=
1.7.9.5=0A=
=0A=
