Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 3/5] android: Add initial sdp implementation
Date: Mon, 28 Oct 2013 13:30:07 +0100
Message-ID: <1382963409-1012-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1382963409-1012-1-git-send-email-marcin.kraglak@tieto.com>
References: <1382963409-1012-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add and remove records to sdp server. This api will
be used in android's profiles implementations.
---
 android/adapter.c | 12 ++++++++++++
 android/adapter.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 80a9e6d..a14c2a4 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -26,8 +26,10 @@
 #include <glib.h>
 
 #include "lib/bluetooth.h"
+#include "src/sdpd.h"
 #include "src/shared/mgmt.h"
 #include "lib/mgmt.h"
+#include "lib/sdp.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "ipc.h"
@@ -527,6 +529,16 @@ error:
 	ipc_send_rsp(io, HAL_SERVICE_ID_BLUETOOTH, status);
 }
 
+int bt_adapter_service_add(sdp_record_t *rec)
+{
+	return add_record_to_server(&adapter->bdaddr, rec);
+}
+
+void bt_adapter_service_remove(uint32_t handle)
+{
+	remove_record_from_server(handle);
+}
+
 const bdaddr_t *bt_adapter_get_address(void)
 {
 	return &adapter->bdaddr;
diff --git a/android/adapter.h b/android/adapter.h
index 2afc67a..1726f18 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -38,5 +38,8 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 
 const bdaddr_t *bt_adapter_get_address(void);
 
+int bt_adapter_service_add(sdp_record_t *rec);
+void bt_adapter_service_remove(uint32_t handle);
+
 bool bt_adapter_register(GIOChannel *io);
 void bt_adapter_unregister(void);
-- 
1.8.2.2

