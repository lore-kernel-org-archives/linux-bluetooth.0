Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] shared/hfp: Fix calling callback without result_pending set
Date: Thu,  5 Feb 2015 16:07:09 +0100
Message-Id: <1423148831-25507-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Always set pending_result before calling command callback.

If response will be send from callback pending_result will be
cleared by either hfp_gw_send_result or hfp_gw_send_error.
---
 src/shared/hfp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 0ce3121..ea6494d 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -183,8 +183,8 @@ static void handle_unknown_at_command(struct hfp_gw *hfp,
 							const char *data)
 {
 	if (hfp->command_callback) {
-		hfp->command_callback(data, hfp->command_data);
 		hfp->result_pending = true;
+		hfp->command_callback(data, hfp->command_data);
 	} else {
 		hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
 	}
@@ -263,6 +263,7 @@ done:
 		return true;
 	}
 
+	hfp->result_pending = true;
 	handler->callback(&context, type, handler->user_data);
 
 	return true;
-- 
1.9.1

