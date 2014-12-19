Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] emulator: Remove dead code
Date: Fri, 19 Dec 2014 15:03:13 +0200
Message-Id: <1418994193-7070-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove logically dead code and fix magic numbers
---
 emulator/le.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/emulator/le.c b/emulator/le.c
index 91cf31c..ec486a9 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -1279,21 +1279,14 @@ static void cmd_le_write_default_data_length(struct bt_le *hci,
 	tx_time = le16_to_cpu(cmd->tx_time);
 
 	/* Valid range for suggested max TX octets is 0x001b to 0x00fb */
-	if (tx_len < 0x001b || tx_len > 0x00fb) {
+	if (tx_len < DEFAULT_TX_LEN || tx_len > MAX_TX_LEN) {
 		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
 				BT_HCI_CMD_LE_WRITE_DEFAULT_DATA_LENGTH);
 		return;
 	}
 
 	/* Valid range for suggested max TX time is 0x0148 to 0x0848 */
-	if (tx_time < 0x0148 || tx_time > 0x0848) {
-		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
-				BT_HCI_CMD_LE_WRITE_DEFAULT_DATA_LENGTH);
-		return;
-	}
-
-	/* Suggested max TX len and time shall be less or equal supported */
-	if (tx_len > MAX_TX_LEN || tx_time > MAX_TX_TIME) {
+	if (tx_time < DEFAULT_TX_TIME || tx_time > MAX_TX_TIME) {
 		cmd_status(hci, BT_HCI_ERR_INVALID_PARAMETERS,
 				BT_HCI_CMD_LE_WRITE_DEFAULT_DATA_LENGTH);
 		return;
-- 
2.1.0

