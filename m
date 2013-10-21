Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/3] android/hal: Register adapter and socket interface on HAL init
Date: Mon, 21 Oct 2013 14:56:51 +0200
Message-Id: <1382360211-3565-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382360211-3565-1-git-send-email-szymon.janc@tieto.com>
References: <1382360211-3565-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After daemon is started HAL needs to register those two interfaces
to performe initialization procedure as described in IPC documentation.
---
 android/hal-bluetooth.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 3d3023f..c1e0261 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -257,6 +257,9 @@ static void stop_daemon(void)
 
 static int init(bt_callbacks_t *callbacks)
 {
+	struct hal_msg_cmd_register_module cmd;
+	struct hal_msg_rsp_error rsp;
+
 	DBG("");
 
 	if (interface_ready())
@@ -267,7 +270,27 @@ static int init(bt_callbacks_t *callbacks)
 
 	bt_hal_cbacks = callbacks;
 
+	cmd.service_id = HAL_SERVICE_ID_BLUETOOTH;
+
+	if (hal_send_msg(HAL_SERVICE_ID_CORE, HAL_MSG_OP_REGISTER_MODULE,
+						sizeof(cmd), &cmd,
+						sizeof(rsp), &rsp, NULL) < 0)
+		 goto fail;
+
+	cmd.service_id = HAL_SERVICE_ID_SOCK;
+
+	if (hal_send_msg(HAL_SERVICE_ID_CORE, HAL_MSG_OP_REGISTER_MODULE,
+						sizeof(cmd), &cmd,
+						sizeof(rsp), &rsp, NULL) < 0)
+		 goto fail;
+
 	return BT_STATUS_SUCCESS;
+
+fail:
+	stop_daemon();
+	bt_hal_cbacks = NULL;
+	return BT_STATUS_FAIL;
+
 }
 
 static int enable(void)
-- 
1.8.4

