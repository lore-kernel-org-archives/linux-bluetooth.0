Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 15/22] blueatchat: Add functions for parsing data sent with the commands
Date: Mon, 14 Oct 2013 10:34:31 +0200
Message-Id: <1381739678-16260-16-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an initial attempt to parse data passed with the commands.
Parser uses syntax descriptor to find out what kind of data it should
expect and parse. Parsed data are being pushed to the list and sent
using proper callback.
---
 src/shared/blueatchat.c |  182 ++++++++++++++++++++++++++++++++++++++++++++---
 src/shared/blueatchat.h |   30 ++++++++
 src/shared/dparser.c    |   45 ++++++++++++
 src/shared/dparser.h    |   24 +++++++
 4 files changed, 273 insertions(+), 8 deletions(-)
 create mode 100644 src/shared/dparser.c
 create mode 100644 src/shared/dparser.h

diff --git a/src/shared/blueatchat.c b/src/shared/blueatchat.c
index e9b3c9d..6a12b22 100644
--- a/src/shared/blueatchat.c
+++ b/src/shared/blueatchat.c
@@ -29,6 +29,7 @@
 #include "cbuffer.h"
 #include "blueatchat.h"
 #include "util.h"
+#include "dparser.h"
 
 /* uncomment for extended debug messages */
 /* #define BLUEATCHAT_VERBOSE */
@@ -124,33 +125,196 @@ static int blueatchat_get_complete_cmd_end(struct blueatchat_session *session)
 	return -ENODATA;
 }
 
+static char *blueatchat_buffdup(struct circular_buffer *buffer,
+					unsigned int amount)
+{
+	/*
+	 * Returns a pointer to newly allocated string containing 'amount'
+	 * of data taken from the buffer.
+	 */
+	unsigned int i;
+	char *msg = g_try_new(char, (amount + 1));
+
+	for (i = 0; i < amount; ++i)
+		msg[i] = *cbuffer_peek_tail(buffer, i);
+	msg[amount] = '\0';
+
+	return msg;
+}
+
+/*
+ * This function returns:
+ *	< 0	for error,
+ *	= 0	for success,
+ *	> 0	for redundant data left in the buffer
+ */
+static int blueatchat_parse_data(char *descriptor, int *descr_off,
+				struct blueatchat_session *session,
+				int *data_off, int amount)
+{
+	unsigned int i;
+	int begin_offset = *data_off;
+	bool optional = false;
+	void *newdata;
+	unsigned int descrlen = strlen(descriptor);
+
+	for (i = *descr_off; i < descrlen; ++i) {
+		char ch = descriptor[i];
+		newdata = NULL;
+
+		/*
+		 * Safety check if no more data in this command and descriptor
+		 * indicates that more optional data may follow.
+		 */
+		if (*data_off - begin_offset == amount)
+			return 0;
+
+		switch (ch) {
+		case '(':	/* compound value start */
+			BLUEATCHAT_DEBUG(session, "(");
+			break;
+		case 'o':	/* optional value */
+			BLUEATCHAT_DEBUG(session, "o");
+
+			/* Parse following data with proper flag set */
+			optional = true;
+			continue;
+		case 'u':	/* integer value */
+			BLUEATCHAT_DEBUG(session, "u");
+
+			newdata = dparse_uint(session->buffer, data_off);
+			if (!newdata && !optional)
+				return -ENODATA;
+
+			session->data = g_slist_prepend(session->data, newdata);
+			break;
+		case 'q':	/* quoted string */
+			BLUEATCHAT_DEBUG(session, "q");
+			break;
+		case 's':	/* TODO: unquoted string */
+			BLUEATCHAT_DEBUG(session, "s");
+			break;
+		case ')':	/* compound value end */
+			BLUEATCHAT_DEBUG(session, ")");
+			break;
+		case ',':	/* value separator */
+			BLUEATCHAT_DEBUG(session, ",");
+			break;
+		case '*':
+			/*
+			 * Do nothing as `*` should only exist at the very end
+			 * of command descriptor and in next loop iteration
+			 * loop will stop anyway.
+			 */
+			break;
+		default:
+			BLUEATCHAT_DEBUG(session, "unknown descriptor");
+			break;
+		}
+	}
+	BLUEATCHAT_DEBUG(session, "parsed %i/%i bytes",
+				*data_off - begin_offset, amount);
+
+	/*
+	 * If no data was parsed try different match returning error
+	 * return 1 if not all data has been parsed but data partially matched.
+	 */
+	if (*data_off - begin_offset == 0)
+		return -ENODATA;
+	else if (*data_off - begin_offset < amount)
+		return 1;
+
+	return 0;
+}
+
 static int blueatchat_parse_command(struct blueatchat_session *session,
 				const int amount)
 {
 	struct blueatchat_cmd_descriptor *item;
+	char *prefix = session->config->cmd_prefix;
+	char *postfix = session->config->cmd_postfix;
+	int data_off = 0;
+	int descr_off = 0;
 
 	BLUEATCHAT_DEBUG(session, "Starting");
 #ifdef BLUEATCHAT_VERBOSE
 	blueatchat_buffer_dump(session, amount);
 #endif
 
+	/* memory leaks shouldn't happen */
+	g_assert(!session->data);
+
 	for (item = session->cmd_list; item->cmd != NULL; ++item) {
+		descr_off = 0;
+		data_off = 0;
 		if (cbuffer_starts_with_seq(session->buffer, item->cmd,
-					strlen(session->config->cmd_prefix))) {
-			/* TODO: process buffered data
-			 *-> peek a char to choose appropriate parser routine
-			 *	or use syntax descriptor string?
-			 *-> fill in sessions GSList* data with parsed data
+							strlen(prefix))) {
+			/*
+			 * Parse only if data is expected, and do not populate
+			 * the list if something was parsed wrong. Instead
+			 * calling callback with wrong or without data treat
+			 * this command as vendor/unknown/not matching one.
 			 */
+			if (item->cmd_descr) {
+				int res;
+				/* start parsing right where data is */
+				data_off = strlen(prefix) + strlen(item->cmd);
+
+				BLUEATCHAT_DEBUG(session,
+							"Checking for data: %s",
+							item->cmd_descr);
+
+				res = blueatchat_parse_data(item->cmd_descr,
+							&descr_off, session,
+							&data_off,
+							amount - (data_off +
+							strlen(postfix)));
+				if (res < 0) {
+					/*
+					 * Error may be triggered in the middle
+					 * of parsing when some data has already
+					 * been pushed to the data list.
+					 * Clean that up.
+					 */
+					g_slist_free_full(session->data,
+									g_free);
+					session->data = NULL;
+					continue;
+				} else if (res > 0) {
+					BLUEATCHAT_DEBUG(session,
+							"redundant data found");
+				}
+			} else {
+				/*
+				 * Check if there is really no data, like
+				 * descriptor indicates. If there is, this
+				 * may be a different command.
+				 */
+				if ((strlen(session->config->cmd_prefix) +
+					strlen(postfix) + strlen(item->cmd)) !=
+							(unsigned int)amount)
+					continue;
+			}
+
 			item->notify(session->data);
+
+			/* Free all data after notification returns */
+			g_slist_free_full(session->data, g_free);
+			session->data = NULL;
 			cbuffer_discard(session->buffer, amount);
 			return 0;
 		}
 	}
-	/* no matching command */
-	/* TODO: push unknown or vendor message string to GSList and notify */
-	item->notify(session->data);
+	/* Unknown or vendor command - push it to upper layers */
+	session->data = g_slist_prepend(session->data,
+					blueatchat_buffdup(session->buffer,
+								amount));
 	cbuffer_discard(session->buffer, amount);
+	item->notify(session->data);
+
+	/* Free data after notification returns */
+	g_slist_free_full(session->data, g_free);
+	session->data = NULL;
 	return 1;
 }
 
