Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/10] android/hal-bluetooth: Add support for dut mode configure command
Date: Tue, 19 Nov 2013 16:51:49 +0100
Message-Id: <1384876314-31347-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
References: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command is used to enter or exit DUT mode.
---
 android/hal-bluetooth.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index c74a9b3..bd7d257 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -746,12 +746,17 @@ static const void *get_profile_interface(const char *profile_id)
 
 static int dut_mode_configure(uint8_t enable)
 {
-	DBG("");
+	struct hal_cmd_dut_mode_conf cmd;
+
+	DBG("enable %u", enable);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.enable = enable;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_DUT_MODE_CONF,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
-- 
1.8.4.3

