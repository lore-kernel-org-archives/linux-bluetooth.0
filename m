Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 25/36] android/gatt: Add support to read request
Date: Tue, 29 Apr 2014 03:14:56 +0200
Message-Id: <1398734107-4793-27-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added support for read and read blob
---
 android/gatt.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 609775e..da5a7c8 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3749,8 +3749,57 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 struct req_data {
 	struct gatt_device *dev;
 	uint8_t opcode;
+
+	bool long_read;
 };
 
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
+		return ATT_ECODE_UNLIKELY;
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
+	if (!gatt_db_read(gatt_db, handle, offset, req_data)) {
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
@@ -3778,6 +3827,12 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
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

