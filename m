Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 3/5] MAP: Add basic messages listing retrieval support
Date: Fri,  2 Sep 2011 10:57:42 +0200
Message-Id: <1314953864-25686-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1314953864-25686-1-git-send-email-lkslawek@gmail.com>
References: <1314953864-25686-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mas.c            |  145 +++++++++++++++++++++++++++++++++++++++++++++-
 plugins/messages-dummy.c |    4 +-
 plugins/messages.h       |    9 ++-
 3 files changed, 151 insertions(+), 7 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 8c25d84..e67f661 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -98,6 +98,9 @@
 #define FL_FOLDER_ELEMENT "<folder name=\"%s\"/>"
 #define FL_BODY_END "</folder-listing>"
 
+#define ML_BODY_BEGIN "<MAP-msg-listing version=\"1.0\">"
+#define ML_BODY_END "</MAP-msg-listing>"
+
 struct mas_session {
 	struct mas_request *request;
 	void *backend_data;
@@ -224,6 +227,121 @@ static void g_string_append_escaped_printf(GString *string, const gchar *format,
 	va_end(ap);
 }
 
+static const char *yesorno(gboolean a)
+{
+	if (a)
+		return "yes";
+
+	return "no";
+}
+
+static void get_messages_listing_cb(void *session, int err,
+		uint16_t size, gboolean newmsg,
+		const struct messages_message *entry,
+		void *user_data)
+{
+	struct mas_session *mas = user_data;
+
+	if (err < 0 && err != -EAGAIN) {
+		obex_object_set_io_flags(mas, G_IO_ERR, err);
+		return;
+	}
+
+	if (!mas->nth_call) {
+		g_string_append(mas->buffer, ML_BODY_BEGIN);
+		mas->nth_call = TRUE;
+	}
+
+	if (!entry) {
+		g_string_append(mas->buffer, ML_BODY_END);
+		mas->finished = TRUE;
+
+		goto proceed;
+	}
+
+	g_string_append(mas->buffer, "<msg");
+
+	g_string_append_escaped_printf(mas->buffer, " handle=\"%s\"",
+								entry->handle);
+
+	if (entry->mask & PMASK_SUBJECT)
+		g_string_append_escaped_printf(mas->buffer, " subject=\"%s\"",
+				entry->subject);
+
+	if (entry->mask & PMASK_DATETIME)
+		g_string_append_escaped_printf(mas->buffer, " datetime=\"%s\"",
+				entry->datetime);
+
+	if (entry->mask & PMASK_SENDER_NAME)
+		g_string_append_escaped_printf(mas->buffer,
+						" sender_name=\"%s\"",
+						entry->sender_name);
+
+	if (entry->mask & PMASK_SENDER_ADDRESSING)
+		g_string_append_escaped_printf(mas->buffer,
+						" sender_addressing=\"%s\"",
+						entry->sender_addressing);
+
+	if (entry->mask & PMASK_REPLYTO_ADDRESSING)
+		g_string_append_escaped_printf(mas->buffer,
+						" replyto_addressing=\"%s\"",
+						entry->replyto_addressing);
+
+	if (entry->mask & PMASK_RECIPIENT_NAME)
+		g_string_append_escaped_printf(mas->buffer,
+						" recipient_name=\"%s\"",
+						entry->recipient_name);
+
+	if (entry->mask & PMASK_RECIPIENT_ADDRESSING)
+		g_string_append_escaped_printf(mas->buffer,
+						" recipient_addressing=\"%s\"",
+						entry->recipient_addressing);
+
+	if (entry->mask & PMASK_TYPE)
+		g_string_append_escaped_printf(mas->buffer, " type=\"%s\"",
+				entry->type);
+
+	if (entry->mask & PMASK_RECEPTION_STATUS)
+		g_string_append_escaped_printf(mas->buffer,
+						" reception_status=\"%s\"",
+						entry->reception_status);
+
+	if (entry->mask & PMASK_SIZE)
+		g_string_append_escaped_printf(mas->buffer, " size=\"%s\"",
+				entry->size);
+
+	if (entry->mask & PMASK_ATTACHMENT_SIZE)
+		g_string_append_escaped_printf(mas->buffer,
+						" attachment_size=\"%s\"",
+						entry->attachment_size);
+
+	if (entry->mask & PMASK_TEXT)
+		g_string_append_escaped_printf(mas->buffer, " text=\"%s\"",
+				yesorno(entry->text));
+
+	if (entry->mask & PMASK_READ)
+		g_string_append_escaped_printf(mas->buffer, " read=\"%s\"",
+				yesorno(entry->read));
+
+	if (entry->mask & PMASK_SENT)
+		g_string_append_escaped_printf(mas->buffer, " sent=\"%s\"",
+				yesorno(entry->sent));
+
+	if (entry->mask & PMASK_PROTECTED)
+		g_string_append_escaped_printf(mas->buffer, " protected=\"%s\"",
+				yesorno(entry->protect));
+
+	if (entry->mask & PMASK_PRIORITY)
+		g_string_append_escaped_printf(mas->buffer, " priority=\"%s\"",
+				yesorno(entry->priority));
+
+	g_string_append(mas->buffer, "/>\n");
+
+proceed:
+	if (err != -EAGAIN)
+		obex_object_set_io_flags(mas, G_IO_IN, 0);
+}
+
 static void get_folder_listing_cb(void *session, int err, uint16_t size,
 					const char *name, void *user_data)
 {
@@ -311,6 +429,31 @@ static void *folder_listing_open(const char *name, int oflag, mode_t mode,
 		return mas;
 }
 
+static void *msg_listing_open(const char *name, int oflag, mode_t mode,
+				void *driver_data, size_t *size, int *err)
+{
+	struct mas_session *mas = driver_data;
+	struct messages_filter filter = { 0, };
+
+	DBG("");
+
+	if (oflag != O_RDONLY) {
+		*err = -EBADR;
+		return NULL;
+	}
+
+	*err = messages_get_messages_listing(mas->backend_data, name, 0xffff, 0,
+			&filter,
+			get_messages_listing_cb, mas);
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
@@ -405,7 +548,7 @@ static struct obex_mime_type_driver mime_msg_listing = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/MAP-msg-listing",
-	.open = any_open,
+	.open = msg_listing_open,
 	.close = any_close,
 	.read = any_read,
 	.write = any_write,
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 408651e..b0b74d7 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -154,9 +154,7 @@ int messages_get_folder_listing(void *session,
 int messages_get_messages_listing(void *session,
 		const char *name,
 		uint16_t max, uint16_t offset, struct messages_filter *filter,
-		void (*callback)(void *session, int err, uint16_t size,
-			gboolean newmsg, const struct messages_message *message,
-			void *user_data),
+		messages_get_messages_listing_cb callback,
 		void *user_data)
 {
 	return -EINVAL;
diff --git a/plugins/messages.h b/plugins/messages.h
index 5b0fd2d..f931eb4 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -223,12 +223,15 @@ int messages_get_folder_listing(void *session,
  * Callback shall be called for every entry of the listing, giving message data
  * in 'message'.
  */
+typedef void (*messages_get_messages_listing_cb)(void *session, int err,
+		uint16_t size, gboolean newmsg,
+		const struct messages_message *message,
+		void *user_data);
+
 int messages_get_messages_listing(void *session,
 		const char *name,
 		uint16_t max, uint16_t offset, struct messages_filter *filter,
-		void (*callback)(void *session, int err, uint16_t size,
-			gboolean newmsg, const struct messages_message *message,
-			void *user_data),
+		messages_get_messages_listing_cb callback,
 		void *user_data);
 
 #define MESSAGES_ATTACHMENT	(1 << 0)
-- 
1.7.4.1

