Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/9] obexd: Add file_data struct to session
Date: Tue, 28 May 2013 14:37:09 +0200
Message-Id: <1369744633-8980-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This adds a common file_data struct and related free and complete callbacks
to the session. This will be used for queuing the file related commands
mkdir, copy, move and delete.
---
 obexd/client/session.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 36ed541..6036d33 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -88,6 +88,13 @@ struct setpath_data {
 	void *user_data;
 };
 
+struct file_data {
+	char *srcname;
+	char *destname;
+	session_callback_t func;
+	void *user_data;
+};
+
 struct obc_session {
 	guint id;
 	int refcount;
@@ -190,6 +197,15 @@ static void setpath_data_free(void *process_data)
 	g_free(data);
 }
 
+static void file_data_free(void *process_data)
+{
+	struct file_data *data = process_data;
+
+	g_free(data->srcname);
+	g_free(data->destname);
+	g_free(data);
+}
+
 static void session_free(struct obc_session *session)
 {
 	DBG("%p", session);
@@ -1028,6 +1044,17 @@ done:
 	session_process_queue(session);
 }
 
+static void file_op_complete(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
+{
+	struct pending_request *p = user_data;
+	struct file_data *data = p->data;
+
+	if (data->func)
+		data->func(session, NULL, err, data->user_data);
+}
+
 guint obc_session_mkdir(struct obc_session *session, const char *folder,
 				session_callback_t func, void *user_data,
 				GError **err)
-- 
1.8.2.3

