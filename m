Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 12/15] android/hal: Add support for sending adapter SSP reply command
Date: Fri, 25 Oct 2013 12:50:08 +0200
Message-ID: <1382698211-9123-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
References: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows HAL to reply to SSP request.
---
 android/hal-bluetooth.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 6835db3..eb400ee 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -340,15 +340,21 @@ static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
 static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
 					uint8_t accept, uint32_t passkey)
 {
+	struct hal_cmd_ssp_reply cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
-	if (!bd_addr)
-		return BT_STATUS_PARM_INVALID;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+	/* type match IPC type */
+	cmd.ssp_variant = variant;
+	cmd.accept = accept;
+	cmd.passkey = passkey;
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_SSP_REPLY,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static const void *get_profile_interface(const char *profile_id)
-- 
1.8.4.1

