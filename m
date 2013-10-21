Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 11/11] android: Implement core service functionality
Date: Mon, 21 Oct 2013 20:56:51 +0200
Message-Id: <1382381811-28123-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
References: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to register and unregister of services.
---
 android/main.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/android/main.c b/android/main.c
index 72a1272..9bf2aea 100644
--- a/android/main.c
+++ b/android/main.c
@@ -64,6 +64,57 @@ static GIOChannel *hal_notif_io = NULL;
 
 static volatile sig_atomic_t __terminated = 0;
 
+static bool services[HAL_SERVICE_ID_MAX + 1] = {false};
+
+static void service_register(void *buf, uint16_t len)
+{
+	struct hal_msg_cmd_register_module *m = buf;
+
+	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id]) {
+		ipc_send_error(hal_cmd_io, HAL_SERVICE_ID_CORE, 0x01);
+		return;
+	}
+
+	services[m->service_id] = true;
+
+	ipc_send(hal_cmd_io, HAL_SERVICE_ID_CORE, HAL_MSG_OP_REGISTER_MODULE, 0,
+								NULL, -1);
+
+	info("Service ID=%u registered", m->service_id);
+}
+
+static void service_unregister(void *buf, uint16_t len)
+{
+	struct hal_msg_cmd_unregister_module *m = buf;
+
+	if (m->service_id > HAL_SERVICE_ID_MAX || !services[m->service_id]) {
+		ipc_send_error(hal_cmd_io, HAL_SERVICE_ID_CORE, 0x01);
+		return;
+	}
+
+	services[m->service_id] = false;
+
+	ipc_send(hal_cmd_io, HAL_SERVICE_ID_CORE, HAL_MSG_OP_UNREGISTER_MODULE,
+								0, NULL, -1);
+
+	info("Service ID=%u unregistered", m->service_id);
+}
+
+static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
+{
+	switch (opcode) {
+	case HAL_MSG_OP_REGISTER_MODULE:
+		service_register(buf, len);
+		break;
+	case HAL_MSG_OP_UNREGISTER_MODULE:
+		service_unregister(buf, len);
+		break;
+	default:
+		ipc_send_error(hal_cmd_io, HAL_SERVICE_ID_CORE, 0x01);
+		break;
+	}
+}
+
 static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -97,6 +148,9 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	switch (msg->service_id) {
+	case HAL_SERVICE_ID_CORE:
+		handle_service_core(msg->opcode, buf + sizeof(*msg), msg->len);
+		break;
 	default:
 		ipc_send_error(hal_cmd_io, msg->service_id, 0x01);
 		break;
-- 
1.8.4

