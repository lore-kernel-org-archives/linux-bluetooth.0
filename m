Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 5/5] android/gatt: Implement disconnect test command
Date: Mon, 26 May 2014 23:53:28 +0200
Message-Id: <1401141208-26912-6-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
References: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 6eb4440..af3af08 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3445,6 +3445,7 @@ failed:
 static void handle_client_test_command(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_test_command *cmd = buf;
+	struct gatt_app *app;
 	bdaddr_t bdaddr;
 	bt_uuid_t uuid;
 	uint8_t status;
@@ -3475,6 +3476,13 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 		status = handle_connect(test_client_if, &bdaddr);
 		break;
 	case GATT_CLIENT_TEST_CMD_DISCONNECT:
+		app = queue_find(gatt_apps, match_app_by_id,
+						INT_TO_PTR(test_client_if));
+		if (app)
+			app_disconnect_devices(app);
+
+		status = HAL_STATUS_SUCCESS;
+		break;
 	case GATT_CLIENT_TEST_CMD_DISCOVER:
 	case GATT_CLIENT_TEST_CMD_PAIRING_CONFIG:
 	default:
-- 
2.0.0.rc4

