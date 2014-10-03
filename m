Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/6] android/hal-map-client: Add API calls
Date: Fri,  3 Oct 2014 16:04:04 +0200
Message-Id: <1412345044-30259-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412345044-30259-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412345044-30259-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send API calls data using IPC.
---
 android/hal-map-client.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/hal-map-client.c b/android/hal-map-client.c
index 606c8c0..2ee574e 100644
--- a/android/hal-map-client.c
+++ b/android/hal-map-client.c
@@ -17,6 +17,7 @@
 
 #include <stdlib.h>
 #include <stdbool.h>
+#include <string.h>
 
 #include "hal-log.h"
 #include "hal.h"
@@ -99,7 +100,16 @@ static const struct hal_ipc_handler ev_handlers[] = {
 
 static bt_status_t get_remote_mas_instances(bt_bdaddr_t *bd_addr)
 {
-	return BT_STATUS_UNSUPPORTED;
+	struct hal_cmd_map_client_get_instances cmd;
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(*bd_addr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_MAP_CLIENT,
+				HAL_OP_MAP_CLIENT_GET_INSTANCES, sizeof(cmd),
+				&cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t init(btmce_callbacks_t *callbacks)
-- 
1.9.3