@@ -234,6 +398,7 @@ struct blueatchat_session *blueatchat_init_session(
 	session->cmd_list = cmd_list;
 	session->config = config;
 	session->debug_callback = debug_fun;
+	session->data = NULL;
 
 	session->buffer = cbuffer_init(session->config->buff_size);
 	if (!session->buffer) {
@@ -249,6 +414,7 @@ void blueatchat_cleanup_session(struct blueatchat_session *session)
 	session->config = NULL;
 	session->debug_callback = NULL;
 
+	g_slist_free_full(session->data, g_free);
 	cbuffer_free(session->buffer);
 	g_free(session);
 	session = NULL;
diff --git a/src/shared/blueatchat.h b/src/shared/blueatchat.h
index 9c1ca1b..75d055c 100644
--- a/src/shared/blueatchat.h
+++ b/src/shared/blueatchat.h
@@ -21,6 +21,36 @@
  *
  */
 
+/*
+ *	cmd_descr - string describing commands content
+ *
+ * It uses the following characters to describe expected data units:
+ *	,	- unit/value separator
+ *	(	- compound value section begin
+ *	)	- compound value section end
+ *	o	- optional value
+ *	u	- unsigned integer
+ *	i	- integer
+ *	*	- unsignificant - its should be used for ignoring the rest of
+ *		  data in this command - can only be used at the very end
+ *	c	- single unquoted char, like in "AT+VTS=A"
+ *	s	- string
+ *	q	- quoted string
+ *	-	- indicates value range like in "+CIND: ("callsetup",(0-3))"
+ *
+ * Example:
+ *	(oi,q)	- compund value with optional integer and a mandatory string.
+ *
+ * Combinations should be possible:
+ *	(oq,oq),(oq,i),u,oq,oi
+ *	which should match string like: `(,),("Test message",1023),256,,1`
+ *
+ * Nesting should be possible:
+ *	(u,q,(oq,(q,i),i,u,q),i)
+ *
+ * TODO: add more descriptors if needed.
+ */
+
 #include <stdbool.h>
 
 typedef void (*blueatchat_debug_func_t)(const char *str, void *user_data);
diff --git a/src/shared/dparser.c b/src/shared/dparser.c
new file mode 100644
index 0000000..7b7a2a2
--- /dev/null
+++ b/src/shared/dparser.c
@@ -0,0 +1,45 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <ctype.h>
+#include <glib.h>
+
+#include "cbuffer.h"
+#include "dparser.h"
+
+unsigned int *dparse_uint(struct circular_buffer *buffer, int *offset)
+{
+	unsigned int *ret;
+	const char *ch = cbuffer_peek_tail(buffer, *offset);
+
+	if (!isdigit(*ch))
+		return NULL;
+
+	ret = g_new0(unsigned int, 1);
+
+	while (isdigit(*ch)) {
+		*ret = (*ret * 10) + (*ch - '0');
+		ch = cbuffer_peek_tail(buffer, ++(*offset));
+	}
+	return ret;
+}
diff --git a/src/shared/dparser.h b/src/shared/dparser.h
new file mode 100644
index 0000000..7c0bf58
--- /dev/null
+++ b/src/shared/dparser.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+unsigned int *dparse_uint(struct circular_buffer *buffer, int *offset);
-- 
1.7.9.5

