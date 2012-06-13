Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH obexd 7/7] Fix some common spelling errors
Date: Wed, 13 Jun 2012 22:49:23 +0200
Message-Id: <1339620563-25161-7-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
References: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix spelling errors reported by codespell.
---
 plugins/irmc.c     |    2 +-
 plugins/messages.h |    2 +-
 src/manager.c      |    4 ++--
 src/obex.c         |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 8344a47..87f3b6c 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -172,7 +172,7 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 	/* loop around buffer and add X-IRMC-LUID attribs */
 	s = buffer;
 	while ((t = strstr(s, "UID:")) != NULL) {
-		/* add upto UID: into buffer */
+		/* add up to UID: into buffer */
 		irmc->buffer = g_string_append_len(irmc->buffer, s, t-s);
 		/*
 		 * add UID: line into buffer
diff --git a/plugins/messages.h b/plugins/messages.h
index 2cdd92f..83e087a 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -269,7 +269,7 @@ int messages_get_message(void *session, const char *handle,
  *
  * session: Backend session.
  * user_data: User data if any to be sent.
- * Callback shall be called for every update inbox request recieved from MCE.
+ * Callback shall be called for every update inbox request received from MCE.
  */
 typedef void (*messages_update_inbox_cb)(void *session, int err,
 							void *user_data);
diff --git a/src/manager.c b/src/manager.c
index bd19288..1d48224 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -411,14 +411,14 @@ static void emit_transfer_completed(struct obex_session *os, gboolean success)
 }
 
 static void emit_transfer_progress(struct obex_session *os, uint32_t total,
-							uint32_t transfered)
+							uint32_t transferred)
 {
 	char *path = g_strdup_printf("/transfer%u", os->id);
 
 	g_dbus_emit_signal(connection, path,
 			TRANSFER_INTERFACE, "Progress",
 			DBUS_TYPE_INT32, &total,
-			DBUS_TYPE_INT32, &transfered,
+			DBUS_TYPE_INT32, &transferred,
 			DBUS_TYPE_INVALID);
 
 	g_free(path);
diff --git a/src/obex.c b/src/obex.c
index dfcbab0..9044961 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -656,7 +656,7 @@ static gboolean recv_data(const void *buf, gsize size, gpointer user_data)
 	if (os->aborted)
 		return FALSE;
 
-	/* workaround: client didn't send the object lenght */
+	/* workaround: client didn't send the object length */
 	if (os->size == OBJECT_SIZE_DELETE)
 		os->size = OBJECT_SIZE_UNKNOWN;
 
-- 
1.7.10.4


