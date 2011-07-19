Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/3] Infrastructure for MAP function selection
Date: Tue, 19 Jul 2011 13:16:10 +0200
Message-Id: <1311074172-15953-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1311074172-15953-1-git-send-email-lkslawek@gmail.com>
References: <1311074172-15953-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mas.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 64 insertions(+), 14 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 0ef8c81..e88a0f0 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -27,6 +27,9 @@
 
 #include <errno.h>
 #include <glib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include <openobex/obex.h>
 
 #include "plugin.h"
@@ -86,9 +89,19 @@
   </attribute>								\
 </record>"
 
+#define EVENT_TYPE		"x-bt/MAP-event-report"
+#define MESSAGE_TYPE		"x-bt/message"
+#define FOLDER_LISTING_TYPE	"x-obex/folder-listing"
+#define MESSAGES_LISTING_TYPE	"x-bt/MAP-msg-listing"
+#define NOTIFICATION_TYPE	"x-bt/MAP-NotificationRegistration"
+#define STATUS_TYPE		"x-bt/messageStatus"
+#define UPDATE_TYPE		"x-bt/MAP-messageUpdate"
+
 struct mas_session {
 	struct mas_request *request;
 	void *backend_data;
+	const char *name;
+	const char *type;
 };
 
 static const uint8_t MAS_TARGET[TARGET_SIZE] = {
@@ -137,17 +150,14 @@ static void mas_disconnect(struct obex_session *os, void *user_data)
 static int mas_get(struct obex_session *os, obex_object_t *obj, void *user_data)
 {
 	struct mas_session *mas = user_data;
-	const char *type = obex_get_type(os);
-	const char *name = obex_get_name(os);
 	int ret;
 
-	DBG("GET: name %s type %s mas %p",
-			name, type, mas);
+	mas->name = obex_get_name(os);
+	mas->type = obex_get_type(os);
 
-	if (type == NULL)
-		return -EBADR;
+	DBG("GET: name %s type %s mas %p", mas->name, mas->type, mas);
 
-	ret = obex_get_stream_start(os, name);
+	ret = obex_get_stream_start(os, mas->name);
 	if (ret < 0)
 		goto failed;
 
@@ -160,16 +170,14 @@ failed:
 static int mas_put(struct obex_session *os, obex_object_t *obj, void *user_data)
 {
 	struct mas_session *mas = user_data;
-	const char *type = obex_get_type(os);
-	const char *name = obex_get_name(os);
 	int ret;
 
-	DBG("PUT: name %s type %s mas %p", name, type, mas);
+	mas->name = obex_get_name(os);
+	mas->type = obex_get_type(os);
 
-	if (type == NULL)
-		return -EBADR;
+	DBG("PUT: name %s type %s mas %p", mas->name, mas->type, mas);
 
-	ret = obex_put_stream_start(os, name);
+	ret = obex_put_stream_start(os, mas->name);
 	if (ret < 0)
 		goto failed;
 
@@ -179,6 +187,38 @@ failed:
 	return ret;
 }
 
+static int start_get(struct mas_session *mas)
+{
+	/* NOTE: type is case-insensitive! */
+	if (g_ascii_strcasecmp(mas->type, FOLDER_LISTING_TYPE) == 0)
+		return -EINVAL;
+	else if (g_ascii_strcasecmp(mas->type, MESSAGES_LISTING_TYPE) == 0)
+		return -EINVAL;
+	else if (g_ascii_strcasecmp(mas->type, MESSAGE_TYPE) == 0)
+		return -EINVAL;
+	else {
+		DBG("Incorrect type for get: %s", mas->type);
+		return -EBADR;
+	}
+}
+
+static int start_put(struct mas_session *mas)
+{
+	/* NOTE: type is case-insensitive! */
+	if (g_ascii_strcasecmp(mas->type, NOTIFICATION_TYPE) == 0)
+		return -EINVAL;
+	else if (g_ascii_strcasecmp(mas->type, STATUS_TYPE) == 0)
+		return -EINVAL;
+	else if (g_ascii_strcasecmp(mas->type, MESSAGE_TYPE) == 0)
+		return -EINVAL;
+	else if (g_ascii_strcasecmp(mas->type, UPDATE_TYPE) == 0)
+		return -EINVAL;
+	else {
+		DBG("Incorrect type for put: %s", mas->type);
+		return -EBADR;
+	}
+}
+
 static int mas_setpath(struct obex_session *os, obex_object_t *obj,
 		void *user_data)
 {
@@ -210,7 +250,17 @@ static void *any_open(const char *name, int oflag, mode_t mode,
 
 	DBG("");
 
-	*err = 0;
+	if ((oflag & O_RDONLY) == O_RDONLY) {
+		*err = start_get(mas);
+	} else if ((oflag & O_WRONLY) == O_WRONLY) {
+		*err = start_put(mas);
+	} else {
+		DBG("Invalid open flag!");
+		*err = -EIO;
+	}
+
+	if (*err)
+		return NULL;
 
 	return mas;
 }
-- 
1.7.4.1

