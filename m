Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/6] android: Add support for  registering and unregistering hid service
Date: Wed, 23 Oct 2013 13:04:41 +0200
Message-ID: <1382526281-19711-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
References: <1382526281-19711-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hid.c  | 21 +++++++++++++++++++++
 android/hid.h  |  3 +++
 android/main.c |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/android/hid.c b/android/hid.c
index 31de20d..2c74352 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -22,14 +22,18 @@
  */
 
 #include <stdint.h>
+#include <stdbool.h>
 
 #include <glib.h>
 
+#include "lib/bluetooth.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "ipc.h"
 #include "hid.h"
 
+static GIOChannel *notification_io = NULL;
+
 void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 {
 	uint8_t status = HAL_ERROR_FAILED;
@@ -46,3 +50,20 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 
 	ipc_send_error(io, HAL_SERVICE_ID_HIDHOST, status);
 }
+
+bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr)
+{
+	DBG("");
+
+	notification_io = g_io_channel_ref(io);
+
+	return true;
+}
+
+void bt_hid_unregister(void)
+{
+	DBG("");
+
+	g_io_channel_unref(notification_io);
+	notification_io = NULL;
+}
diff --git a/android/hid.h b/android/hid.h
index 1247488..674b35a 100644
--- a/android/hid.h
+++ b/android/hid.h
@@ -22,3 +22,6 @@
  */
 
 void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len);
+
+bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr);
+void bt_hid_unregister(void);
diff --git a/android/main.c b/android/main.c
index e8b584d..edcca73 100644
--- a/android/main.c
+++ b/android/main.c
@@ -88,6 +88,11 @@ static void service_register(void *buf, uint16_t len)
 			goto error;
 
 		break;
+	case HAL_SERVICE_ID_HIDHOST:
+		if (!bt_hid_register(hal_notif_io, bt_adapter_get_address()))
+			goto error;
+
+		break;
 	default:
 		DBG("service %u not supported", m->service_id);
 		goto error;
@@ -118,6 +123,9 @@ static void service_unregister(void *buf, uint16_t len)
 	case HAL_SERVICE_ID_SOCK:
 		bt_socket_unregister();
 		break;
+	case HAL_SERVICE_ID_HIDHOST:
+		bt_hid_unregister();
+		break;
 	default:
 		/* This would indicate bug in HAL, as unregister should not be
 		 * called in init failed */
-- 
1.8.4

