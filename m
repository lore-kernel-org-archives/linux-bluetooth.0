Return-Path: <ian@mnementh.co.uk>
From: Ian Molton <ian@mnementh.co.uk>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	loic.poulain@intel.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: Add entry for BCM43430 UART bluetooth
Date: Wed, 28 Jun 2017 20:10:55 +0100
Message-Id: <20170628191055.1283-1-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

	This patch adds the device ID for the bluetooth chip used in the
Broadcom BCM43430 SDIO WiFi / UART BT chip.

	Successfully tested using Firmware version 0x0182

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
Reported-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index ba3dd2eafc09..f4cd4f44cee4 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -274,6 +274,7 @@ static const struct {
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
+	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */
 	{ }
 };
 
-- 
2.11.0
