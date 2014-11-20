Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 5/8] shared/hfp: Refactor call_prefix_handler
Date: Thu, 20 Nov 2014 16:55:12 +0100
Message-Id: <1416498915-19534-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416498915-19534-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch call_prefix_handle gets new name handle_at_command and
returns true if correct at command has been handled or false when
provided data does not contain any AT command.
---
 src/shared/hfp.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 42e4c6b..2a09658 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -179,7 +179,18 @@ static void skip_whitespace(struct hfp_context *context)
 		context->offset++;
 }
 
-static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
+static void handle_unknown_at_command(struct hfp_gw *hfp,
+							const char *data)
+{
+	if (hfp->command_callback) {
+		hfp->command_callback(data, hfp->command_data);
+		hfp->result_pending = true;
+	} else {
+		hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
+	}
+}
+
+static bool handle_at_command(struct hfp_gw *hfp, const char *data)
 {
 	struct cmd_handler *handler;
 	const char *separators = ";?=\0";
@@ -247,8 +258,10 @@ done:
 
 	handler = queue_find(hfp->cmd_handlers, match_handler_prefix,
 								lookup_prefix);
-	if (!handler)
-		return false;
+	if (!handler) {
+		handle_unknown_at_command(hfp, data);
+		return true;
+	}
 
 	handler->callback(&context, type, handler->user_data);
 
@@ -505,14 +518,7 @@ static void process_input(struct hfp_gw *hfp)
 		*ptr = '\0';
 	}
 
-	if (!call_prefix_handler(hfp, str)) {
-		if (hfp->command_callback) {
-			hfp->command_callback(str, hfp->command_data);
-			hfp->result_pending = true;
-		} else {
-			hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
-		}
-	}
+	handle_at_command(hfp, str);
 
 	len = ringbuf_drain(hfp->read_buf, count + 1);
 
-- 
1.8.4

