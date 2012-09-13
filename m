Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd 3/3] MAP: Add set delete status function
Date: Thu, 13 Sep 2012 11:37:12 +0530
Message-id: <1347516432-28414-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function will inform MAP server to modify
the delete status of a given message.
---
 plugins/mas.c              |   18 ++++++++++++++++++
 plugins/messages-dummy.c   |    8 ++++++++
 plugins/messages-tracker.c |    8 ++++++++
 plugins/messages.h         |   17 +++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/plugins/mas.c b/plugins/mas.c
index 182dc6b..b0b1e22 100644
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
 		*err = messages_set_read_status(mas->backend_data, name,
 					value, set_read_status_cb, mas);
+	else if (indicator == DELETE_STATUS_REQ)
+		*err = messages_set_delete_status(mas->backend_data, name,
+					value, set_delete_status_cb, mas);
 	else
 		*err = -EBADR;
 
diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 627f87a..c2f7f6c 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -361,6 +361,14 @@ int messages_set_read_status(void *session, const char *handle,
 	return -ENOSYS;
 }
 
+int messages_set_delete_status(void *session, const char *handle,
+					uint8_t value,
+					messages_set_delete_status_cb callback,
+					void *user_data)
+{
+	return -ENOSYS;
+}
+
 void messages_abort(void *s)
 {
 	struct session *session = s;
diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 13c113e..99ecae3 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -335,6 +335,14 @@ int messages_set_read_status(void *session, const char *handle,
 	return -ENOSYS;
 }
 
+int messages_set_delete_status(void *session, const char *handle,
+					uint8_t value,
+					messages_set_delete_status_cb callback,
+					void *user_data)
+{
+	return -ENOSYS;
+}
+
 void messages_abort(void *session)
 {
 }
diff --git a/plugins/messages.h b/plugins/messages.h
index 02d4f37..8890ace 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -297,6 +297,23 @@ int messages_set_read_status(void *session, const char *handle,
 					messages_set_read_status_cb callback,
 					void *user_data);
 
+/* Informs Message Server to modify delete status of a given message.
+ *
+ * session: Backend session.
+ * handle: Unique identifier to the message.
+ * value: Indicates the new value of the delete status for a given message.
+ * Callback shall be called for every delete status update request
+ *	recieved from MCE.
+ * user_data: User data if any to be sent.
+ */
+typedef void (*messages_set_delete_status_cb)(void *session, int err,
+		void *user_data);
+
+int messages_set_delete_status(void *session, const char *handle,
+					uint8_t value,
+					messages_set_delete_status_cb callback,
+					void *user_data);
+
 /* Aborts currently pending request.
  *
  * session: Backend session.
-- 
1.7.9.5

