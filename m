Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/gatt: Handle Unregister gatt client command
Date: Fri,  7 Mar 2014 14:04:59 +0100
Message-Id: <1394197499-2207-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1394197499-2207-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1394197499-2207-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds unregister gatt client app command handling.
---
 android/gatt.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index f8f7208..1261c1f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -60,6 +60,13 @@ static int find_client_uuid(gconstpointer data, gconstpointer user_data)
 	return 0;
 }
 
+static int find_client_if(gconstpointer data, gconstpointer user_data)
+{
+	const int32_t exp_cif = *((int32_t *)user_data);
+	const int32_t cur_cif = ((struct gatt_client *)data)->client_if;
+
+	return cur_cif != exp_cif;
+}
 
 static void handle_client_register(const void *buf, uint16_t len)
 {
@@ -110,10 +117,26 @@ failed:
 
 static void handle_client_unregister(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_unregister *cmd = buf;
+	int32_t client_if = cmd->client_if;
+	GList *found_client_if;
+
 	DBG("");
 
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+	found_client_if = g_list_find_custom(gatt_client_list, &client_if,
+								find_client_if);
+	if (!found_client_if) {
+		error("client_if: %d not found", client_if);
+		ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 			HAL_OP_GATT_CLIENT_UNREGISTER, HAL_STATUS_FAILED);
+		return;
+	}
+
+	gatt_client_list = g_list_remove(gatt_client_list,
+							found_client_if->data);
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_OP_GATT_CLIENT_UNREGISTER, HAL_STATUS_SUCCESS);
 }
 
 static void handle_client_scan(const void *buf, uint16_t len)
-- 
1.8.5.2

