Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] android: Add support for registering "bluetooth" service
Date: Wed, 23 Oct 2013 13:04:38 +0200
Message-ID: <1382526281-19711-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
References: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 19 +++++++++++++++++++
 android/adapter.h |  3 +++
 android/main.c    |  8 ++++++++
 3 files changed, 30 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index de3660d..059a5be 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -33,6 +33,8 @@
 #include "ipc.h"
 #include "adapter.h"
 
+static GIOChannel *notification_io = NULL;
+
 struct bt_adapter {
 	uint16_t index;
 	struct mgmt *mgmt;
@@ -361,3 +363,20 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 
 	ipc_send_error(io, HAL_SERVICE_ID_BLUETOOTH, status);
 }
+
+bool bt_adapter_register(GIOChannel *io)
+{
+	DBG("");
+
+	notification_io = g_io_channel_ref(io);
+
+	return true;
+}
+
+void bt_adapter_unregister(void)
+{
+	DBG("");
+
+	g_io_channel_unref(notification_io);
+	notification_io = NULL;
+}
diff --git a/android/adapter.h b/android/adapter.h
index bfd4932..194950b 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -37,3 +37,6 @@ bool bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 
 void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 								uint16_t len);
+
+bool bt_adapter_register(GIOChannel *io);
+void bt_adapter_unregister(void);
diff --git a/android/main.c b/android/main.c
index 73ff3ee..b18b8d4 100644
--- a/android/main.c
+++ b/android/main.c
@@ -76,6 +76,11 @@ static void service_register(void *buf, uint16_t len)
 		goto error;
 
 	switch (m->service_id) {
+	case HAL_SERVICE_ID_BLUETOOTH:
+		if (!bt_adapter_register(hal_notif_io))
+			goto error;
+
+		break;
 	default:
 		DBG("service %u not supported", m->service_id);
 		goto error;
@@ -100,6 +105,9 @@ static void service_unregister(void *buf, uint16_t len)
 		goto error;
 
 	switch (m->service_id) {
+	case HAL_SERVICE_ID_BLUETOOTH:
+		bt_adapter_unregister();
+		break;
 	default:
 		/* This would indicate bug in HAL, as unregister should not be
 		 * called in init failed */
-- 
1.8.4

