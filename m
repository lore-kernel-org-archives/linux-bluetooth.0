Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFCv2 2/2] android/gatt: Add test command for database dump
Date: Mon,  2 Jun 2014 15:19:31 +0200
Message-Id: <1401715171-29175-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401715171-29175-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401715171-29175-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this we can check all attributes handles, uuids, permissions etc.
on demand without adding to much logs. This will help to execute and
verify some PTS test cases and debug.
---
 android/gatt.c    | 4 ++++
 android/hal-msg.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 429181f..83a051b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3543,6 +3543,10 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 		status = test_read_write(&bdaddr, &uuid, cmd->u1, cmd->u2,
 						cmd->u3, cmd->u4, cmd->u5);
 		break;
+	case GATT_CLIENT_TEST_CMD_DB_DUMP:
+		gatt_db_dump(gatt_db);
+		status = HAL_STATUS_SUCCESS;
+		break;
 	case GATT_CLIENT_TEST_CMD_PAIRING_CONFIG:
 	default:
 		status = HAL_STATUS_FAILED;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5da62f3..ce86304 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -753,6 +753,7 @@ struct hal_cmd_gatt_client_set_adv_data {
 #define GATT_CLIENT_TEST_CMD_DISCOVER		0x04
 #define GATT_CLIENT_TEST_CMD_READ		0xe0
 #define GATT_CLIENT_TEST_CMD_WRITE		0xe1
+#define GATT_CLIENT_TEST_CMD_DB_DUMP		0xe2
 #define GATT_CLIENT_TEST_CMD_PAIRING_CONFIG	0xf0
 
 #define HAL_OP_GATT_CLIENT_TEST_COMMAND		0x16
-- 
2.0.0

