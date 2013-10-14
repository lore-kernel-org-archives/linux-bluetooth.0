Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/22] blueatchat: Use circullar buffer as data storage
Date: Mon, 14 Oct 2013 10:34:26 +0200
Message-Id: <1381739678-16260-11-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes blueatchat use circular buffer for storing data read
from the glib's IO channel.
---
 src/shared/blueatchat.c |   49 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/src/shared/blueatchat.c b/src/shared/blueatchat.c
index be26bad..a32a7bf 100644
--- a/src/shared/blueatchat.c
+++ b/src/shared/blueatchat.c
@@ -24,6 +24,7 @@
 #include <stdlib.h>
 #include <glib.h>
 
+#include "cbuffer.h"
 #include "blueatchat.h"
 #include "util.h"
 
@@ -32,9 +33,9 @@
 struct blueatchat_session {
 	struct blueatchat_config *config;
 	struct blueatchat_cmd_descriptor *cmd_list;
+	struct circular_buffer *buffer;
 	GSList *data;	/* stores parsed data */
 	blueatchat_debug_func_t debug_callback;
-	/* TODO: Add ring buffer. */
 };
 
 
@@ -42,16 +43,37 @@ bool blueatchat_read(struct blueatchat_session *session, GIOChannel *gio)
 {
 	GIOStatus ret = G_IO_STATUS_EOF;
 	GError *err = NULL;
-	gchar *msg;
+	gchar *msg = NULL;
+	int freechunk;
 	gsize len;
+	gsize i;
 
-	/* TODO: use ring buffer inside the session object */
-	ret = g_io_channel_read_line(gio, &msg, &len, NULL, &err);
-	if (ret == G_IO_STATUS_ERROR)
-		BLUEATCHAT_DEBUG(session, "Error reading: %s\n", err->message);
-	else
-		BLUEATCHAT_DEBUG(session, "Blueatchat red %u bytes: %s",
-							(unsigned int)len, msg);
+	/* read all data into the buffer */
+	do {
+		freechunk = cbuffer_get_free_chunk_size(session->buffer);
+
+		msg = cbuffer_get_free_cell(session->buffer);
+		if (!msg) {
+			BLUEATCHAT_DEBUG(session, "Buffer malfunction!");
+			return false;
+		}
+
+		ret = g_io_channel_read_chars(gio, msg, freechunk, &len, &err);
+		if (ret == G_IO_STATUS_ERROR) {
+			BLUEATCHAT_DEBUG(session, "Error reading: %s\n",
+							err->message);
+			return false;
+		}
+
+		if (len != 0)
+			BLUEATCHAT_DEBUG(session,
+					"Blueatchat red %u bytes: %.*s",
+					(unsigned int)len, (unsigned int)len,
+					msg);
+
+		for (i = 0; i < len; ++i)
+			cbuffer_consume_next_cell(session->buffer);
+	} while ((len != 0) && (ret != G_IO_STATUS_EOF));
 
 	/* TODO: process buffered data
 	 *	-> check for complete command (check for head, tail)
@@ -62,7 +84,6 @@ bool blueatchat_read(struct blueatchat_session *session, GIOChannel *gio)
 	 *	-> fill in sessions GSList* data with parsed data
 	 *	-> call '*(session->cmd_list[cmd_index].notify)(session->data)
 	 */
-	g_free(msg);
 	return true;
 }
 
@@ -77,7 +98,12 @@ struct blueatchat_session *blueatchat_init_session(
 	session->cmd_list = cmd_list;
 	session->config = config;
 	session->debug_callback = debug_fun;
-	/* TODO: initialize ring buffer */
+
+	session->buffer = cbuffer_init(session->config->buff_size);
+	if (!session->buffer) {
+		g_free(session);
+		return NULL;
+	}
 	return session;
 }
 
@@ -87,6 +113,7 @@ void blueatchat_cleanup_session(struct blueatchat_session *session)
 	session->config = NULL;
 	session->debug_callback = NULL;
 
+	cbuffer_free(session->buffer);
 	g_free(session);
 	session = NULL;
 }
-- 
1.7.9.5

