Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/8] shared/hfp: Fix parsing line with few commands
Date: Thu, 27 Feb 2014 10:39:59 +0100
Message-Id: <1393494006-20363-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If hfp_gw received line with few commands, it called command
handler one time, for first command. Next comamnd was processed
only if next line was received.
Now, after every response from gw, we call proces_input to be
sure that all data has been be processed.
It will process next command only if response for previous was sent.
---
 src/shared/hfp.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 854cf46..0681b19 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -121,23 +121,21 @@ static void process_input(struct hfp_gw *hfp)
 
 		*ptr = '\0';
 		count = asprintf(&ptr, "%s%s", str, str2);
-		str = ptr;
 	} else {
-		count = ptr - str;
 		*ptr = '\0';
+		count = asprintf(&ptr, "%s", str);
 	}
 
 	hfp->result_pending = true;
 
+	len = ringbuf_drain(hfp->read_buf, count + 1);
+
 	if (hfp->command_callback)
-		hfp->command_callback(str, hfp->command_data);
+		hfp->command_callback(ptr, hfp->command_data);
 	else
 		hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
 
-	len = ringbuf_drain(hfp->read_buf, count + 1);
-
-	if (str == ptr)
-		free(ptr);
+	free(ptr);
 }
 
 static void read_watch_destroy(void *user_data)
@@ -341,6 +339,8 @@ bool hfp_gw_send_result(struct hfp_gw *hfp, enum hfp_result result)
 
 	hfp->result_pending = false;
 
+	process_input(hfp);
+
 	return true;
 }
 
@@ -356,6 +356,8 @@ bool hfp_gw_send_error(struct hfp_gw *hfp, enum hfp_error error)
 
 	hfp->result_pending = false;
 
+	process_input(hfp);
+
 	return true;
 }
 
-- 
1.8.3.1

