Return-Path: <cyrus@holtmann.org>
From: "Chen, Peng" <pengchen@qca.qualcomm.com>
To: "gustavo@padovan.org" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>
CC: "Waller, Carolyn" <carolyn@qca.qualcomm.com>, "Jeang, Daniel"
	<dyjeong@qca.qualcomm.com>, "Shanmugam Kamatchi, Bala"
	<bkamatch@qca.qualcomm.com>, "Yao, Costa" <cqyao@qca.qualcomm.com>, "Fan,
 Hong" <hongfan@qca.qualcomm.com>, "Balasubramanian, Senthil Kumar"
	<senthilb@qca.qualcomm.com>, "Wu, Frank" <fanwu@qca.qualcomm.com>
Subject: [patch]Add Vendor/Device ID for AR3012
Date: Wed, 18 Jul 2012 09:05:05 +0000
Message-ID: <0EC13EFF38B7C84DB595405A8233E35B099AE930@nasanexd01b.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

>From 7340f148e72f2bee78563c0ca9a37d82a5b99d64 Mon Sep 17 00:00:00 2001=0A=
From: Peng Chen <pengchen@qca.qualcomm.com>=0A=
Date: Wed, 18 Jul 2012 16:58:28 +0800=0A=
Subject: [PATCH] [patch]Add Vendor/Device ID for AR3012=0A=
=0A=
Add Vendor/Device ID for Qualcomm Atheros AR3012.=0A=
=0A=
Signed-off-by: Peng Chen <pengchen@qca.qualcomm.com>=0A=
---=0A=
 drivers/bluetooth/ath3k.c |    1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c=0A=
index 10308cd..7ce0aa2 100644=0A=
--- a/drivers/bluetooth/ath3k.c=0A=
+++ b/drivers/bluetooth/ath3k.c=0A=
@@ -79,6 +79,7 @@ static struct usb_device_id ath3k_table[] =3D {=0A=
 	{ USB_DEVICE(0x13d3, 0x3362) },=0A=
 	{ USB_DEVICE(0x0CF3, 0xE004) },=0A=
 	{ USB_DEVICE(0x0930, 0x0219) },=0A=
+	{ USB_DEVICE(0x0489, 0xE057) },=0A=
 =0A=
 	/* Atheros AR5BBU12 with sflash firmware */=0A=
 	{ USB_DEVICE(0x0489, 0xE02C) },=0A=
-- =0A=
1.7.9.5=0A=
=0A=
=0A=
=0A=
=0A=
