Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 3/5] android/gatt: Implement enable test command
Date: Mon, 26 May 2014 23:53:26 +0200
Message-Id: <1401141208-26912-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
References: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command is used to enable and disable test interface.
---
 android/gatt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 8b0082e..1ce6ff9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -194,6 +194,12 @@ static GIOChannel *listening_io = NULL;
 
 static struct bt_crypto *crypto = NULL;
 
+static int test_client_if = 0;
+static const uint8_t TEST_UUID[] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04
+};
+
 static void bt_le_discovery_stop_cb(void);
 
 static bool is_bluetooth_uuid(const uint8_t *uuid)
@@ -3450,6 +3456,20 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 
 	switch (cmd->command) {
 	case GATT_CLIENT_TEST_CMD_ENABLE:
+		if (cmd->u1) {
+			if (!test_client_if)
+				test_client_if = register_app(TEST_UUID,
+								APP_CLIENT);
+
+			if (test_client_if)
+				status = HAL_STATUS_SUCCESS;
+			else
+				status = HAL_STATUS_FAILED;
+		} else {
+			status = unregister_client(test_client_if);
+			test_client_if = 0;
+		}
+		break;
 	case GATT_CLIENT_TEST_CMD_CONNECT:
 	case GATT_CLIENT_TEST_CMD_DISCONNECT:
 	case GATT_CLIENT_TEST_CMD_DISCOVER:
-- 
2.0.0.rc4

