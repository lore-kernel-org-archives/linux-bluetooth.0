Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 2/6] shared/hfp: Add implementiation of processing commands
Date: Sat,  1 Mar 2014 21:00:42 +0100
Message-Id: <1393704046-4317-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393704046-4317-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393704046-4317-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will look for prefix handler for given cammand.
---
 src/shared/hfp.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 4 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 4bf993d..945f36e 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -29,6 +29,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdarg.h>
+#include <ctype.h>
 
 #include "src/shared/util.h"
 #include "src/shared/ringbuf.h"
@@ -69,6 +70,11 @@ struct cmd_handler {
 	hfp_result_func_t callback;
 };
 
+struct hfp_gw_result {
+	const char *data;
+	int offset;
+};
+
 static void destroy_cmd_handler(void *data)
 {
 	struct cmd_handler *handler = data;
@@ -130,6 +136,88 @@ static void wakeup_writer(struct hfp_gw *hfp)
 	hfp->writer_active = true;
 }
 
+static void skip_whitespace(struct hfp_gw_result *result)
+{
+	while (result->data[result->offset] == ' ')
+		result->offset++;
+}
+
+static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
+{
+	struct cmd_handler *handler;
+	const char *separators = ";?=\0";
+	struct hfp_gw_result result;
+	enum hfp_gw_cmd_type type;
+	char lookup_prefix[18];
+	uint8_t pref_len = 0;
+	const char *prefix;
+	int i;
+
+	result.offset = 0;
+	result.data = data;
+
+	skip_whitespace(&result);
+
+	if (strlen(data + result.offset) < 3)
+		return false;
+
+	if (strncmp(data + result.offset, "AT", 2))
+		if (strncmp(data + result.offset, "at", 2))
+			return false;
+
+	result.offset += 2;
+	prefix = data + result.offset;
+
+	if (isalpha(prefix[0])) {
+		lookup_prefix[pref_len++] = toupper(prefix[0]);
+	} else {
+		pref_len = strcspn(prefix, separators);
+		if (pref_len > 17 || pref_len < 2)
+			return false;
+
+		for (i = 0; i < pref_len; i++)
+			lookup_prefix[i] = toupper(prefix[i]);
+	}
+
+	lookup_prefix[pref_len] = '\0';
+	result.offset += pref_len;
+
+	if (lookup_prefix[0] == 'D') {
+		type = HFP_GW_CMD_TYPE_SET;
+		goto done;
+	}
+
+	if (data[result.offset] == '=') {
+		result.offset++;
+		if (data[result.offset] == '?') {
+			result.offset++;
+			type = HFP_GW_CMD_TYPE_TEST;
+		} else {
+			type = HFP_GW_CMD_TYPE_SET;
+		}
+		goto done;
+	}
+
+	if (data[result.offset] == '?') {
+		result.offset++;
+		type = HFP_GW_CMD_TYPE_READ;
+		goto done;
+	}
+
+	type = HFP_GW_CMD_TYPE_COMMAND;
+
+done:
+
+	handler = queue_find(hfp->cmd_handlers, match_handler_prefix,
+								lookup_prefix);
+	if (!handler)
+		return false;
+
+	handler->callback(&result, type, handler->user_data);
+
+	return true;
+}
+
 static void process_input(struct hfp_gw *hfp)
 {
 	char *str, *ptr;
@@ -162,10 +250,12 @@ static void process_input(struct hfp_gw *hfp)
 
 	hfp->result_pending = true;
 
-	if (hfp->command_callback)
-		hfp->command_callback(str, hfp->command_data);
-	else
-		hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
+	if (!call_prefix_handler(hfp, str)) {
+		if (hfp->command_callback)
+			hfp->command_callback(str, hfp->command_data);
+		else
+			hfp_gw_send_result(hfp, HFP_RESULT_ERROR);
+	}
 
 	len = ringbuf_drain(hfp->read_buf, count + 1);
 
-- 
1.8.3.1

