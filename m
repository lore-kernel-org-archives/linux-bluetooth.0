Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/hal: Add initial support for handling adapter notifications
Date: Tue, 22 Oct 2013 12:59:09 +0200
Message-Id: <1382439549-18281-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382439549-18281-1-git-send-email-szymon.janc@tieto.com>
References: <1382439549-18281-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only adapter state callback is handled for now.
---
 android/hal-bluetooth.c | 24 ++++++++++++++++++++++++
 android/hal-ipc.c       |  6 ++++++
 android/hal.h           |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 5b07070..37edb41 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -32,6 +32,30 @@
 
 bt_callbacks_t *bt_hal_cbacks = NULL;
 
+static void handle_adapter_state_changed(void *buf)
+{
+	struct hal_msg_ev_bt_adapter_state_changed *ev = buf;
+
+	if (bt_hal_cbacks->adapter_state_changed_cb)
+		bt_hal_cbacks->adapter_state_changed_cb(ev->state);
+}
+
+/* will be called from notification thread context */
+void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len, int fd)
+{
+	if (!bt_hal_cbacks)
+		return;
+
+	switch (opcode) {
+	case HAL_MSG_EV_BT_ADAPTER_STATE_CHANGED:
+		handle_adapter_state_changed(buf);
+		break;
+	default:
+		DBG("Unhandled callback opcode=0x%x", opcode);
+		break;
+	}
+}
+
 static bool interface_ready(void)
 {
 	return bt_hal_cbacks != NULL;
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index ef58a7c..ccdcb9f 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -27,6 +27,9 @@
 
 #include <cutils/properties.h>
 
+#include <hardware/bluetooth.h>
+#include "hal.h"
+
 #include "hal-msg.h"
 #include "hal-log.h"
 #include "hal-ipc.h"
@@ -44,6 +47,9 @@ static pthread_t notif_th = 0;
 static void notification_dispatch(struct hal_msg_hdr *msg, int fd)
 {
 	switch (msg->service_id) {
+	case HAL_SERVICE_ID_BLUETOOTH:
+		bt_notify_adapter(msg->opcode, msg + 1, msg->len, fd);
+		break;
 	default:
 		DBG("Unhandled notification service=%d opcode=0x%x",
 						msg->service_id, msg->opcode);
diff --git a/android/hal.h b/android/hal.h
index d984336..889fce6 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -24,3 +24,5 @@ btsock_interface_t *bt_get_sock_interface(void);
 bthh_interface_t *bt_get_hidhost_interface(void);
 btpan_interface_t *bt_get_pan_interface(void);
 btav_interface_t *bt_get_av_interface(void);
+
+void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len, int fd);
-- 
1.8.4

