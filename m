Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 09/15] android/hal: Add support for sending adapter PIN reply command
Date: Fri, 25 Oct 2013 12:50:05 +0200
Message-ID: <1382698211-9123-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
References: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to reply to PIN code request.
---
 android/hal-bluetooth.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index ca443a6..6835db3 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -321,12 +321,20 @@ static int remove_bond(const bt_bdaddr_t *bd_addr)
 static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
 				uint8_t pin_len, bt_pin_code_t *pin_code)
 {
+	struct hal_cmd_pin_reply cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	cmd.accept = accept;
+	cmd.pin_len = pin_len;
+	memcpy(cmd.pin_code, pin_code, sizeof(cmd.pin_code));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_PIN_REPLY,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
-- 
1.8.4.1

