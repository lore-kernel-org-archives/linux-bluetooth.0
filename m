Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/6] adapter: Implement adapter enable and disable commands
Date: Tue, 22 Oct 2013 18:47:56 +0200
Message-Id: <1382460476-6604-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
References: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to enable and disable adapter.
---
 android/adapter.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index 5621e67..1a3e3f4 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -290,12 +290,74 @@ bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 	return adapter;
 }
 
+static void set_mode_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to set mode: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	/*
+	 * The parameters are identical and also the task that is
+	 * required in both cases. So it is safe to just call the
+	 * event handling functions here.
+	 */
+	new_settings_callback(default_adapter->index, length, param,
+							default_adapter);
+}
+
+static bool set_mode(uint16_t opcode, uint8_t mode)
+{
+	struct mgmt_mode cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.val = mode;
+
+	DBG("opcode=0x%x mode=0x%x", opcode, mode);
+
+	if (mgmt_send(default_adapter->mgmt, opcode, default_adapter->index,
+			sizeof(cp), &cp, set_mode_complete, NULL, NULL) > 0)
+		return true;
+
+	error("Failed to set mode");
+
+	return false;
+}
+
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len)
 {
+	uint8_t status = HAL_ERROR_FAILED;
+
 	switch (opcode) {
+	case HAL_MSG_OP_BT_ENABLE:
+		if (default_adapter->current_settings & MGMT_SETTING_POWERED) {
+			status = HAL_ERROR_DONE;
+			break;
+		}
+
+		if (set_mode(MGMT_OP_SET_POWERED, 0x01)) {
+			ipc_send(io, HAL_SERVICE_ID_CORE, opcode, 0, NULL, -1);
+			return;
+		}
+		break;
+	case HAL_MSG_OP_BT_DISABLE:
+		if (!(default_adapter->current_settings & MGMT_SETTING_POWERED)) {
+			status = HAL_ERROR_DONE;
+			break;
+		}
+
+		if (set_mode(MGMT_OP_SET_POWERED, 0x00)) {
+			ipc_send(io, HAL_SERVICE_ID_CORE, opcode, 0, NULL, -1);
+			return;
+		}
+		break;
 	default:
-		ipc_send_error(io, HAL_SERVICE_ID_BLUETOOTH, HAL_ERROR_FAILED);
+		DBG("Unhandled command, opcode 0x%x", opcode);
 		break;
 	}
+
+	ipc_send_error(io, HAL_SERVICE_ID_BLUETOOTH, status);
 }
-- 
1.8.4

