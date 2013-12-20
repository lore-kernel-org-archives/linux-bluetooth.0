Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/bluetooth-hal: Fix using wrong struct for buffer size
Date: Fri, 20 Dec 2013 13:50:41 +0100
Message-Id: <1387543842-6489-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Buffer is for hal_cmd_le_test_mode command.
---
 android/hal-bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 2232ebe..3dbc435 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -812,7 +812,7 @@ static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
 #if PLATFORM_SDK_VERSION > 17
 static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t len)
 {
-	uint8_t cmd_buf[sizeof(struct hal_cmd_dut_mode_send) + len];
+	uint8_t cmd_buf[sizeof(struct hal_cmd_le_test_mode) + len];
 	struct hal_cmd_le_test_mode *cmd = (void *) cmd_buf;
 
 	DBG("opcode %u len %u", opcode, len);
-- 
1.8.3.2

