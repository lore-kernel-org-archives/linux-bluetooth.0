Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 4/5] MAP: Add basic support for message retrieval
Date: Fri,  2 Sep 2011 10:57:43 +0200
Message-Id: <1314953864-25686-4-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1314953864-25686-1-git-send-email-lkslawek@gmail.com>
References: <1314953864-25686-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mas.c            |   51 +++++++++++++++++++++++++++++++++++++++++++++-
 plugins/messages-dummy.c |    3 +-
 plugins/messages.h       |    6 +++-
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index e67f661..46ff2e7 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -342,6 +342,30 @@ proceed:
 		obex_object_set_io_flags(mas, G_IO_IN, 0);
 }
 
+static void get_message_cb(void *session, int err, gboolean fmore,
+	const char *chunk, void *user_data)
+{
+	struct mas_session *mas = user_data;
+
+	DBG("");
+
+	if (err < 0 && err != -EAGAIN) {
+		obex_object_set_io_flags(mas, G_IO_ERR, err);
+		return;
+	}
+
+	if (!chunk) {
+		mas->finished = TRUE;
+		goto proceed;
+	}
+
+	g_string_append(mas->buffer, chunk);
+
+proceed:
+	if (err != -EAGAIN)
+		obex_object_set_io_flags(mas, G_IO_IN, 0);
+}
+
 static void get_folder_listing_cb(void *session, int err, uint16_t size,
 					const char *name, void *user_data)
 {
@@ -454,6 +478,31 @@ static void *msg_listing_open(const char *name, int oflag, mode_t mode,
 		return mas;
 }
 
+static void *message_open(const char *name, int oflag, mode_t mode,
+				void *driver_data, size_t *size, int *err)
+{
+	struct mas_session *mas = driver_data;
+
+	DBG("");
+
+	if (oflag != O_RDONLY) {
+		DBG("Message pushing unsupported");
+		*err = -EINVAL;
+
+		return NULL;
+	}
+
+	*err = messages_get_message(mas->backend_data, name, 0,
+			get_message_cb, mas);
+
+	mas->buffer = g_string_new("");
+
+	if (*err < 0)
+		return NULL;
+	else
+		return mas;
+}
+
 static void *any_open(const char *name, int oflag, mode_t mode,
 				void *driver_data, size_t *size, int *err)
 {
@@ -528,7 +577,7 @@ static struct obex_mime_type_driver mime_message = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/message",
-	.open = any_open,
+	.open = message_open,
 	.close = any_close,
 	.read = any_read,
 	.write = any_write,
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index b0b74d7..9295864 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -163,8 +163,7 @@ int messages_get_messages_listing(void *session,
 int messages_get_message(void *session,
 		const char *handle,
 		unsigned long flags,
-		void (*callback)(void *session, int err, gboolean fmore,
-			const char *chunk, void *user_data),
+		messages_get_message_cb callback,
 		void *user_data)
 {
 	return -EINVAL;
diff --git a/plugins/messages.h b/plugins/messages.h
index f931eb4..9e0b091 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -258,11 +258,13 @@ int messages_get_messages_listing(void *session,
  *
  * Callback allows for returning bMessage in chunks.
  */
+typedef void (*messages_get_message_cb)(void *session, int err, gboolean fmore,
+	const char *chunk, void *user_data);
+
 int messages_get_message(void *session,
 		const char *handle,
 		unsigned long flags,
-		void (*callback)(void *session, int err, gboolean fmore,
-			const char *chunk, void *user_data),
+		messages_get_message_cb callback,
 		void *user_data);
 
 /* Aborts currently pending request.
-- 
1.7.4.1

