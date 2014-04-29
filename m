Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 33/40] android/gatt: Add support for write request
Date: Tue, 29 Apr 2014 18:47:22 +0200
Message-Id: <1398790049-30303-34-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support for write request, command and prepare write
---
 android/gatt.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index bd5cf8a..0931374 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3902,6 +3902,61 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static uint8_t write_request(const uint8_t *cmd, uint16_t cmd_len,
+						struct gatt_device *dev)
+{
+	uint16_t handle;
+	uint16_t offset = 0;
+	uint16_t len;
+	uint8_t value[ATT_DEFAULT_LE_MTU];
+	size_t vlen;
+	struct req_data *req_data;
+
+	req_data = new0(struct req_data, 1);
+	if (!req_data)
+		return ATT_ECODE_UNLIKELY;
+
+	switch (cmd[0]) {
+	case ATT_OP_WRITE_CMD:
+		len = dec_write_cmd(cmd, cmd_len, &handle, value, &vlen);
+		if (!len) {
+			free(req_data);
+			return ATT_ECODE_INVALID_PDU;
+		}
+		break;
+	case ATT_OP_WRITE_REQ:
+		len = dec_write_req(cmd, cmd_len, &handle, value, &vlen);
+		if (!len) {
+			free(req_data);
+			return ATT_ECODE_INVALID_PDU;
+		}
+		break;
+	case ATT_OP_PREP_WRITE_REQ:
+		len = dec_prep_write_req(cmd, cmd_len, &handle, &offset,
+							value, &vlen);
+		if (!len) {
+			free(req_data);
+			return ATT_ECODE_INVALID_PDU;
+		}
+		break;
+	default:
+		error("gatt: Unexpected write type 0x02%x", cmd[0]);
+		free(req_data);
+		return ATT_ECODE_REQ_NOT_SUPP;
+	}
+
+	req_data->dev = dev;
+	req_data->opcode = cmd[0];
+
+	if (!gatt_db_write(gatt_db, handle, offset, value, vlen, req_data,
+						gatt_request_complete)) {
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
@@ -3945,13 +4000,17 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		break;
 	case ATT_OP_WRITE_REQ:
 	case ATT_OP_WRITE_CMD:
+	case ATT_OP_PREP_WRITE_REQ:
+		status = write_request(ipdu, len, dev);
+		if (!status)
+			return;
+		break;
+	case ATT_OP_EXEC_WRITE_REQ:
 	case ATT_OP_FIND_BY_TYPE_REQ:
 	case ATT_OP_HANDLE_CNF:
 	case ATT_OP_HANDLE_IND:
 	case ATT_OP_HANDLE_NOTIFY:
 	case ATT_OP_READ_MULTI_REQ:
-	case ATT_OP_PREP_WRITE_REQ:
-	case ATT_OP_EXEC_WRITE_REQ:
 	default:
 		DBG("Unsupported request 0x%02x", ipdu[0]);
 		status = ATT_ECODE_REQ_NOT_SUPP;
-- 
1.8.4

