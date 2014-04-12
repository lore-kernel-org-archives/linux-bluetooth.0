Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 07/10] android/gatt: Daemon accepts only default write type
Date: Sun, 13 Apr 2014 00:00:28 +0200
Message-Id: <1397340031-29711-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch daemon accepts only default write type. For other types
it correctly replies with HAL_STATUS_UNSUPPORTED
---
 android/gatt.c | 50 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 523a141..c98a4f1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -54,6 +54,8 @@
 #define GATT_SUCCESS	0x00000000
 #define GATT_FAILURE	0x00000101
 
+#define GATT_WRITE_DEFAULT	0x02
+
 struct gatt_client {
 	int32_t id;
 	uint8_t uuid[16];
@@ -2033,13 +2035,14 @@ static void write_char_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void handle_client_write_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_write_characteristic *cmd = buf;
-	struct char_op_data *cb_data;
+	struct char_op_data *cb_data = NULL;
 	struct characteristic *ch;
 	struct gatt_device *dev;
 	struct service *srvc;
 	struct element_id srvc_id;
 	struct element_id char_id;
 	uint8_t status;
+	guint res;
 
 	DBG("");
 
@@ -2074,28 +2077,41 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (!gatt_write_char(dev->attrib, ch->ch.value_handle, cmd->value,
-					cmd->len, write_char_cb, cb_data)) {
-		error("gatt: Cannot write characteristic with inst_id: %d",
+	switch (cmd->write_type) {
+	case GATT_WRITE_DEFAULT:
+		res = gatt_write_char(dev->attrib, ch->ch.value_handle,
+							cmd->value, cmd->len,
+							write_char_cb, cb_data);
+		break;
+	default:
+		error("gatt: Write type %d unsupported", cmd->write_type);
+		status = HAL_STATUS_UNSUPPORTED;
+		goto failed;
+	}
+
+	if (!res) {
+		error("gatt: Cannot write char. with inst_id: %d",
 							cmd->gatt_id.inst_id);
 		status = HAL_STATUS_FAILED;
-		free(cb_data);
 		goto failed;
 	}
 
 	status = HAL_STATUS_SUCCESS;
 
 failed:
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 			HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC, status);
 
 	/* We should send notification with service, characteristic id in case
 	 * of errors.
 	 */
-	if (status != HAL_STATUS_SUCCESS)
+	if (status != HAL_STATUS_SUCCESS) {
 		send_client_write_char_notify(GATT_FAILURE, cmd->conn_id,
 						&srvc_id, &char_id,
 						cmd->srvc_id.is_primary);
+		free(cb_data);
+	}
 }
 
 static void send_client_descr_read_notify(int32_t status, const uint8_t *pdu,
@@ -2298,7 +2314,7 @@ static void write_descr_cb(guint8 status, const guint8 *pdu, guint16 len,
 static void handle_client_write_descriptor(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_write_descriptor *cmd = buf;
-	struct desc_data *cb_data;
+	struct desc_data *cb_data = NULL;
 	struct characteristic *ch;
 	struct descriptor *descr;
 	struct service *srvc;
@@ -2309,6 +2325,7 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 	int32_t conn_id;
 	uint8_t primary;
 	uint8_t status;
+	guint res;
 
 	DBG("");
 
@@ -2359,10 +2376,19 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (!gatt_write_char(dev->attrib, descr->handle, cmd->value, cmd->len,
-						write_descr_cb, cb_data)) {
-		free(cb_data);
+	switch (cmd->write_type) {
+	case GATT_WRITE_DEFAULT:
+		res = gatt_write_char(dev->attrib, descr->handle, cmd->value,
+					cmd->len, write_descr_cb, cb_data);
+		break;
+	default:
+		error("gatt: Write type %d unsupported", cmd->write_type);
+		status = HAL_STATUS_UNSUPPORTED;
+		goto failed;
+	}
 
+	if (!res) {
+		error("gatt: Write desc, could not write desc");
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -2370,9 +2396,11 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	if (status != HAL_STATUS_SUCCESS)
+	if (status != HAL_STATUS_SUCCESS) {
 		send_client_descr_write_notify(GATT_FAILURE, conn_id, &srvc_id,
 						&char_id, &descr_id, primary);
+		free(cb_data);
+	}
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_WRITE_DESCRIPTOR, status);
-- 
1.8.4

