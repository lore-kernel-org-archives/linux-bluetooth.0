Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] android/gatt: Handle Unregister gatt client command
Date: Mon, 10 Mar 2014 12:19:04 +0100
Message-Id: <1394450344-32472-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1394450344-32472-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1394450344-32472-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds unregister gatt client app command handling.
---
 android/gatt.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 084ba7f..9ea82fb 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -54,6 +54,14 @@ static int find_client_uuid(gconstpointer data, gconstpointer user_data)
 	return memcmp(exp_uuid, client->uuid, sizeof(client->uuid));
 }
 
+static int find_client_if(gconstpointer data, gconstpointer user_data)
+{
+	int32_t exp_cif = GPOINTER_TO_INT(user_data);
+	const struct gatt_clients *client = data;
+
+	return client->client_if != exp_cif;
+}
+
 static void handle_client_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_register *cmd = buf;
@@ -100,10 +108,29 @@ failed:
 
 static void handle_client_unregister(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_unregister *cmd = buf;
+	GSList *found_client_if;
+	uint8_t status;
+
 	DBG("");
 
+	found_client_if = g_slist_find_custom(gatt_clients_list,
+						GINT_TO_POINTER(cmd->client_if),
+						find_client_if);
+	if (!found_client_if) {
+		error("gatt: client_if=%d not found", cmd->client_if);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	gatt_clients_list = g_slist_remove(gatt_clients_list,
+							found_client_if->data);
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

