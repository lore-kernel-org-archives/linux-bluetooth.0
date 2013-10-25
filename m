Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] android: Add support for setting adapter scan mode
Date: Fri, 25 Oct 2013 17:15:01 +0200
Message-ID: <1382714103-27689-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
References: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to set all modes defined: none, connectable and
'connectable and discoverable'.
---
 android/adapter.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index 13cce8f..a6c5704 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -322,6 +322,26 @@ static bool set_mode(uint16_t opcode, uint8_t mode)
 	return false;
 }
 
+static bool set_discoverable(uint8_t mode, uint16_t timeout)
+{
+	struct mgmt_cp_set_discoverable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.val = mode;
+	cp.timeout = htobs(timeout);
+
+	DBG("mode %u timeout %u", mode, timeout);
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_DISCOVERABLE,
+				adapter->index, sizeof(cp), &cp,
+				set_mode_complete, adapter, NULL) > 0)
+		return true;
+
+	error("Failed to set mode discoverable");
+
+	return false;
+}
+
 static void send_adapter_name(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
@@ -365,13 +385,64 @@ static bool get_property(void *buf, uint16_t len)
 	}
 }
 
+static uint8_t set_scan_mode(void *buf, uint16_t len)
+{
+	uint8_t *mode = buf;
+	bool conn, disc, cur_conn, cur_disc;
+
+	cur_conn = adapter->current_settings & MGMT_SETTING_CONNECTABLE;
+	cur_disc = adapter->current_settings & MGMT_SETTING_DISCOVERABLE;
+
+	DBG("connectable %u discoverable %d mode %u", cur_conn, cur_disc,
+								*mode);
+
+	switch (*mode) {
+	case HAL_ADAPTER_SCAN_MODE_NONE:
+		if (!cur_conn && !cur_disc)
+			return HAL_STATUS_DONE;
+
+		conn = false;
+		disc = false;
+		break;
+	case HAL_ADAPTER_SCAN_MODE_CONN:
+		if (cur_conn && !cur_disc)
+			return HAL_STATUS_DONE;
+
+		conn = true;
+		disc = false;
+		break;
+	case HAL_ADAPTER_SCAN_MODE_CONN_DISC:
+		if (cur_conn && cur_disc)
+			return HAL_STATUS_DONE;
+
+		conn = true;
+		disc = true;
+		break;
+	default:
+		return HAL_STATUS_FAILED;
+	}
+
+	if (cur_conn != conn) {
+		if (!set_mode(MGMT_OP_SET_CONNECTABLE, conn ? 0x01 : 0x00))
+			return HAL_STATUS_FAILED;
+	}
+
+	if (cur_disc != disc) {
+		if (!set_discoverable(disc ? 0x01 : 0x00, 0))
+			return HAL_STATUS_FAILED;
+	}
+
+	return HAL_STATUS_SUCCESS;
+}
+
 static uint8_t set_property(void *buf, uint16_t len)
 {
 	struct hal_cmd_set_adapter_prop *cmd = buf;
 
 	switch (cmd->type) {
-	case HAL_PROP_ADAPTER_NAME:
 	case HAL_PROP_ADAPTER_SCAN_MODE:
+		return set_scan_mode(cmd->val, cmd->len);
+	case HAL_PROP_ADAPTER_NAME:
 	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
 	default:
 		DBG("Unhandled property type 0x%x", cmd->type);
-- 
1.8.4.1

