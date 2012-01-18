Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/15] Bluetooth: Add missing EIR defines to hci.h
Date: Wed, 18 Jan 2012 20:51:47 +0200
Message-Id: <1326912717-6347-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds missing EIR defines (as specified in the Bluetooth
Assigned Numbers document) to hci.h.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8499307..dd2cc6c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -296,6 +296,9 @@ enum {
 #define EIR_NAME_SHORT		0x08 /* shortened local name */
 #define EIR_NAME_COMPLETE	0x09 /* complete local name */
 #define EIR_TX_POWER		0x0A /* transmit power level */
+#define EIR_CLASS_OF_DEV	0x0D /* Class of Device */
+#define EIR_SSP_HASH_C		0x0E /* Simple Pairing Hash C */
+#define EIR_SSP_RAND_R		0x0F /* Simple Pairing Randomizer R */
 #define EIR_DEVICE_ID		0x10 /* device ID */
 
 /* -----  HCI Commands ---- */
-- 
1.7.8.3

