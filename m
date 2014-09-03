Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] android/gatt: Stop listening while unregistering app
Date: Wed,  3 Sep 2014 11:26:56 +0200
Message-Id: <1409736417-17615-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter gets stucked on advertising while unregistering all apps with not
stopped listening.
---
 android/gatt.c | 110 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 38 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index aff5dc5..6970636 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1883,15 +1883,87 @@ static uint8_t unregister_app(int client_if)
 	return HAL_STATUS_SUCCESS;
 }
 
+static void send_client_listen_notify(int32_t id, int32_t status)
+{
+	struct hal_ev_gatt_client_listen ev;
+
+	/* Server if because of typo in android headers */
+	ev.server_if = id;
+	ev.status = status;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, HAL_EV_GATT_CLIENT_LISTEN,
+							sizeof(ev), &ev);
+}
+
+struct listen_data {
+	int32_t client_id;
+	bool start;
+};
+
+static void set_advertising_cb(uint8_t status, void *user_data)
+{
+	struct listen_data *l = user_data;
+
+	send_client_listen_notify(l->client_id, status);
+
+	/* In case of success update advertising state*/
+	if (!status)
+		advertising_cnt = l->start ? 1 : 0;
+
+	/*
+	 * Let's remove client from the list in two cases
+	 * 1. Start failed
+	 * 2. Stop succeed
+	 */
+	if ((l->start && status) || (!l->start && !status))
+		queue_remove(listen_apps, INT_TO_PTR(l->client_id));
+
+	free(l);
+}
+
 static void handle_client_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_unregister *cmd = buf;
 	uint8_t status;
+	void *listening_client;
+	struct listen_data *data;
 
 	DBG("");
 
+	listening_client = queue_find(listen_apps, match_by_value,
+						INT_TO_PTR(cmd->client_if));
+
+	if (listening_client) {
+		advertising_cnt--;
+		queue_remove(listen_apps, INT_TO_PTR(cmd->client_if));
+	} else {
+		status = unregister_app(cmd->client_if);
+		goto reply;
+	}
+
+	if (!advertising_cnt) {
+		data = new0(struct listen_data, 1);
+		if (!data) {
+			error("gatt: Could not allocate memory for listen data");
+			status = HAL_STATUS_NOMEM;
+			goto reply;
+		}
+
+		data->client_id = cmd->client_if;
+		data->start = false;
+
+		if (!bt_le_set_advertising(data->start, set_advertising_cb,
+								data)) {
+			error("gatt: Could not set advertising");
+			status = HAL_STATUS_FAILED;
+			free(data);
+			goto reply;
+		}
+	}
+
 	status = unregister_app(cmd->client_if);
 
+reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
@@ -1970,44 +2042,6 @@ static void handle_client_disconnect(const void *buf, uint16_t len)
 					HAL_OP_GATT_CLIENT_DISCONNECT, status);
 }
 
-static void send_client_listen_notify(int32_t id, int32_t status)
-{
-	struct hal_ev_gatt_client_listen ev;
-
-	/* Server if because of typo in android headers */
-	ev.server_if = id;
-	ev.status = status;
-
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, HAL_EV_GATT_CLIENT_LISTEN,
-							sizeof(ev), &ev);
-}
-
-struct listen_data {
-	int32_t client_id;
-	bool start;
-};
-
-static void set_advertising_cb(uint8_t status, void *user_data)
-{
-	struct listen_data *l = user_data;
-
-	send_client_listen_notify(l->client_id, status);
-
-	/* In case of success update advertising state*/
-	if (!status)
-		advertising_cnt = l->start ? 1 : 0;
-
-	/*
-	 * Let's remove client from the list in two cases
-	 * 1. Start failed
-	 * 2. Stop succeed
-	 */
-	if ((l->start && status) || (!l->start && !status))
-		queue_remove(listen_apps, INT_TO_PTR(l->client_id));
-
-	free(l);
-}
-
 static void handle_client_listen(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_listen *cmd = buf;
-- 
1.9.3

