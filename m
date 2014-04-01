Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] android/gatt: Handle unregister gatt server command
Date: Tue,  1 Apr 2014 14:54:29 +0200
Message-Id: <1396356869-21053-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1396356869-21053-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1396356869-21053-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds unregister gatt server app command handling.
---
 android/gatt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index fb4d9d1..de2ceb0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -206,6 +206,14 @@ static bool match_client_by_id(const void *data, const void *user_data)
 	return client->id == exp_id;
 }
 
+static bool match_server_by_id(const void *data, const void *user_data)
+{
+	int32_t exp_id = PTR_TO_INT(user_data);
+	const struct gatt_server *server = data;
+
+	return server->id == exp_id;
+}
+
 static struct gatt_client *find_client_by_id(int32_t id)
 {
 	return queue_find(gatt_clients, match_client_by_id, INT_TO_PTR(id));
@@ -1948,10 +1956,26 @@ failed:
 
 static void handle_server_unregister(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_unregister *cmd = buf;
+	uint8_t status;
+	struct gatt_server *server;
+
 	DBG("");
 
+	server = queue_remove_if(gatt_servers, match_server_by_id,
+						INT_TO_PTR(cmd->server_if));
+	if (!server) {
+		error("gatt: server_if=%d not found", cmd->server_if);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	destroy_gatt_server(server);
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_SERVER_UNREGISTER, HAL_STATUS_FAILED);
+					HAL_OP_GATT_SERVER_UNREGISTER, status);
 }
 
 static void handle_server_connect(const void *buf, uint16_t len)
-- 
1.9.1

