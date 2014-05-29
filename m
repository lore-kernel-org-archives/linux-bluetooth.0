Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/6] android/gatt: Add read test command stub
Date: Thu, 29 May 2014 12:34:03 +0200
Message-Id: <1401359648-576-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds read support to test command handler. Particular read types will be
handled basing on the 'u1' command parameter.
---
 android/gatt.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index fd35442..d9a76c6 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3442,6 +3442,44 @@ failed:
 				HAL_OP_GATT_CLIENT_SET_ADV_DATA, status);
 }
 
+static uint8_t handle_test_command_read(bdaddr_t *bdaddr, bt_uuid_t *uuid,
+				uint16_t read_type, uint16_t u2, uint16_t u3,
+				uint16_t u4, uint16_t u5)
+{
+	guint16 length = 0;
+	struct gatt_device *dev;
+	uint8_t *pdu;
+	size_t mtu;
+
+	dev = find_device_by_addr(bdaddr);
+	if (!dev || dev->state != DEVICE_CONNECTED)
+		return HAL_STATUS_FAILED;
+
+	pdu = g_attrib_get_buffer(dev->attrib, &mtu);
+	if (!pdu)
+		return HAL_STATUS_FAILED;
+
+	switch (read_type) {
+	case ATT_OP_READ_REQ:
+	case ATT_OP_READ_BY_TYPE_REQ:
+	case ATT_OP_READ_BLOB_REQ:
+	case ATT_OP_READ_BY_GROUP_REQ:
+	case ATT_OP_READ_MULTI_REQ:
+	default:
+		error("gatt: Unknown read type");
+
+		return HAL_STATUS_UNSUPPORTED;
+	}
+
+	if (!length)
+		return HAL_STATUS_FAILED;
+
+	g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
+
+	return HAL_STATUS_SUCCESS;
+}
+
+
 static void handle_client_test_command(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_test_command *cmd = buf;
@@ -3484,6 +3522,13 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 		status = HAL_STATUS_SUCCESS;
 		break;
 	case GATT_CLIENT_TEST_CMD_DISCOVER:
+		status = HAL_STATUS_FAILED;
+		break;
+	case GATT_CLIENT_TEST_CMD_READ:
+		status = handle_test_command_read(&bdaddr, &uuid, cmd->u1,
+							cmd->u2, cmd->u3,
+							cmd->u4, cmd->u5);
+		break;
 	case GATT_CLIENT_TEST_CMD_PAIRING_CONFIG:
 	default:
 		status = HAL_STATUS_FAILED;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index d051b67..ae15499 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -751,6 +751,7 @@ struct hal_cmd_gatt_client_set_adv_data {
 #define GATT_CLIENT_TEST_CMD_CONNECT		0x02
 #define GATT_CLIENT_TEST_CMD_DISCONNECT		0x03
 #define GATT_CLIENT_TEST_CMD_DISCOVER		0x04
+#define GATT_CLIENT_TEST_CMD_READ		0xe0
 #define GATT_CLIENT_TEST_CMD_PAIRING_CONFIG	0xf0
 
 #define HAL_OP_GATT_CLIENT_TEST_COMMAND		0x16
-- 
1.9.3

