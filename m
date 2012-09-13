Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd v1 3/3] MAP: Add set delete status function
Date: Thu, 13 Sep 2012 19:14:24 +0530
Message-id: <1347543864-1278-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function will inform MAP server to modify
the delete status of a given message.
---
 plugins/mas.c              |   18 ++++++++++++++++++
 plugins/messages-dummy.c   |    7 +++++++
 plugins/messages-tracker.c |    7 +++++++
 plugins/messages.h         |   15 +++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/plugins/mas.c b/plugins/mas.c
index 14e7478..735c02d 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -47,6 +47,7 @@
 #include "messages.h"
 
 #define READ_STATUS_REQ 0
+#define DELETE_STATUS_REQ 1
 
 /* Channel number according to bluez doc/assigned-numbers.txt */
 #define MAS_CHANNEL	16
@@ -515,6 +516,20 @@ static void set_read_status_cb(void *session, int err, void *user_data)
 		obex_object_set_io_flags(mas, G_IO_OUT, 0);
 }
 
+static void set_delete_status_cb(void *session, int err, void *user_data)
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
@@ -696,6 +711,9 @@ static void *message_set_status_open(const char *name, int oflag, mode_t mode,
 	if (indicator == READ_STATUS_REQ)
 		*err = messages_set_read(mas->backend_data, name, value,
 						set_read_status_cb, mas);
+	else if (indicator == DELETE_STATUS_REQ)
+		*err = messages_set_delete(mas->backend_data, name, value,
+						set_delete_status_cb, mas);
 	else
 		*err = -EBADR;
 
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 78e20ae..e498784 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -359,6 +359,13 @@ int messages_set_read(void *session, const char *handle, uint8_t value,
 	return -ENOSYS;
 }
 
+int messages_set_delete(void *session, const char *handle, uint8_t value,
+					messages_set_delete_cb callback,
+					void *user_data)
+{
+	return -ENOSYS;
+}
+
 void messages_abort(void *s)
 {
 	struct session *session = s;
diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 1516dc7..2c7541b 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -333,6 +333,13 @@ int messages_set_read(void *session, const char *handle, uint8_t value,
 	return -ENOSYS;
 }
 
+int messages_set_delete(void *session, const char *handle, uint8_t value,
+					messages_set_delete_cb callback,
+					void *user_data)
+{
+	return -ENOSYS;
+}
+
 void messages_abort(void *session)
 {
 }
diff --git a/plugins/messages.h b/plugins/messages.h
index 45579d3..a514514 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -293,6 +293,21 @@ typedef void (*messages_set_read_cb)(void *session, int err, void *user_data);
 int messages_set_read(void *session, const char *handle, uint8_t value,
 				messages_set_read_cb callback, void *user_data);
 
+/* Informs Message Server to modify delete status of a given message.
+ *
+ * session: Backend session.
+ * handle: Unique identifier to the message.
+ * value: Indicates the new value of the delete status for a given message.
+ * Callback shall be called for every delete status update request
+ *	recieved from MCE.
+ * user_data: User data if any to be sent.
+ */
+typedef void (*messages_set_delete_cb)(void *session, int err, void *user_data);
+
+int messages_set_delete(void *session, const char *handle, uint8_t value,
+					messages_set_delete_cb callback,
+					void *user_data);
+
 /* Aborts currently pending request.
  *
  * session: Backend session.
-- 
1.7.9.5

