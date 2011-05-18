Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/3] Move phonebook_req_finalize
Date: Wed, 18 May 2011 18:58:06 +0300
Message-Id: <1305734288-4317-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is used in successive patch.
---
 plugins/phonebook-tracker.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 9431d8a..9c60ec3 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1905,26 +1905,6 @@ done:
 	return path;
 }
 
-void phonebook_req_finalize(void *request)
-{
-	struct phonebook_data *data = request;
-
-	DBG("");
-
-	if (!data)
-		return;
-
-	/* canceling asynchronous operation on tracker if any is active */
-	if (data->query_canc) {
-		g_cancellable_cancel(data->query_canc);
-		g_object_unref(data->query_canc);
-	}
-
-	free_data_contacts(data);
-	g_free(data->req_name);
-	g_free(data);
-}
-
 static gboolean find_checked_number(GSList *numbers, const char *number)
 {
 	GSList *l;
@@ -1996,6 +1976,26 @@ done:
 	return 0;
 }
 
+void phonebook_req_finalize(void *request)
+{
+	struct phonebook_data *data = request;
+
+	DBG("");
+
+	if (!data)
+		return;
+
+	/* canceling asynchronous operation on tracker if any is active */
+	if (data->query_canc) {
+		g_cancellable_cancel(data->query_canc);
+		g_object_unref(data->query_canc);
+	}
+
+	free_data_contacts(data);
+	g_free(data->req_name);
+	g_free(data);
+}
+
 void *phonebook_pull(const char *name, const struct apparam_field *params,
 				phonebook_cb cb, void *user_data, int *err)
 {
-- 
1.7.4.1

