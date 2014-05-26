Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 4/5] android/gatt: Implement connect test command
Date: Mon, 26 May 2014 23:53:27 +0200
Message-Id: <1401141208-26912-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
References: <1401141208-26912-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 1ce6ff9..6eb4440 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3471,6 +3471,9 @@ static void handle_client_test_command(const void *buf, uint16_t len)
 		}
 		break;
 	case GATT_CLIENT_TEST_CMD_CONNECT:
+		/* TODO u1 holds device type, for now assume BLE */
+		status = handle_connect(test_client_if, &bdaddr);
+		break;
 	case GATT_CLIENT_TEST_CMD_DISCONNECT:
 	case GATT_CLIENT_TEST_CMD_DISCOVER:
 	case GATT_CLIENT_TEST_CMD_PAIRING_CONFIG:
-- 
2.0.0.rc4

