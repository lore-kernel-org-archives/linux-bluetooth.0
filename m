Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 04/10] android/gatt: Avoid double helper struct for read/write characteristic
Date: Sun, 13 Apr 2014 00:00:25 +0200
Message-Id: <1397340031-29711-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch combine two helper structs for operations on characteristics
to one.

Also use pointers inside this struct instread of raw data.
---
 android/gatt.c | 51 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d04294c..adba29e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1864,17 +1864,17 @@ failed:
 				HAL_OP_GATT_CLIENT_GET_DESCRIPTOR, status);
 }
 
-struct read_char_data {
+struct char_op_data {
 	int32_t conn_id;
-	struct element_id srvc_id;
-	struct element_id char_id;
+	const struct element_id *srvc_id;
+	const struct element_id *char_id;
 	uint8_t primary;
 };
 
 static void send_client_read_char_notify(int32_t status, const uint8_t *pdu,
 						uint16_t len, int32_t conn_id,
-						struct element_id *srvc_id,
-						struct element_id *char_id,
+						const struct element_id *s_id,
+						const struct element_id *ch_id,
 						uint8_t primary)
 {
 	uint8_t buf[IPC_MTU];
@@ -1886,8 +1886,8 @@ static void send_client_read_char_notify(int32_t status, const uint8_t *pdu,
 	ev->conn_id = conn_id;
 	ev->status = status;
 
-	element_id_to_hal_srvc_id(srvc_id, primary, &ev->data.srvc_id);
-	element_id_to_hal_gatt_id(char_id, &ev->data.char_id);
+	element_id_to_hal_srvc_id(s_id, primary, &ev->data.srvc_id);
+	element_id_to_hal_gatt_id(ch_id, &ev->data.char_id);
 
 	if (pdu) {
 		vlen = dec_read_resp(pdu, len, ev->data.value, sizeof(buf));
@@ -1907,10 +1907,10 @@ static void send_client_read_char_notify(int32_t status, const uint8_t *pdu,
 static void read_char_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct read_char_data *data = user_data;
+	struct char_op_data *data = user_data;
 
 	send_client_read_char_notify(status, pdu, len, data->conn_id,
-						&data->srvc_id, &data->char_id,
+						data->srvc_id, data->char_id,
 						data->primary);
 
 	free(data);
@@ -1919,7 +1919,7 @@ static void read_char_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void handle_client_read_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_read_characteristic *cmd = buf;
-	struct read_char_data *cb_data;
+	struct char_op_data *cb_data;
 	struct characteristic *ch;
 	struct gatt_device *dev;
 	struct service *srvc;
@@ -1948,7 +1948,7 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data = new0(struct read_char_data, 1);
+	cb_data = new0(struct char_op_data, 1);
 	if (!cb_data) {
 		error("gatt: Cannot allocate cb data");
 		status = HAL_STATUS_NOMEM;
@@ -1957,8 +1957,8 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
 
 	cb_data->conn_id = cmd->conn_id;
 	cb_data->primary = cmd->srvc_id.is_primary;
-	cb_data->srvc_id = srvc_id;
-	cb_data->char_id = char_id;
+	cb_data->srvc_id = &srvc->id;
+	cb_data->char_id = &ch->id;
 
 	if (!gatt_read_char(dev->attrib, ch->ch.value_handle,
 						read_char_cb, cb_data)) {
@@ -1984,16 +1984,9 @@ failed:
 					cmd->srvc_id.is_primary);
 }
 
-struct write_char_data {
-	int32_t conn_id;
-	struct element_id srvc_id;
-	struct element_id char_id;
-	uint8_t primary;
-};
-
 static void send_client_write_char_notify(int32_t status, int32_t conn_id,
-					struct element_id *srvc_id,
-					struct element_id *char_id,
+					const struct element_id *srvc_id,
+					const struct element_id *char_id,
 					uint8_t primary)
 {
 	struct hal_ev_gatt_client_write_characteristic ev;
@@ -2014,10 +2007,10 @@ static void send_client_write_char_notify(int32_t status, int32_t conn_id,
 static void write_char_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct write_char_data *data = user_data;
+	struct char_op_data *data = user_data;
 
-	send_client_write_char_notify(status, data->conn_id, &data->srvc_id,
-					&data->char_id, data->primary);
+	send_client_write_char_notify(status, data->conn_id, data->srvc_id,
+						data->char_id, data->primary);
 
 	free(data);
 }
@@ -2025,7 +2018,7 @@ static void write_char_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void handle_client_write_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_write_characteristic *cmd = buf;
-	struct write_char_data *cb_data;
+	struct char_op_data *cb_data;
 	struct characteristic *ch;
 	struct gatt_device *dev;
 	struct service *srvc;
@@ -2058,7 +2051,7 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data = new0(struct write_char_data, 1);
+	cb_data = new0(struct char_op_data, 1);
 	if (!cb_data) {
 		error("gatt: Cannot allocate call data");
 		status = HAL_STATUS_NOMEM;
@@ -2067,8 +2060,8 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 
 	cb_data->conn_id = cmd->conn_id;
 	cb_data->primary = cmd->srvc_id.is_primary;
-	cb_data->srvc_id = srvc_id;
-	cb_data->char_id = char_id;
+	cb_data->srvc_id = &srvc->id;
+	cb_data->char_id = &ch->id;
 
 	if (!gatt_write_char(dev->attrib, ch->ch.value_handle, cmd->value,
 					cmd->len, write_char_cb, cb_data)) {
-- 
1.8.4

