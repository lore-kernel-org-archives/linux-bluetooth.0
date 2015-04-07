Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Update SSP OOB data EIR definitions
Date: Tue,  7 Apr 2015 21:52:21 +0300
Message-Id: <1428432742-32748-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since Bluetooth 4.1 there are two additional values for SSP OOB data,
namely C-256 and R-256. This patch updates the EIR definitions to take
into account both the 192 and 256 bit variants of C and R.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3acecf35420b..2f8c830e600c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -463,12 +463,14 @@ enum {
 #define EIR_NAME_COMPLETE	0x09 /* complete local name */
 #define EIR_TX_POWER		0x0A /* transmit power level */
 #define EIR_CLASS_OF_DEV	0x0D /* Class of Device */
-#define EIR_SSP_HASH_C		0x0E /* Simple Pairing Hash C */
-#define EIR_SSP_RAND_R		0x0F /* Simple Pairing Randomizer R */
+#define EIR_SSP_HASH_C192	0x0E /* Simple Pairing Hash C-192 */
+#define EIR_SSP_RAND_R192	0x0F /* Simple Pairing Randomizer R-192 */
 #define EIR_DEVICE_ID		0x10 /* device ID */
 #define EIR_APPEARANCE		0x19 /* Device appearance */
 #define EIR_LE_BDADDR		0x1B /* LE Bluetooth device address */
 #define EIR_LE_ROLE		0x1C /* LE role */
+#define EIR_SSP_HASH_C256	0x1D /* Simple Pairing Hash C-256 */
+#define EIR_SSP_RAND_R256	0x1E /* Simple Pairing Rand R-256 */
 #define EIR_LE_SC_CONFIRM	0x22 /* LE SC Confirmation Value */
 #define EIR_LE_SC_RANDOM	0x23 /* LE SC Random Value */
 
-- 
2.1.0

