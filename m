Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 5/5] android/gatt: Add support for write without response
Date: Thu, 17 Apr 2014 13:57:48 +0200
Message-Id: <1397735868-19092-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397735868-19092-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 54 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 3f37a44..b367558 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2285,15 +2285,22 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data = create_char_op_data(cmd->conn_id, &srvc->id, &ch->id,
+	if (cmd->write_type != GATT_WRITE_TYPE_NO_RESPONSE) {
+		cb_data = create_char_op_data(cmd->conn_id, &srvc->id, &ch->id,
 						cmd->srvc_id.is_primary);
-	if (!cb_data) {
-		error("gatt: Cannot allocate call data");
-		status = HAL_STATUS_NOMEM;
-		goto failed;
+		if (!cb_data) {
+			error("gatt: Cannot allocate call data");
+			status = HAL_STATUS_NOMEM;
+			goto failed;
+		}
 	}
 
 	switch (cmd->write_type) {
+	case GATT_WRITE_TYPE_NO_RESPONSE:
+		res = gatt_write_cmd(dev->attrib, ch->ch.value_handle,
+							cmd->value, cmd->len,
+							NULL, NULL);
+		break;
 	case GATT_WRITE_TYPE_PREPARE:
 		res = gatt_reliable_write_char(dev->attrib, ch->ch.value_handle,
 							cmd->value, cmd->len,
@@ -2325,10 +2332,14 @@ failed:
 			HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC, status);
 
 	/* We should send notification with service, characteristic id in case
-	 * of errors.
+	 * of error and write with no response
 	 */
-	if (status != HAL_STATUS_SUCCESS) {
-		send_client_write_char_notify(GATT_FAILURE, cmd->conn_id,
+	if (status != HAL_STATUS_SUCCESS ||
+			cmd->write_type == GATT_WRITE_TYPE_NO_RESPONSE) {
+		int32_t gatt_status = (status == HAL_STATUS_SUCCESS) ?
+						GATT_SUCCESS : GATT_FAILURE;
+
+		send_client_write_char_notify(gatt_status, cmd->conn_id,
 						&srvc_id, &char_id,
 						cmd->srvc_id.is_primary);
 		free(cb_data);
@@ -2588,21 +2599,28 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data = create_desc_data(conn_id, &srvc->id, &ch->id, &descr->id,
-								primary);
-	if (!cb_data) {
-		error("gatt: Write descr. could not allocate callback data");
+	if (cmd->write_type != GATT_WRITE_TYPE_NO_RESPONSE) {
+		cb_data = create_desc_data(conn_id, &srvc->id, &ch->id,
+							&descr->id, primary);
+		if (!cb_data) {
+			error("gatt: Write descr. could not allocate cb_data");
 
-		status = HAL_STATUS_NOMEM;
-		goto failed;
+			status = HAL_STATUS_NOMEM;
+			goto failed;
+		}
 	}
 
 	switch (cmd->write_type) {
+	case GATT_WRITE_TYPE_NO_RESPONSE:
+		res = gatt_write_cmd(dev->attrib, descr->handle, cmd->value,
+					cmd->len, NULL , NULL);
+		break;
 	case GATT_WRITE_TYPE_PREPARE:
 		res = gatt_reliable_write_char(dev->attrib, descr->handle,
 							cmd->value, cmd->len,
 							write_descr_cb,
 							cb_data);
+
 		break;
 	case GATT_WRITE_TYPE_DEFAULT:
 		res = gatt_write_char(dev->attrib, descr->handle, cmd->value,
@@ -2623,8 +2641,12 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	if (status != HAL_STATUS_SUCCESS) {
-		send_client_descr_write_notify(GATT_FAILURE, conn_id, &srvc_id,
+	if (status != HAL_STATUS_SUCCESS ||
+			cmd->write_type == GATT_WRITE_TYPE_NO_RESPONSE) {
+		int32_t gatt_status = (status == HAL_STATUS_SUCCESS) ?
+						GATT_SUCCESS : GATT_FAILURE;
+
+		send_client_descr_write_notify(gatt_status, conn_id, &srvc_id,
 						&char_id, &descr_id, primary);
 		free(cb_data);
 	}
-- 
1.8.4

