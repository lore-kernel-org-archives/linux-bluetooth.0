Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/22] blueatchat: Buffered data sanity check
Date: Mon, 14 Oct 2013 10:34:29 +0200
Message-Id: <1381739678-16260-14-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds checking for AT command prefix and postfix to determine
data completeness.
---
 src/shared/blueatchat.c |  109 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/src/shared/blueatchat.c b/src/shared/blueatchat.c
index a32a7bf..c7eee4a 100644
--- a/src/shared/blueatchat.c
+++ b/src/shared/blueatchat.c
@@ -22,6 +22,8 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
+#include <errno.h>
 #include <glib.h>
 
 #include "cbuffer.h"
@@ -38,6 +40,77 @@ struct blueatchat_session {
 	blueatchat_debug_func_t debug_callback;
 };
 
+/*
+ * returns offset:
+ *	> 0	- if complete command found, which ends at offset
+ *	< 0	- if no complete command found wait for more
+ *	= 0	- some garbage was consumed check again
+ */
+static int blueatchat_get_complete_cmd_end(struct blueatchat_session *session)
+{
+	struct blueatchat_config *config = session->config;
+	struct circular_buffer *buffer = session->buffer;
+	int offset;
+	unsigned int prelen = strlen(config->cmd_prefix);
+
+	/* Check for command prefix */
+	offset = cbuffer_seek_tail_for_seq(buffer, config->cmd_prefix, 0);
+
+	/* Not enough data if only prefix in the buffer */
+	if (cbuffer_get_length(session->buffer) == prelen)
+		return -ENODATA;
+
+	/* No prefix - drain the buffer */
+	if (offset < 0) {
+		cbuffer_drain(buffer);
+		return -ENODATA;
+	}
+
+	/* Discard data before the prefix */
+	if (offset) {
+		cbuffer_discard(session->buffer, offset);
+		return 0;
+	}
+
+	/* check for postfix */
+	offset = cbuffer_seek_tail_for_seq(buffer, config->cmd_postfix, prelen);
+
+	/* If prefix != postfix check for multiple prefixing before postfix */
+	if (strncmp(config->cmd_prefix, config->cmd_postfix, prelen)) {
+		int off = cbuffer_seek_tail_for_seq(buffer, config->cmd_prefix,
+								prelen);
+
+		/* If second prefix exist before postfix consume */
+		if (off > 0 && off < offset) {
+			cbuffer_discard(session->buffer, off);
+			return 0;
+		}
+	}
+
+	/* If <fix><fix> consume one fix and check again later */
+	if (offset == (int)prelen) {
+		cbuffer_discard(session->buffer, offset);
+		return 0;
+	} else if (offset > 0) {
+		return offset + strlen(config->cmd_postfix);
+	}
+
+	/* If offset == 0 no tail found wait for more */
+	return -ENODATA;
+}
+
+static void process_bufferred_data(struct blueatchat_session *session)
+{
+	struct circular_buffer *buffer = session->buffer;
+	int offset;
+
+	while ((offset = blueatchat_get_complete_cmd_end(session)) >= 0) {
+		/* TODO: parse the data */
+
+		if (cbuffer_is_empty(buffer))
+			return;
+	}
+}
 
 bool blueatchat_read(struct blueatchat_session *session, GIOChannel *gio)
 {
@@ -48,10 +121,24 @@ bool blueatchat_read(struct blueatchat_session *session, GIOChannel *gio)
 	gsize len;
 	gsize i;
 
-	/* read all data into the buffer */
+	/* Fill the buffer in chunks if needed to drain the IO */
 	do {
 		freechunk = cbuffer_get_free_chunk_size(session->buffer);
 
+		/* Free some space by processing the buffer if its full */
+		if (!freechunk) {
+			process_bufferred_data(session);
+
+			/* If couldn't process anything discard all data */
+			if (!cbuffer_get_free_chunk_size(session->buffer))
+				cbuffer_drain(session->buffer);
+			continue;
+		}
+
+		/*
+		 * If there is no space after processing or draining the buffer
+		 * we have a serious buffer error.
+		 */
 		msg = cbuffer_get_free_cell(session->buffer);
 		if (!msg) {
 			BLUEATCHAT_DEBUG(session, "Buffer malfunction!");
@@ -65,25 +152,17 @@ bool blueatchat_read(struct blueatchat_session *session, GIOChannel *gio)
 			return false;
 		}
 
-		if (len != 0)
-			BLUEATCHAT_DEBUG(session,
-					"Blueatchat red %u bytes: %.*s",
-					(unsigned int)len, (unsigned int)len,
-					msg);
-
 		for (i = 0; i < len; ++i)
 			cbuffer_consume_next_cell(session->buffer);
+
+		freechunk = cbuffer_get_free_chunk_size(session->buffer);
 	} while ((len != 0) && (ret != G_IO_STATUS_EOF));
 
-	/* TODO: process buffered data
-	 *	-> check for complete command (check for head, tail)
-	 *	-> start consuming buffered data and parsing it
-	 *	-> iterate through session->cmd_list and match commands
-	 *	-> peek a char to choose appropriate parser routine or use
-	 *		syntax descriptor string?
-	 *	-> fill in sessions GSList* data with parsed data
-	 *	-> call '*(session->cmd_list[cmd_index].notify)(session->data)
+	/*
+	 * Now check for data completeness (command prefix and postfix).
+	 * Than parse it and consume parsed data from the buffer.
 	 */
+	process_bufferred_data(session);
 	return true;
 }
 
-- 
1.7.9.5

