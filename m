Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: How to handle multiple firmwares for 0x2209 device?
Message-Id: <799A0BE4-CF46-4656-9AD3-60D9E8E92849@gmail.com>
Date: Fri, 7 Sep 2018 07:48:02 +0400
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Khadas VIM(1) SBC uses an AMPAK AP6212 module with device ID 0x2209; =
resulting in BCM43430A1 firmware being loaded (as per current code) =
instead of BCM43438A1 which is needed for the BT module to work. The =
following patch is required:

--- a/drivers/bluetooth/btbcm.c	2018-07-09 00:34:02.000000000 +0100
+++ b/drivers/bluetooth/btbcm.c	2018-07-12 11:38:12.323462430 +0100
@@ -326,7 +326,7 @@ static const struct bcm_subver_table bcm
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
 	{ 0x2122, "BCM4343A0"	},	/* 001.001.034 */
-	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */
+	{ 0x2209, "BCM43438A1"  },	/* 001.002.009 */
 	{ 0x6119, "BCM4345C0"	},	/* 003.001.025 */
 	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
 	{ }

I=E2=80=99m not versed in the minutiae of these firmwares. Is BCM43438A1 =
simply a newer version of firmware that could be used by all devices =
(and the above patch can be submitted to effect the change) .. or is =
something more complicated required?

BCM43438A1 firmware: =
(https://github.com/chewitt/brcmfmac_sdio-firmware-aml)

[    9.447310] Bluetooth: hci0: BCM: chip id 94
[    9.449226] Bluetooth: hci0: BCM: features 0x2e
[    9.471969] Bluetooth: hci0: BCM43430A1
[    9.471983] Bluetooth: hci0: BCM43438A1 (001.002.009) build 0000
[   12.946499] Bluetooth: hci0: BCM43438A1 (001.002.009) build 0106

hci0:	Type: Primary  Bus: UART
	BD Address: CC:B8:A8:B5:9F:87  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING=20
	RX bytes:2265 acl:0 sco:0 events:216 errors:0
	TX bytes:36326 acl:0 sco:0 commands:214 errors:0
	Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
	Link policy: RSWITCH SNIFF=20
	Link mode: SLAVE ACCEPT=20
	Name: 'LibreELEC'
	Class: 0x0c0000
	Service Classes: Rendering, Capturing
	Device Class: Miscellaneous,=20
	HCI Version: 4.0 (0x6)  Revision: 0x6a
	LMP Version: 4.0 (0x6)  Subversion: 0x2209
	Manufacturer: Broadcom Corporation (15)

Christian=
