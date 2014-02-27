Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/8] shared/hfp: Add implementation of precessing commands
Date: Thu, 27 Feb 2014 10:40:02 +0100
Message-Id: <1393494006-20363-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will process both extended and basic commands.
---
 src/shared/hfp.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index cf54a8f..6a39a36 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -29,6 +29,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdarg.h>
+#include <ctype.h>
 
 #include "src/shared/util.h"
 #include "src/shared/ringbuf.h"
@@ -135,14 +136,105 @@ static void wakeup_writer(struct hfp_gw *hfp)
 	hfp->writer_active = true;
 }
 
+static enum hfp_cmd_type get_cmd_type(struct hfp_gw_result *result)
+{
+	if (result->data[result->offset] == '=') {
+		result->offset++;
+		if (result->data[result->offset] == '?') {
+			result->offset++;
+			return HFP_AT_TEST;
+		} else {
+			return HFP_AT_SET;
+		}
+	} else if (result->data[result->offset] == '?') {
+		result->offset++;
+		return HFP_AT_READ;
+	} else {
+		return HFP_AT_COMMAND;
+	}
+}
+
 static bool process_basic(struct hfp_gw *hfp, struct hfp_gw_result *result)
 {
-	return false;
+	const char *prefix = result->data + result->offset;
+	struct prefix_handler_data *handler;
+	enum hfp_cmd_type type;
+	char lookup_prefix[4];
+	uint8_t pref_len = 0;
+	int i;
+
+	/* Check if first sign is character */
+	if (isalpha(prefix[pref_len])) {
+		/* Handle S-parameter prefix */
+		if (toupper(prefix[pref_len]) == 'S') {
+			do {
+				pref_len++;
+			} while (isdigit(prefix[pref_len]));
+			/*S-parameter must be followed with number*/
+			if (pref_len == 1)
+				pref_len--;
+		} else {
+			/* It's just one-character prefix */
+			pref_len++;
+		}
+	}
+
+	if (pref_len == 0 || pref_len > sizeof(lookup_prefix))
+		return false;
+
+	for (i = 0; i < pref_len; i++)
+		lookup_prefix[i] = toupper(prefix[i]);
+
+	result->offset += pref_len;
+	lookup_prefix[pref_len] = '\0';
+
+	if (lookup_prefix[0] == 'D')
+		type = HFP_AT_SET;
+	else
+		type = get_cmd_type(result);
+
+	handler = queue_find(hfp->prefix_handlers, match_handler_prefix,
+								lookup_prefix);
+	if (!handler)
+		return false;
+
+	handler->callback(result, type, handler->user_data);
+
+	return true;
 }
 
 static bool process_extended(struct hfp_gw *hfp, struct hfp_gw_result *result)
 {
-	return false;
+	const char *prefix = result->data + result->offset;
+	const char *separators = ";?=\0";
+	struct prefix_handler_data *handler;
+	enum hfp_cmd_type type;
+	char lookup_prefix[18];
+	uint8_t pref_len;
+	int i;
+
+	/* Lookup for first separator */
+	pref_len = strcspn(prefix, separators);
+
+	if (pref_len > 17 || pref_len < 2)
+		return false;
+
+	for (i = 0; i < pref_len; i++)
+		lookup_prefix[i] = toupper(prefix[i]);
+
+	result->offset += pref_len;
+	lookup_prefix[pref_len] = '\0';
+
+	type = get_cmd_type(result);
+
+	handler = queue_find(hfp->prefix_handlers, match_handler_prefix,
+								lookup_prefix);
+	if (!handler)
+		return false;
+
+	handler->callback(result, type, handler->user_data);
+
+	return true;
 }
 
 static void skip_whitespace(struct hfp_gw_result *result)
-- 
1.8.3.1

