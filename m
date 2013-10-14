Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 14/22] blueatchat: Add basic parsing capability
Date: Mon, 14 Oct 2013 10:34:30 +0200
Message-Id: <1381739678-16260-15-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds registered commands recognition and callback calls.
---
 src/shared/blueatchat.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/src/shared/blueatchat.c b/src/shared/blueatchat.c
index c7eee4a..e9b3c9d 100644
--- a/src/shared/blueatchat.c
+++ b/src/shared/blueatchat.c
@@ -30,8 +30,16 @@
 #include "blueatchat.h"
 #include "util.h"
 
+/* uncomment for extended debug messages */
+/* #define BLUEATCHAT_VERBOSE */
+
+#ifdef BLUEATCHAT_VERBOSE
 #define BLUEATCHAT_DEBUG(session, ...) (util_debug(session->debug_callback, \
 						(void *)__func__, __VA_ARGS__))
+#else
+#define BLUEATCHAT_DEBUG(...) {}
+#endif
+
 struct blueatchat_session {
 	struct blueatchat_config *config;
 	struct blueatchat_cmd_descriptor *cmd_list;
@@ -40,6 +48,23 @@ struct blueatchat_session {
 	blueatchat_debug_func_t debug_callback;
 };
 
+#ifdef BLUEATCHAT_VERBOSE
+static void blueatchat_buffer_dump(struct blueatchat_session *session,
+							unsigned int amount)
+{
+	unsigned int i;
+	struct circular_buffer *buffer = session->buffer;
+
+	BLUEATCHAT_DEBUG(session, "BEGIN");
+	for (i = 0; i < cbuffer_get_length(buffer); ++i) {
+		if (i == amount)
+			break;
+		BLUEATCHAT_DEBUG(session, "%c", *cbuffer_peek_tail(buffer, i));
+	}
+	BLUEATCHAT_DEBUG(session, "END");
+}
+#endif
+
 /*
  * returns offset:
  *	> 0	- if complete command found, which ends at offset
@@ -99,13 +124,45 @@ static int blueatchat_get_complete_cmd_end(struct blueatchat_session *session)
 	return -ENODATA;
 }
 
+static int blueatchat_parse_command(struct blueatchat_session *session,
+				const int amount)
+{
+	struct blueatchat_cmd_descriptor *item;
+
+	BLUEATCHAT_DEBUG(session, "Starting");
+#ifdef BLUEATCHAT_VERBOSE
+	blueatchat_buffer_dump(session, amount);
+#endif
+
+	for (item = session->cmd_list; item->cmd != NULL; ++item) {
+		if (cbuffer_starts_with_seq(session->buffer, item->cmd,
+					strlen(session->config->cmd_prefix))) {
+			/* TODO: process buffered data
+			 *-> peek a char to choose appropriate parser routine
+			 *	or use syntax descriptor string?
+			 *-> fill in sessions GSList* data with parsed data
+			 */
+			item->notify(session->data);
+			cbuffer_discard(session->buffer, amount);
+			return 0;
+		}
+	}
+	/* no matching command */
+	/* TODO: push unknown or vendor message string to GSList and notify */
+	item->notify(session->data);
+	cbuffer_discard(session->buffer, amount);
+	return 1;
+}
+
 static void process_bufferred_data(struct blueatchat_session *session)
 {
 	struct circular_buffer *buffer = session->buffer;
 	int offset;
 
+	/* Stop processing if buffer empty or offset < 0 (incomplete data) */
 	while ((offset = blueatchat_get_complete_cmd_end(session)) >= 0) {
-		/* TODO: parse the data */
+		if (offset)
+			blueatchat_parse_command(session, offset);
 
 		if (cbuffer_is_empty(buffer))
 			return;
-- 
1.7.9.5

