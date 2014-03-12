Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/2] android/gatt: Handle Unregister gatt client command
Date: Wed, 12 Mar 2014 10:27:38 +0100
Message-Id: <1394616458-5212-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1394616458-5212-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1394616458-5212-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds unregister gatt client app command handling.
---
 android/gatt.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 34549dd..a874737 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -36,6 +36,7 @@
 #include "gatt.h"
 #include "src/log.h"
 #include "hal-msg.h"
+#include "src/shared/util.h"
 
 struct gatt_client {
 	int32_t id;
@@ -54,6 +55,14 @@ static int find_client_by_uuid(gconstpointer data, gconstpointer user_data)
 	return memcmp(exp_uuid, client->uuid, sizeof(client->uuid));
 }
 
+static int find_client_by_id(gconstpointer data, gconstpointer user_data)
+{
+	int32_t exp_id = PTR_TO_INT(user_data);
+	const struct gatt_client *client = data;
+
+	return client->id != exp_id;
+}
+
 static void handle_client_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_register *cmd = buf;
@@ -100,10 +109,27 @@ failed:
 
 static void handle_client_unregister(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_unregister *cmd = buf;
+	GSList *l;
+	uint8_t status;
+
 	DBG("");
 
+	l = g_slist_find_custom(gatt_clients, INT_TO_PTR(cmd->client_if),
+							find_client_by_id);
+	if (!l) {
+		error("gatt: client_if=%d not found", cmd->client_if);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	gatt_clients = g_slist_remove(gatt_clients, l->data);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_UNREGISTER, HAL_STATUS_FAILED);
+					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
 
 static void handle_client_scan(const void *buf, uint16_t len)
-- 
1.8.5.2

