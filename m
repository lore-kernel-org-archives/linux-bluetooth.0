Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 10/10] android/gatt: Add support for write without response
Date: Sun, 13 Apr 2014 00:00:31 +0200
Message-Id: <1397340031-29711-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 55 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6fcc977..ce7c0d3 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -54,6 +54,7 @@
 #define GATT_SUCCESS	0x00000000
 #define GATT_FAILURE	0x00000101
 
+#define GATT_WRITE_NO_RESPONSE	0x01
 #define GATT_WRITE_DEFAULT	0x02
 #define GATT_WRITE_RELIABLE	0x03
 
@@ -2070,15 +2071,22 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data = create_char_op_data(cmd->conn_id, &srvc->id, &ch->id,
+	if (cmd->write_type != GATT_WRITE_NO_RESPONSE) {
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
+	case GATT_WRITE_NO_RESPONSE:
+		res = gatt_write_cmd(dev->attrib, ch->ch.value_handle,
+							cmd->value, cmd->len,
+							NULL, NULL);
+		break;
 	case GATT_WRITE_RELIABLE:
 		res = gatt_reliable_write_char(dev->attrib, ch->ch.value_handle,
 							cmd->value, cmd->len,
@@ -2110,10 +2118,14 @@ failed:
 			HAL_OP_GATT_CLIENT_WRITE_CHARACTERISTIC, status);
 
 	/* We should send notification with service, characteristic id in case
-	 * of errors.
+	 * of error and write with no response
 	 */
-	if (status != HAL_STATUS_SUCCESS) {
-		send_client_write_char_notify(GATT_FAILURE, cmd->conn_id,
+	if (status != HAL_STATUS_SUCCESS ||
+				cmd->write_type == GATT_WRITE_NO_RESPONSE) {
+		int32_t gatt_status = (status == HAL_STATUS_SUCCESS) ?
+						GATT_SUCCESS : GATT_FAILURE;
+
+		send_client_write_char_notify(gatt_status, cmd->conn_id,
 						&srvc_id, &char_id,
 						cmd->srvc_id.is_primary);
 		free(cb_data);
@@ -2373,21 +2385,28 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cb_data = create_desc_data(conn_id, &srvc->id, &ch->id, &descr->id,
-								primary);
-	if (!cb_data) {
-		error("gatt: Write descr. could not allocate callback data");
+	if (cmd->write_type != GATT_WRITE_NO_RESPONSE) {
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
+	case GATT_WRITE_NO_RESPONSE:
+		res = gatt_write_cmd(dev->attrib, descr->handle, cmd->value,
+					cmd->len, NULL , NULL);
+		break;
 	case GATT_WRITE_RELIABLE:
 		res = gatt_reliable_write_char(dev->attrib, descr->handle,
 							cmd->value, cmd->len,
 							write_descr_cb,
 							cb_data);
+
 		break;
 	case GATT_WRITE_DEFAULT:
 		res = gatt_write_char(dev->attrib, descr->handle, cmd->value,
@@ -2408,8 +2427,12 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	if (status != HAL_STATUS_SUCCESS) {
-		send_client_descr_write_notify(GATT_FAILURE, conn_id, &srvc_id,
+	if (status != HAL_STATUS_SUCCESS ||
+				cmd->write_type == GATT_WRITE_NO_RESPONSE) {
+		int32_t gatt_status = (status == HAL_STATUS_SUCCESS) ?
+						GATT_SUCCESS : GATT_FAILURE;
+
+		send_client_descr_write_notify(gatt_status, conn_id, &srvc_id,
 						&char_id, &descr_id, primary);
 		free(cb_data);
 	}
-- 
1.8.4

