Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/22] blueatchat: Add bluetooth at chat module skeleton
Date: Mon, 14 Oct 2013 10:34:25 +0200
Message-Id: <1381739678-16260-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds AT chat module skeleton used for sending and receiving
AT commands. This patch contains only part required for reading.
---
 src/shared/blueatchat.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/blueatchat.h |   50 ++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 src/shared/blueatchat.c
 create mode 100644 src/shared/blueatchat.h

diff --git a/src/shared/blueatchat.c b/src/shared/blueatchat.c
new file mode 100644
index 0000000..be26bad
--- /dev/null
+++ b/src/shared/blueatchat.c
@@ -0,0 +1,92 @@
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
+#include <stdlib.h>
+#include <glib.h>
+
+#include "blueatchat.h"
+#include "util.h"
+
+#define BLUEATCHAT_DEBUG(session, ...) (util_debug(session->debug_callback, \
+						(void *)__func__, __VA_ARGS__))
+struct blueatchat_session {
+	struct blueatchat_config *config;
+	struct blueatchat_cmd_descriptor *cmd_list;
+	GSList *data;	/* stores parsed data */
+	blueatchat_debug_func_t debug_callback;
+	/* TODO: Add ring buffer. */
+};
+
+
+bool blueatchat_read(struct blueatchat_session *session, GIOChannel *gio)
+{
+	GIOStatus ret = G_IO_STATUS_EOF;
+	GError *err = NULL;
+	gchar *msg;
+	gsize len;
+
+	/* TODO: use ring buffer inside the session object */
+	ret = g_io_channel_read_line(gio, &msg, &len, NULL, &err);
+	if (ret == G_IO_STATUS_ERROR)
+		BLUEATCHAT_DEBUG(session, "Error reading: %s\n", err->message);
+	else
+		BLUEATCHAT_DEBUG(session, "Blueatchat red %u bytes: %s",
+							(unsigned int)len, msg);
+
+	/* TODO: process buffered data
+	 *	-> check for complete command (check for head, tail)
+	 *	-> start consuming buffered data and parsing it
+	 *	-> iterate through session->cmd_list and match commands
+	 *	-> peek a char to choose appropriate parser routine or use
+	 *		syntax descriptor string?
+	 *	-> fill in sessions GSList* data with parsed data
+	 *	-> call '*(session->cmd_list[cmd_index].notify)(session->data)
+	 */
+	g_free(msg);
+	return true;
+}
+
+struct blueatchat_session *blueatchat_init_session(
+				struct blueatchat_config *config,
+				struct blueatchat_cmd_descriptor *cmd_list,
+				blueatchat_debug_func_t debug_fun)
+{
+	struct blueatchat_session *session =
+				g_new(struct blueatchat_session, 1);
+
+	session->cmd_list = cmd_list;
+	session->config = config;
+	session->debug_callback = debug_fun;
+	/* TODO: initialize ring buffer */
+	return session;
+}
+
+void blueatchat_cleanup_session(struct blueatchat_session *session)
+{
+	session->cmd_list = NULL;
+	session->config = NULL;
+	session->debug_callback = NULL;
+
+	g_free(session);
+	session = NULL;
+}
diff --git a/src/shared/blueatchat.h b/src/shared/blueatchat.h
new file mode 100644
index 0000000..9c1ca1b
--- /dev/null
+++ b/src/shared/blueatchat.h
@@ -0,0 +1,50 @@
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
+#include <stdbool.h>
+
+typedef void (*blueatchat_debug_func_t)(const char *str, void *user_data);
+typedef bool (*blueatchat_notify_cb)(GSList *);
+
+/* command/response descriptor */
+struct blueatchat_cmd_descriptor {
+	char *cmd;	 /* cmd/response string to match */
+	char *cmd_descr; /* data descriptor  - expected data to be parsed */
+	blueatchat_notify_cb notify; /* callback for the given command */
+};
+
+/* simple config */
+struct blueatchat_config {
+	size_t buff_size;
+	char *cmd_prefix;
+	char *cmd_postfix;
+};
+
+struct blueatchat_session;
+
+struct blueatchat_session *blueatchat_init_session(
+				struct blueatchat_config *config,
+				struct blueatchat_cmd_descriptor *cmd_list,
+				blueatchat_debug_func_t debug_fun);
+void blueatchat_cleanup_session(struct blueatchat_session *session);
+bool blueatchat_read(struct blueatchat_session *session, GIOChannel *gio);
-- 
1.7.9.5

