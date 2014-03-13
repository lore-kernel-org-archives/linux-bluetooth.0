Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [RFC 1/8] android/gatt: Use queue and stdlib instead of glib
Date: Thu, 13 Mar 2014 19:46:08 +0100
Message-ID: <1394736375-22599-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

This patch changes using glib to queues, stdlib operators.
---
 android/gatt.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a874737..9ac89fb 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -37,6 +37,7 @@
 #include "src/log.h"
 #include "hal-msg.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 struct gatt_client {
 	int32_t id;
@@ -45,22 +46,22 @@ struct gatt_client {
 
 static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
-static GSList *gatt_clients = NULL;
+static struct queue *gatt_clients = NULL;
 
-static int find_client_by_uuid(gconstpointer data, gconstpointer user_data)
+static bool find_client_by_uuid(const void *data, const void *user_data)
 {
 	const uint8_t *exp_uuid = user_data;
 	const struct gatt_client *client = data;
 
-	return memcmp(exp_uuid, client->uuid, sizeof(client->uuid));
+	return !memcmp(exp_uuid, client->uuid, sizeof(client->uuid));
 }
 
-static int find_client_by_id(gconstpointer data, gconstpointer user_data)
+static bool find_client_by_id(const void *data, const void *user_data)
 {
 	int32_t exp_id = PTR_TO_INT(user_data);
 	const struct gatt_client *client = data;
 
-	return client->id != exp_id;
+	return client->id == exp_id;
 }
 
 static void handle_client_register(const void *buf, uint16_t len)
@@ -79,19 +80,19 @@ static void handle_client_register(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (g_slist_find_custom(gatt_clients, &cmd->uuid,
-							find_client_by_uuid)) {
+	if (queue_find(gatt_clients, find_client_by_uuid, &cmd->uuid)) {
 		error("gatt: client uuid is already on list");
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
-	client = g_new0(struct gatt_client, 1);
+	client = (struct gatt_client *) new0(struct gatt_client, 1);
+
 	memcpy(client->uuid, cmd->uuid, sizeof(client->uuid));
 
 	client->id = client_cnt++;
 
-	gatt_clients = g_slist_prepend(gatt_clients, client);
+	queue_push_head(gatt_clients, client);
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -110,21 +111,20 @@ failed:
 static void handle_client_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_unregister *cmd = buf;
-	GSList *l;
 	uint8_t status;
+	struct gatt_client *cl;
 
 	DBG("");
 
-	l = g_slist_find_custom(gatt_clients, INT_TO_PTR(cmd->client_if),
-							find_client_by_id);
-	if (!l) {
+	cl = queue_remove_if(gatt_clients, find_client_by_id,
+						INT_TO_PTR(cmd->client_if));
+	if (!cl) {
 		error("gatt: client_if=%d not found", cmd->client_if);
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
-	gatt_clients = g_slist_remove(gatt_clients, l->data);
-
+	free(cl);
 	status = HAL_STATUS_SUCCESS;
 
 failed:
@@ -524,6 +524,12 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	ipc_register(hal_ipc, HAL_SERVICE_ID_GATT, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
+	gatt_clients = queue_new();
+	if (!gatt_clients) {
+		error("gatt: Cannot allocate gatt_clients");
+		return false;
+	}
+
 	return true;
 }
 
@@ -531,6 +537,8 @@ void bt_gatt_unregister(void)
 {
 	DBG("");
 
+	queue_destroy(gatt_clients, free);
+
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_GATT);
 	hal_ipc = NULL;
 }
-- 
1.8.4

