Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] android: Fix delayed adapter turn off
Date: Fri,  6 Dec 2013 16:30:54 +0100
Message-Id: <1386343854-1529-1-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We shouldn't care about pending actions being completed as we want to
turn BT off. This fixes Android UI controlls being locked when BT off
action waits in queue for to long.

---
 android/bluetooth.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6174b1f..e5d8b7a 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1290,17 +1290,24 @@ static void set_mode_complete(uint8_t status, uint16_t length,
 	new_settings_callback(adapter.index, length, param, NULL);
 }
 
-static bool set_mode(uint16_t opcode, uint8_t mode)
+static bool set_mode(uint16_t opcode, uint8_t mode, bool unqueued)
 {
 	struct mgmt_mode cp;
+	unsigned int mgmt_result;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.val = mode;
 
 	DBG("opcode=0x%x mode=0x%x", opcode, mode);
 
-	if (mgmt_send(mgmt_if, opcode, adapter.index, sizeof(cp), &cp,
-					set_mode_complete, NULL, NULL) > 0)
+	if (unqueued)
+		mgmt_result = mgmt_reply(mgmt_if, opcode, adapter.index,
+				sizeof(cp), &cp, set_mode_complete, NULL, NULL);
+	else
+		mgmt_result = mgmt_send(mgmt_if, opcode, adapter.index,
+				sizeof(cp), &cp, set_mode_complete, NULL, NULL);
+
+	if (mgmt_result > 0)
 		return true;
 
 	error("Failed to set mode");
@@ -1462,10 +1469,10 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	missing_settings = adapter.current_settings ^ supported_settings;
 
 	if (missing_settings & MGMT_SETTING_SSP)
-		set_mode(MGMT_OP_SET_SSP, 0x01);
+		set_mode(MGMT_OP_SET_SSP, 0x01, false);
 
 	if (missing_settings & MGMT_SETTING_PAIRABLE)
-		set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
+		set_mode(MGMT_OP_SET_PAIRABLE, 0x01, false);
 
 	return;
 
@@ -1926,7 +1933,8 @@ static uint8_t set_scan_mode(const void *buf, uint16_t len)
 	}
 
 	if (cur_conn != conn) {
-		if (!set_mode(MGMT_OP_SET_CONNECTABLE, conn ? 0x01 : 0x00))
+		if (!set_mode(MGMT_OP_SET_CONNECTABLE, conn ? 0x01 : 0x00,
+									false))
 			return HAL_STATUS_FAILED;
 	}
 
@@ -2234,7 +2242,7 @@ static void handle_enable_cmd(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (!set_mode(MGMT_OP_SET_POWERED, 0x01)) {
+	if (!set_mode(MGMT_OP_SET_POWERED, 0x01, false)) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -2253,7 +2261,11 @@ static void handle_disable_cmd(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (!set_mode(MGMT_OP_SET_POWERED, 0x00)) {
+	/*
+	 * Prioritize BT turn off as not doing it in time makes Android
+	 * unstable and locks Bluetooth UI controlls.
+	 */
+	if (!set_mode(MGMT_OP_SET_POWERED, 0x00, true)) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
-- 
1.8.5

