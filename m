Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/6] android/gatt: Check permissions before read execution
Date: Mon, 26 May 2014 11:10:29 +0200
Message-Id: <1401095429-28432-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401095429-28432-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401095429-28432-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check device security level and attribute permissions before read
execution.
---
 android/gatt.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index cde8816..2d0e06a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3817,13 +3817,101 @@ static bool match_dev_request_by_handle(const void *data, const void *user_data)
 	return handle_data->handle == handle;
 }
 
+static uint8_t check_device_permissions(struct gatt_device *device,
+					uint8_t opcode, uint32_t permissions)
+{
+	GIOChannel *io;
+	int sec_level;
+
+	io = g_attrib_get_channel(device->attrib);
+
+	if (!bt_io_get(io, NULL, BT_IO_OPT_SEC_LEVEL, &sec_level,
+							BT_IO_OPT_INVALID))
+		return ATT_ECODE_UNLIKELY;
+
+	switch (opcode) {
+	case ATT_OP_SIGNED_WRITE_CMD:
+		if (!(permissions & GATT_PERM_WRITE_SIGNED))
+				return ATT_ECODE_WRITE_NOT_PERM;
+
+		if ((permissions & GATT_PERM_WRITE_SIGNED_MITM) && sec_level <
+							BT_SECURITY_HIGH)
+			return ATT_ECODE_AUTHENTICATION;
+
+		break;
+	case ATT_OP_READ_BY_TYPE_REQ:
+	case ATT_OP_READ_REQ:
+	case ATT_OP_READ_BLOB_REQ:
+	case ATT_OP_READ_MULTI_REQ:
+	case ATT_OP_READ_BY_GROUP_REQ:
+		if (permissions && !(permissions & GATT_PERM_READ))
+			return ATT_ECODE_READ_NOT_PERM;
+
+		if ((permissions & GATT_PERM_READ_ENCRYPTED) && sec_level <
+							BT_SECURITY_MEDIUM)
+			return ATT_ECODE_INSUFF_ENC;
+
+		if ((permissions & GATT_PERM_READ_MITM) && sec_level <
+							BT_SECURITY_HIGH)
+			return ATT_ECODE_AUTHENTICATION;
+
+		if ((permissions & GATT_PERM_READ_AUTHORIZATION))
+			return ATT_ECODE_AUTHORIZATION;
+
+		break;
+	case ATT_OP_WRITE_REQ:
+	case ATT_OP_WRITE_CMD:
+	case ATT_OP_PREP_WRITE_REQ:
+	case ATT_OP_EXEC_WRITE_REQ:
+		if (!(permissions & GATT_PERM_WRITE))
+			return ATT_ECODE_WRITE_NOT_PERM;
+
+		if ((permissions & GATT_PERM_WRITE_ENCRYPTED) && sec_level <
+							BT_SECURITY_MEDIUM)
+			return ATT_ECODE_INSUFF_ENC;
+
+		if ((permissions & GATT_PERM_WRITE_MITM) &&
+						sec_level < BT_SECURITY_HIGH)
+			return ATT_ECODE_AUTHENTICATION;
+
+		if ((permissions & GATT_PERM_WRITE_AUTHORIZATION))
+			return ATT_ECODE_AUTHORIZATION;
+
+	break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static void read_requested_attributes(void *data, void *user_data)
 {
 	struct pending_request *resp_data = data;
 	struct request_processing_data *process_data = user_data;
+	uint32_t permissions;
 	uint8_t *value;
 	int value_len;
 
+	permissions = gatt_db_get_attribute_permissions(gatt_db,
+			resp_data->handle);
+
+	/*
+	 * Check if it is attribute we didn't declare permissions, like service
+	 * declaration or included service. Set permissions to read only
+	 */
+	if (permissions == 0)
+		permissions = GATT_PERM_READ;
+
+	resp_data->error = check_device_permissions(process_data->device,
+							process_data->opcode,
+							permissions);
+
+	if (resp_data->error) {
+		resp_data->state = REQUEST_DONE;
+		return;
+	}
+
 	if (!gatt_db_read(gatt_db, resp_data->handle,
 						resp_data->offset,
 						process_data->opcode,
-- 
1.9.0

