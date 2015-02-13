Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH BlueZ v2 2/6] android/handsfree: Fix possible invalid memory write
Date: Thu, 12 Feb 2015 19:48:33 -0800
Message-Id: <1423799317-28457-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1423799317-28457-1-git-send-email-jpawlowski@google.com>
References: <1423799317-28457-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

Copy command to IPC buffer only after checking string size.
---
 android/handsfree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 4af2a89..ba798ee 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -319,13 +319,14 @@ static void at_cmd_unknown(const char *command, void *user_data)
 
 	/* copy while string including terminating NULL */
 	ev->len = strlen(command) + 1;
-	memcpy(ev->buf, command, ev->len);
 
 	if (ev->len > IPC_MTU - sizeof(*ev)) {
 		hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
 		return;
 	}
 
+	memcpy(ev->buf, command, ev->len);
+
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
 			HAL_EV_HANDSFREE_UNKNOWN_AT, sizeof(*ev) + ev->len, ev);
 }
-- 
2.2.0.rc0.207.ga3a616c

