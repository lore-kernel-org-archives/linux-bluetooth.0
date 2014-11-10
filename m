Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 07/11] shared/gatt-server: Add functions for sending notifications/indications.
Date: Mon, 10 Nov 2014 09:07:23 -0800
Message-Id: <1415639247-14320-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1415639247-14320-1-git-send-email-armansito@chromium.org>
References: <1415639247-14320-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces new functions for sending notifications and
indications as a GATT server.
---
 src/shared/gatt-server.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-server.h | 12 ++++++
 2 files changed, 107 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 16b6460..a8749b8 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1068,3 +1068,98 @@ bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
 
 	return true;
 }
+
+bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
+					uint16_t handle, const uint8_t *value,
+					uint16_t length)
+{
+	uint16_t pdu_len;
+	uint8_t *pdu;
+	bool result;
+
+	if (!server || (length && !value))
+		return false;
+
+	pdu_len = MIN(bt_att_get_mtu(server->att), length + 2);
+	pdu = malloc(pdu_len);
+	if (!pdu)
+		return false;
+
+	put_le16(handle, pdu);
+	memcpy(pdu + 2, value, length);
+
+	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_VAL_NOT, pdu,
+						pdu_len, NULL, NULL, NULL);
+	free(pdu);
+
+	return result;
+}
+
+struct ind_data {
+	bt_gatt_server_conf_func_t callback;
+	bt_gatt_server_destroy_func_t destroy;
+	void *user_data;
+};
+
+static void destroy_ind_data(void *user_data)
+{
+	struct ind_data *data = user_data;
+
+	if (data->destroy)
+		data->destroy(data->user_data);
+
+	free(data);
+}
+
+static void conf_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct ind_data *data = user_data;
+
+	if (data->callback)
+		data->callback(data->user_data);
+}
+
+bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
+					uint16_t handle, const uint8_t *value,
+					uint16_t length,
+					bt_gatt_server_conf_func_t callback,
+					void *user_data,
+					bt_gatt_server_destroy_func_t destroy)
+{
+	uint16_t pdu_len;
+	uint8_t *pdu;
+	struct ind_data *data;
+	bool result;
+
+	if (!server || (length && !value))
+		return false;
+
+	pdu_len = MIN(bt_att_get_mtu(server->att), length + 2);
+	pdu = malloc(pdu_len);
+	if (!pdu)
+		return false;
+
+	data = new0(struct ind_data, 1);
+	if (!data) {
+		free(pdu);
+		return false;
+	}
+
+	data->callback = callback;
+	data->destroy = destroy;
+	data->user_data = user_data;
+
+	put_le16(handle, pdu);
+	memcpy(pdu + 2, value, length);
+
+	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_VAL_IND, pdu,
+							pdu_len, conf_cb,
+							data, destroy_ind_data);
+	if (!result)
+		destroy_ind_data(data);
+
+	free(pdu);
+
+	return result;
+}
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index e3c4def..0e480e1 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -33,8 +33,20 @@ void bt_gatt_server_unref(struct bt_gatt_server *server);
 
 typedef void (*bt_gatt_server_destroy_func_t)(void *user_data);
 typedef void (*bt_gatt_server_debug_func_t)(const char *str, void *user_data);
+typedef void (*bt_gatt_server_conf_func_t)(void *user_data);
 
 bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
 					bt_gatt_server_debug_func_t callback,
 					void *user_data,
 					bt_gatt_server_destroy_func_t destroy);
+
+bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
+					uint16_t handle, const uint8_t *value,
+					uint16_t length);
+
+bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
+					uint16_t handle, const uint8_t *value,
+					uint16_t length,
+					bt_gatt_server_conf_func_t callback,
+					void *user_data,
+					bt_gatt_server_destroy_func_t destroy);
-- 
2.1.0.rc2.206.gedb03e5

