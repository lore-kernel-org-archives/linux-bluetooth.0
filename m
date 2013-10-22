Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] android: Add initial code for handling adapter commands
Date: Tue, 22 Oct 2013 18:47:52 +0200
Message-Id: <1382460476-6604-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
References: <1382460476-6604-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No commands are handled yet.
---
 android/adapter.c | 14 ++++++++++++++
 android/adapter.h |  3 +++
 android/main.c    |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index cae3187..f891bc2 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -23,10 +23,14 @@
 
 #include <errno.h>
 
+#include <glib.h>
+
 #include "lib/bluetooth.h"
 #include "src/shared/mgmt.h"
 #include "lib/mgmt.h"
 #include "log.h"
+#include "hal-msg.h"
+#include "ipc.h"
 #include "adapter.h"
 
 struct bt_adapter {
@@ -285,3 +289,13 @@ bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 
 	return adapter;
 }
+
+void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
+								uint16_t len)
+{
+	switch (opcode) {
+	default:
+		ipc_send_error(io, HAL_SERVICE_ID_CORE, HAL_ERROR_FAILED);
+		break;
+	}
+}
diff --git a/android/adapter.h b/android/adapter.h
index d8ad191..bfd4932 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -34,3 +34,6 @@ typedef void (*bt_adapter_ready)(struct bt_adapter *adapter, int err);
 
 bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 						bt_adapter_ready func);
+
+void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
+								uint16_t len);
diff --git a/android/main.c b/android/main.c
index d4916ca..f3e2baa 100644
--- a/android/main.c
+++ b/android/main.c
@@ -155,6 +155,10 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 	case HAL_SERVICE_ID_CORE:
 		handle_service_core(msg->opcode, buf + sizeof(*msg), msg->len);
 		break;
+	case HAL_SERVICE_ID_BLUETOOTH:
+		bt_adapter_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
+								msg->len);
+		break;
 	default:
 		ipc_send_error(hal_cmd_io, msg->service_id, HAL_ERROR_FAILED);
 		break;
-- 
1.8.4

