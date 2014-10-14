Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] android/map-client: Add stubs for MAP client commands handlers
Date: Tue, 14 Oct 2014 13:24:32 +0200
Message-Id: <1413285875-17814-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413285875-17814-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413285875-17814-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add empty handlers for MAP client IPC commands.
---
 android/map-client.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/android/map-client.c b/android/map-client.c
index 4556461..142c680 100644
--- a/android/map-client.c
+++ b/android/map-client.c
@@ -28,17 +28,49 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdint.h>
+#include <glib.h>
 
 #include "ipc.h"
 #include "lib/bluetooth.h"
 #include "map-client.h"
+#include "src/log.h"
+#include "hal-msg.h"
+
+static struct ipc *hal_ipc = NULL;
+static bdaddr_t adapter_addr;
+
+static void handle_get_instances(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_MAP_CLIENT,
+			HAL_OP_MAP_CLIENT_GET_INSTANCES, HAL_STATUS_FAILED);
+}
+
+static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_MAP_CLIENT_GET_INSTANCES */
+	{ handle_get_instances, false,
+			sizeof(struct hal_cmd_map_client_get_instances) },
+};
 
 bool bt_map_client_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
-	return false;
+	DBG("");
+
+	bacpy(&adapter_addr, addr);
+
+	hal_ipc = ipc;
+
+	ipc_register(hal_ipc, HAL_SERVICE_ID_MAP_CLIENT, cmd_handlers,
+						G_N_ELEMENTS(cmd_handlers));
+
+	return true;
 }
 
 void bt_map_client_unregister(void)
 {
+	DBG("");
 
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_MAP_CLIENT);
+	hal_ipc = NULL;
 }
-- 
1.9.3

