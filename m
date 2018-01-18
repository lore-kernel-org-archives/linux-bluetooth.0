Return-Path: <joerg.krause@embedded.rocks>
From: =?UTF-8?q?J=C3=B6rg=20Krause?= <joerg.krause@embedded.rocks>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	=?UTF-8?q?J=C3=B6rg=20Krause?= <joerg.krause@embedded.rocks>
Subject: [PATCH RESEND] Bluetooth: btbcm: Add entry for BCM4343A0 UART bluetooth
Date: Thu, 18 Jan 2018 10:21:55 +0100
Message-Id: <20180118092155.3595-1-joerg.krause@embedded.rocks>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

RESEND using Content-Transfer-Encoding: 8bit instead of base64.

This patch adds the device ID for the bluetooth chip used in the
AMPAK AP6212 WiFi+Bluetooth module. The AP6212 is used on several
BananaPi boards, e.g. M2-Ultra.

The AP6212 is a combo module, where the WiFi chip is identified as
BCM43430A0 whereas the Bluetooth chip identifies itself as 4343A0. Note,
the missing '0' before the 'A0'.

The AP6212 needs a firmware blob. Loading the provided firmware file
from the BananaPi vendor, the adapter name is printed as
'BCM4343A0 26MHz AP6212_CL1-0061':

'''
hci0:	Type: Primary  Bus: UART
	BD Address: 43:43:A0:12:1F:AC  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING
	RX bytes:3076 acl:0 sco:0 events:278 errors:0
	TX bytes:39726 acl:0 sco:0 commands:279 errors:0
	Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy: RSWITCH SNIFF
	Link mode: SLAVE ACCEPT
	Name: 'BCM4343A0 26MHz AP6212_CL1-0061'
	Class: 0x000000
	Service Classes: Unspecified
	Device Class: Miscellaneous,
	HCI Version: 4.1 (0x7)  Revision: 0xf2
	LMP Version: 4.1 (0x7)  Subversion: 0x2122
	Manufacturer: Broadcom Corporation (15)
'''

Signed-off-by: Jörg Krause <joerg.krause@embedded.rocks>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index afa4cb3b16e3..6659f113042c 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -323,6 +323,7 @@ static const struct {
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
+	{ 0x2122, "BCM4343A0"	},	/* 001.001.034 */
 	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */
 	{ 0x6119, "BCM4345C0"	},	/* 003.001.025 */
 	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
-- 
2.15.1
