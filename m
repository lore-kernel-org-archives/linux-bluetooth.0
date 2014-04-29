Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 29/40] android/gatt: Add support to read request
Date: Tue, 29 Apr 2014 18:47:18 +0200
Message-Id: <1398790049-30303-30-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added support for read and read blob

Note: There are request data created and provided to the user in the
read_cb. User is responsible to free this data.
---
 android/gatt.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index cd9ce86..88a285f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3736,8 +3736,69 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 struct req_data {
 	struct gatt_device *dev;
 	uint8_t opcode;
+
+	bool long_read;
 };
 
+static void gatt_request_complete(void *data, const uint8_t *pdu, uint16_t len)
+{
+	struct req_data *d = data;
+
+	if (pdu)
+		g_attrib_send(d->dev->attrib, 0, pdu, len, NULL, NULL, NULL);
+	else
+		error("gatt: gatt_request_complete: pdu not present ?!");
+
+	free(d);
+}
+
+static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
+					struct gatt_device *dev)
+{
+	uint16_t handle;
+	uint16_t len;
+	uint16_t offset = 0;
+	struct req_data *req_data;
+
+	DBG("");
+
+	req_data = new0(struct req_data, 1);
+	if (!req_data)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
+	switch (cmd[0]) {
+	case ATT_OP_READ_BLOB_REQ:
+		len = dec_read_blob_req(cmd, cmd_len, &handle, &offset);
+		if (!len) {
+			free(req_data);
+			return ATT_ECODE_INVALID_PDU;
+		}
+		req_data->long_read = true;
+		break;
+	case ATT_OP_READ_REQ:
+		len = dec_read_req(cmd, cmd_len, &handle);
+		if (!len) {
+			free(req_data);
+			return ATT_ECODE_INVALID_PDU;
+		}
+		break;
+	default:
+		error("gatt: Unexpected read type 0x%02x", cmd[0]);
+		free(req_data);
+		return ATT_ECODE_REQ_NOT_SUPP;
+	}
+
+	req_data->dev = dev;
+	req_data->opcode = cmd[0];
+
+	if (!gatt_db_read(gatt_db, handle, offset, req_data, gatt_request_complete)) {
+		free(req_data);
+		return ATT_ECODE_UNLIKELY;
+	}
+
+	return 0;
+}
+
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -3765,6 +3826,12 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		break;
 	case ATT_OP_READ_REQ:
 	case ATT_OP_READ_BLOB_REQ:
+		status = read_request(ipdu, len, dev);
+		if (!status)
+			/* Response will be sent in callback */
+			return;
+		break;
+
 	case ATT_OP_MTU_REQ:
 	case ATT_OP_FIND_INFO_REQ:
 	case ATT_OP_WRITE_REQ:
-- 
1.8.4

