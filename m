Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 2/3] MAP: Folder listing support
Date: Fri, 12 Aug 2011 16:00:42 +0200
Message-Id: <1313157643-5387-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1313157643-5387-1-git-send-email-lkslawek@gmail.com>
References: <1313157643-5387-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a basic (lacking parsing or sending back application
parameters) handling of folder listing requests for Message Access
Profile.
---
 plugins/mas.c |  128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 59ae0c1..8af6eed 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -28,12 +28,14 @@
 #include <errno.h>
 #include <glib.h>
 #include <openobex/obex.h>
+#include <fcntl.h>
 
 #include "plugin.h"
 #include "log.h"
 #include "obex.h"
 #include "service.h"
 #include "mimetype.h"
+#include "filesystem.h"
 #include "dbus.h"
 
 #include "messages.h"
@@ -86,17 +88,43 @@
   </attribute>								\
 </record>"
 
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
+	gboolean finished;
+	gboolean nth_call;
+	GString *buffer;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
 			0xbb, 0x58, 0x2b, 0x40, 0x42, 0x0c, 0x11, 0xdb,
 			0xb0, 0xde, 0x08, 0x00, 0x20, 0x0c, 0x9a, 0x66  };
 
+
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
 
@@ -154,6 +182,8 @@ static int mas_get(struct obex_session *os, obex_object_t *obj, void *user_data)
 	return 0;
 
 failed:
+	reset_request(mas);
+
 	return ret;
 }
 
@@ -176,9 +206,64 @@ static int mas_put(struct obex_session *os, obex_object_t *obj, void *user_data)
 	return 0;
 
 failed:
+	reset_request(mas);
+
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
 static int mas_setpath(struct obex_session *os, obex_object_t *obj,
 		void *user_data)
 {
@@ -203,6 +288,30 @@ static int mas_setpath(struct obex_session *os, obex_object_t *obj,
 	return messages_set_folder(mas->backend_data, name, nonhdr[0] & 0x01);
 }
 
+static void *folder_listing_open(const char *name, int oflag, mode_t mode,
+				void *driver_data, size_t *size, int *err)
+{
+	struct mas_session *mas = driver_data;
+
+	if (oflag != O_RDONLY) {
+		*err = -EBADR;
+		return NULL;
+	}
+
+	DBG("name = %s", name);
+
+	/* 1024 is the default when there was no MaxListCount sent */
+	*err = messages_get_folder_listing(mas->backend_data, name, 1024, 0,
+			get_folder_listing_cb, mas);
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
@@ -222,15 +331,30 @@ static ssize_t any_write(void *object, const void *buf, size_t count)
 
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
 
@@ -272,7 +396,7 @@ static struct obex_mime_type_driver mime_folder_listing = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.mimetype = "x-obex/folder-listing",
-	.open = any_open,
+	.open = folder_listing_open,
 	.close = any_close,
 	.read = any_read,
 	.write = any_write,
-- 
1.7.4.1

