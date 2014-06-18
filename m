Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 3/4] android/gatt:Add test command to increase security on link
Date: Wed, 18 Jun 2014 11:08:18 +0200
Message-Id: <1403082499-2349-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1403082499-2349-1-git-send-email-marcin.kraglak@tieto.com>
References: <1403082499-2349-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c    | 17 +++++++++++++++++
 android/hal-msg.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 4540e95..814dc50 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3762,6 +3762,20 @@ static uint8_t test_read_write(bdaddr_t *bdaddr, bt_uuid_t *uuid, uint16_t op,
 	return HAL_STATUS_SUCCESS;
 }
 
+static uint8_t test_increase_security(bdaddr_t *bdaddr, uint16_t u1)
+{
+	struct gatt_device *device;
+
+	device = find_device_by_addr(bdaddr);
+	if (!device)
+		return HAL_STATUS_FAILED;
+
+	if (!set_security(device, u1))
+		return HAL_STATUS_FAILED;
+
+	return HAL_STATUS_SUCCESS;
+}
+
 static void handle_client_test_command(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_test_command *cmd = buf;
@@ -3813,6 +3827,9 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 		status = test_read_write(&bdaddr, &uuid, cmd->u1, cmd->u2,
 						cmd->u3, cmd->u4, cmd->u5);
 		break;
+	case GATT_CLIENT_TEST_CMD_INCREASE_SECURITY:
+		status = test_increase_security(&bdaddr, cmd->u1);
+		break;
 	case GATT_CLIENT_TEST_CMD_PAIRING_CONFIG:
 	default:
 		status = HAL_STATUS_FAILED;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 57872c6..af859c6 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -756,6 +756,7 @@ struct hal_cmd_gatt_client_set_adv_data {
 #define GATT_CLIENT_TEST_CMD_DISCOVER		0x04
 #define GATT_CLIENT_TEST_CMD_READ		0xe0
 #define GATT_CLIENT_TEST_CMD_WRITE		0xe1
+#define GATT_CLIENT_TEST_CMD_INCREASE_SECURITY	0xe2
 #define GATT_CLIENT_TEST_CMD_PAIRING_CONFIG	0xf0
 
 #define HAL_OP_GATT_CLIENT_TEST_COMMAND		0x16
-- 
1.9.3

