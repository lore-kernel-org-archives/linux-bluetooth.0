Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/5] android/gatt: Add initial implementation of client test command
Date: Mon, 26 May 2014 23:53:24 +0200
Message-Id: <1401141208-26912-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
References: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command is used to performe some tasks not available from
standard API and usable only for PTS testing.
---
 android/gatt.c    | 21 ++++++++++++++++++++-
 android/hal-msg.h |  6 ++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index e41a69e..0acb4b6 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3431,10 +3431,29 @@ failed:
 
 static void handle_client_test_command(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_test_command *cmd = buf;
+	bdaddr_t bdaddr;
+	bt_uuid_t uuid;
+	uint8_t status;
+
 	DBG("");
 
+	android2bdaddr(cmd->bda1, &bdaddr);
+	android2uuid(cmd->uuid1, &uuid);
+
+	switch (cmd->command) {
+	case GATT_CLIENT_TEST_CMD_ENABLE:
+	case GATT_CLIENT_TEST_CMD_CONNECT:
+	case GATT_CLIENT_TEST_CMD_DISCONNECT:
+	case GATT_CLIENT_TEST_CMD_DISCOVER:
+	case GATT_CLIENT_TEST_CMD_PAIRING_CONFIG:
+	default:
+		status = HAL_STATUS_FAILED;
+		break;
+	}
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_TEST_COMMAND, HAL_STATUS_FAILED);
+				HAL_OP_GATT_CLIENT_TEST_COMMAND, status);
 }
 
 static void handle_server_register(const void *buf, uint16_t len)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index b68a4c7..d051b67 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -747,6 +747,12 @@ struct hal_cmd_gatt_client_set_adv_data {
 	uint8_t  manufacturer_data[0];
 } __attribute__((packed));
 
+#define GATT_CLIENT_TEST_CMD_ENABLE		0x01
+#define GATT_CLIENT_TEST_CMD_CONNECT		0x02
+#define GATT_CLIENT_TEST_CMD_DISCONNECT		0x03
+#define GATT_CLIENT_TEST_CMD_DISCOVER		0x04
+#define GATT_CLIENT_TEST_CMD_PAIRING_CONFIG	0xf0
+
 #define HAL_OP_GATT_CLIENT_TEST_COMMAND		0x16
 struct hal_cmd_gatt_client_test_command {
 	int32_t command;
-- 
2.0.0.rc4

