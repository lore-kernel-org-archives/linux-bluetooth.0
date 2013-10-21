Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 03/11] android/hal: Register adapter and socket interface on HAL init
Date: Mon, 21 Oct 2013 20:56:43 +0200
Message-Id: <1382381811-28123-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
References: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After daemon is started HAL needs to register those two interfaces
to performe initialization procedure as described in IPC documentation.
---
 android/hal-bluetooth.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index b9a78b6..f408a7d 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -39,6 +39,9 @@ static bool interface_ready(void)
 
 static int init(bt_callbacks_t *callbacks)
 {
+	struct hal_msg_cmd_register_module cmd;
+	struct hal_msg_rsp_error rsp;
+
 	DBG("");
 
 	if (interface_ready())
@@ -49,7 +52,32 @@ static int init(bt_callbacks_t *callbacks)
 
 	bt_hal_cbacks = callbacks;
 
+	cmd.service_id = HAL_SERVICE_ID_BLUETOOTH;
+
+	if (hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_MSG_OP_REGISTER_MODULE,
+						sizeof(cmd), &cmd,
+						sizeof(rsp), &rsp, NULL) < 0) {
+		error("Failed to register 'bluetooth' service");
+		goto fail;
+	}
+
+	cmd.service_id = HAL_SERVICE_ID_SOCK;
+
+	if (hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_MSG_OP_REGISTER_MODULE,
+						sizeof(cmd), &cmd,
+						sizeof(rsp), &rsp, NULL) < 0) {
+		error("Failed to register 'socket' service");
+		goto fail;
+	}
+
 	return BT_STATUS_SUCCESS;
+
+fail:
+
+	hal_ipc_cleanup();
+	bt_hal_cbacks = NULL;
+	return BT_STATUS_FAIL;
+
 }
 
 static int enable(void)
-- 
1.8.4

