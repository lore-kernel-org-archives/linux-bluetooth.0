Return-Path: <cyrus@holtmann.org>
From: Divya Yadav <divya.yadav@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Divya Yadav <divya.yadav@samsung.com>
Subject: [PATCH obexd 3/3] MAP: Add SetMessageStatus function
Date: Thu, 08 Mar 2012 14:14:19 +0530
Message-id: <1331196259-16010-3-git-send-email-divya.yadav@samsung.com>
In-reply-to: <1331196259-16010-1-git-send-email-divya.yadav@samsung.com>
References: <1331196259-16010-1-git-send-email-divya.yadav@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mas.c              |   44 +++++++++++++++++++++++++++++++++++++++++++-
 plugins/messages-dummy.c   |    8 ++++++++
 plugins/messages-tracker.c |    8 ++++++++
 plugins/messages.h         |   20 ++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index ade28c5..6e30abb 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -456,6 +456,20 @@ static void update_inbox_cb(void *session, int err, void *user_data)
 		obex_object_set_io_flags(mas, G_IO_OUT, 0);
 }
 
+static void message_status_cb(void *session, int err, void *user_data)
+{
+	struct mas_session *mas = user_data;
+
+	DBG("");
+
+	mas->finished = TRUE;
+
+	if (err < 0)
+		obex_object_set_io_flags(mas, G_IO_ERR, err);
+	else
+		obex_object_set_io_flags(mas, G_IO_OUT, 0);
+}
+
 static int mas_setpath(struct obex_session *os, void *user_data)
 {
 	const char *name;
@@ -573,6 +587,34 @@ static void *message_update_open(const char *name, int oflag, mode_t mode,
 		return mas;
 }
 
+static void *message_status_open(const char *name, int oflag, mode_t mode,
+					void *driver_data, size_t *size,
+					int *err)
+
+{
+	struct mas_session *mas = driver_data;
+	uint8_t indicator;
+	uint8_t value;
+
+	 if (!(oflag & O_WRONLY)) {
+		*err = -EBADR;
+		return NULL;
+	 }
+
+	map_ap_get_u8(mas->ap, MAP_AP_STATUSINDICATOR, &indicator);
+	map_ap_get_u8(mas->ap, MAP_AP_STATUSVALUE, &value);
+
+	DBG("Indicator = %d \n value = %d\n", indicator, value);
+
+	*err = messages_set_message_status(mas->backend_data, name, indicator,
+						value, message_status_cb, mas);
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
@@ -688,7 +730,7 @@ static struct obex_mime_type_driver mime_message_status = {
 	.target = MAS_TARGET,
 	.target_size = TARGET_SIZE,
 	.mimetype = "x-bt/messageStatus",
-	.open = any_open,
+	.open = message_status_open,
 	.close = any_close,
 	.read = any_read,
 	.write = any_write,
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 511857e..67e335d 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -173,6 +173,14 @@ int messages_update_inbox(void *session, messages_update_inbox_cb callback,
 	return -ENOSYS;
 }
 
+int messages_set_message_status(void *session, const char *handle,
+					int indicator, int value,
+					messages_set_message_status_cb callback,
+					void *user_data)
+{
+	return -ENOSYS;
+}
+
 void messages_abort(void *session)
 {
 }
diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index fb45210..f77b332 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -327,6 +327,14 @@ int messages_update_inbox(void *session, messages_update_inbox_cb callback,
 	return -ENOSYS;
 }
 
+int messages_set_message_status(void *session, const char *handle,
+					int indicator, int value,
+					messages_set_message_status_cb callback,
+					void *user_data)
+{
+	return -ENOSYS;
+}
+
 void messages_abort(void *session)
 {
 }
diff --git a/plugins/messages.h b/plugins/messages.h
index 00a040c..9cdc377 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -277,6 +277,26 @@ typedef void (*messages_update_inbox_cb)(void *session, int err,
 int messages_update_inbox(void *session, messages_update_inbox_cb callback,
 							void *user_data);
 
+/* Informs Message Server to modify status of the message.
+ *
+ * session: Backend session.
+ * handle: Unique identifier to the message.
+ * indicator: To indicate which status information is to be modified,
+ *	"readStatus" or "deleteStatus".
+ * value: To indicate the value of the indicator
+ *	read/unread for "readstatus" and deleted/undeleted for "deleteStatus".
+ * Callback shall be called for every message status update request
+ *	recieved from MCE.
+ * user_data: User data if any to be sent.
+ */
+typedef void (*messages_set_message_status_cb)(void *session, int err,
+		void *user_data);
+
+int messages_set_message_status(void *session, const char *handle,
+					int indicator, int value,
+					messages_set_message_status_cb callback,
+					void *user_data);
+
 /* Aborts currently pending request.
  *
  * session: Backend session.
-- 
1.7.0.4

