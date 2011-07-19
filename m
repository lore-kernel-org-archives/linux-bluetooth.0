Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v2 2/3] MAP: Folder listing support
Date: Tue, 19 Jul 2011 14:06:16 +0200
Message-Id: <1311077177-18979-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1311077177-18979-1-git-send-email-lkslawek@gmail.com>
References: <1311077177-18979-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a basic (without parsing or sending back application
parameters) handling of folder listing requests for Message Access
Profile.
---
 plugins/mas.c      |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 plugins/messages.h |    6 ++-
 2 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index e88a0f0..4e1e07f 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -37,6 +37,7 @@
 #include "obex.h"
 #include "service.h"
 #include "mimetype.h"
+#include "filesystem.h"
 #include "dbus.h"
 
 #include "messages.h"
@@ -97,19 +98,44 @@
 #define STATUS_TYPE		"x-bt/messageStatus"
 #define UPDATE_TYPE		"x-bt/MAP-messageUpdate"
 
+#define XML_DECL "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
+
+/* Building blocks for x-obex/folder-listing */
+#define FL_DTD "<!DOCTYPE folder-listing SYSTEM \"obex-folder-listing.dtd\">"
+#define FL_BODY_BEGIN "<folder-listing version=\"1.0\">"
+#define FL_BODY_EMPTY "<folder-listing version=\"1.0\"/>"
+#define FL_PARENT_FOLDER_ELEMENT "<parent-folder/>"
+#define FL_FOLDER_ELEMENT "<folder name=\"%s\"/>"
+#define FL_BODY_END "</folder-listing>"
+
 struct mas_session {
 	struct mas_request *request;
 	void *backend_data;
 	const char *name;
 	const char *type;
+	gboolean nth_call;
+	gboolean finished;
+	GString *buffer;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
 			0xbb, 0x58, 0x2b, 0x40, 0x42, 0x0c, 0x11, 0xdb,
 			0xb0, 0xde, 0x08, 0x00, 0x20, 0x0c, 0x9a, 0x66  };
 
+static void reset_request(struct mas_session *mas)
+{
+	if (mas->buffer) {
+		g_string_free(mas->buffer, TRUE);
+		mas->buffer = NULL;
+	}
+
+	mas->nth_call = FALSE;
+	mas->finished = FALSE;
+}
+
 static void mas_clean(struct mas_session *mas)
 {
+	reset_request(mas);
 	g_free(mas);
 }
 
@@ -187,11 +213,65 @@ failed:
 	return ret;
 }
 
+/* FIXME: Preserve whitespaces */
+static void g_string_append_escaped_printf(GString *string, const gchar *format,
+		...)
+{
+	va_list ap;
+	char *escaped;
+
+	va_start(ap, format);
+	escaped = g_markup_vprintf_escaped(format, ap);
+	g_string_append(string, escaped);
+	g_free(escaped);
+	va_end(ap);
+}
+
+static void get_folder_listing_cb(void *session, int err, uint16_t size,
+					const char *name, void *user_data)
+{
+	struct mas_session *mas = user_data;
+
+	if (err < 0 && err != -EAGAIN) {
+		obex_object_set_io_flags(mas, G_IO_ERR, err);
+		return;
+	}
+
+	if (!mas->nth_call) {
+		g_string_append(mas->buffer, XML_DECL);
+		g_string_append(mas->buffer, FL_DTD);
+		if (!name) {
+			g_string_append(mas->buffer, FL_BODY_EMPTY);
+			mas->finished = TRUE;
+			goto proceed;
+		}
+		g_string_append(mas->buffer, FL_BODY_BEGIN);
+		mas->nth_call = TRUE;
+	}
+
+	if (!name) {
+		g_string_append(mas->buffer, FL_BODY_END);
+		mas->finished = TRUE;
+		goto proceed;
+	}
+
+	if (g_strcmp0(name, "..") == 0)
+		g_string_append(mas->buffer, FL_PARENT_FOLDER_ELEMENT);
+	else
+		g_string_append_escaped_printf(mas->buffer, FL_FOLDER_ELEMENT,
+									name);
+
+proceed:
+	if (err != -EAGAIN)
+		obex_object_set_io_flags(mas, G_IO_IN, err);
+}
+
 static int start_get(struct mas_session *mas)
 {
 	/* NOTE: type is case-insensitive! */
 	if (g_ascii_strcasecmp(mas->type, FOLDER_LISTING_TYPE) == 0)
-		return -EINVAL;
+		return messages_get_folder_listing(mas->backend_data, mas->name,
+					0xffff, 0, get_folder_listing_cb, mas);
 	else if (g_ascii_strcasecmp(mas->type, MESSAGES_LISTING_TYPE) == 0)
 		return -EINVAL;
 	else if (g_ascii_strcasecmp(mas->type, MESSAGE_TYPE) == 0)
@@ -262,6 +342,10 @@ static void *any_open(const char *name, int oflag, mode_t mode,
 	if (*err)
 		return NULL;
 
+	mas->finished = FALSE;
+	mas->nth_call = FALSE;
+	mas->buffer = g_string_new("");
+
 	return mas;
 }
 
@@ -274,15 +358,30 @@ static ssize_t any_write(void *object, const void *buf, size_t count)
 
 static ssize_t any_read(void *obj, void *buf, size_t count)
 {
+	struct mas_session *mas = obj;
+	ssize_t len;
+
 	DBG("");
 
-	return 0;
+	len = string_read(mas->buffer, buf, count);
+
+	if (len == 0 && !mas->finished)
+		return -EAGAIN;
+
+	return len;
 }
 
 static int any_close(void *obj)
 {
+	struct mas_session *mas = obj;
+
 	DBG("");
 
+	if (!mas->finished)
+		messages_abort(mas->backend_data);
+
+	reset_request(mas);
+
 	return 0;
 }
 
diff --git a/plugins/messages.h b/plugins/messages.h
index c862b07..d9348c7 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -202,11 +202,13 @@ int messages_set_folder(void *session, const char *name, gboolean cdup);
  * Callback shall be called for every entry of the listing. 'name' is the
  * subdirectory name.
  */
+typedef void (*messages_folder_listing_cb)(void *session, int err,
+		uint16_t size, const char *name, void *user_data);
+
 int messages_get_folder_listing(void *session,
 		const char *name,
 		uint16_t max, uint16_t offset,
-		void (*callback)(void *session, int err, uint16_t size,
-			const char *name, void *user_data),
+		messages_folder_listing_cb callback,
 		void *user_data);
 
 /* Retrieves messages listing from a current directory.
-- 
1.7.4.1

