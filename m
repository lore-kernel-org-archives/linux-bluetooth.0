Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 28/38] android/gatt: Add support to read request
Date: Wed, 30 Apr 2014 11:13:59 +0200
Message-Id: <1398849249-5868-29-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added support for read and read blob
---
 android/gatt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 2c13522..2177c968 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3733,6 +3733,37 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
+					struct gatt_device *dev)
+{
+	uint16_t handle;
+	uint16_t len;
+	uint16_t offset = 0;
+
+	DBG("");
+
+	switch (cmd[0]) {
+	case ATT_OP_READ_BLOB_REQ:
+		len = dec_read_blob_req(cmd, cmd_len, &handle, &offset);
+		if (!len)
+			return ATT_ECODE_INVALID_PDU;
+		break;
+	case ATT_OP_READ_REQ:
+		len = dec_read_req(cmd, cmd_len, &handle);
+		if (!len)
+			return ATT_ECODE_INVALID_PDU;
+		break;
+	default:
+		error("gatt: Unexpected read type 0x%02x", cmd[0]);
+		return ATT_ECODE_REQ_NOT_SUPP;
+	}
+
+	if (!gatt_db_read(gatt_db, handle, offset, cmd[0], &dev->bdaddr))
+		return ATT_ECODE_UNLIKELY;
+
+	return 0;
+}
+
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -3760,6 +3791,11 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		break;
 	case ATT_OP_READ_REQ:
 	case ATT_OP_READ_BLOB_REQ:
+		status = read_request(ipdu, len, dev);
+		if (!status)
+			/* Response will be sent in callback */
+			return;
+		break;
 	case ATT_OP_MTU_REQ:
 	case ATT_OP_FIND_INFO_REQ:
 	case ATT_OP_WRITE_REQ:
-- 
1.8.4

