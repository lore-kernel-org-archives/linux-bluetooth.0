Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH v3 1/2] Fix change to numbers GSlist in new missed calls
Date: Thu, 19 May 2011 15:57:43 +0300
Message-Id: <1305809864-9963-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1305809864-9963-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1305809864-9963-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is possible that phonebook_pull_read is invoked several times
submitting multiple pull requests without closing PBAP object. E.g., when
history is large enough and maxlistcount>VCARDS_PART_COUNT.

The result is possibility of different data structures (GString and
contact_data) to be mixed in a single GSlist that may lead to undefined
behaviour.
---
 plugins/phonebook-tracker.c |   57 ++++++++++++++++++++++++-------------------
 1 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index eec1e5d..95908ba 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -465,6 +465,7 @@ struct phonebook_data {
 	gboolean vcardentry;
 	const struct apparam_field *params;
 	GSList *contacts;
+	GSList *numbers;
 	phonebook_cache_ready_cb ready_cb;
 	phonebook_entry_cb entry_cb;
 	int newmissedcalls;
@@ -1422,26 +1423,6 @@ done:
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
@@ -1460,6 +1441,13 @@ static void gstring_free_helper(gpointer data, gpointer user_data)
 	g_string_free(data, TRUE);
 }
 
+static void free_data_numbers(struct phonebook_data *data)
+{
+	g_slist_foreach(data->numbers, gstring_free_helper, NULL);
+	g_slist_free(data->numbers);
+	data->numbers = NULL;
+}
+
 static int pull_newmissedcalls(const char **reply, int num_fields,
 							void *user_data)
 {
@@ -1471,12 +1459,12 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
 	if (num_fields < 0 || reply == NULL)
 		goto done;
 
-	if (!find_checked_number(data->contacts, reply[1])) {
+	if (!find_checked_number(data->numbers, reply[1])) {
 		if (g_strcmp0(reply[2], "false") == 0)
 			data->newmissedcalls++;
 		else {
 			GString *number = g_string_new(reply[1]);
-			data->contacts = g_slist_append(data->contacts,
+			data->numbers = g_slist_append(data->numbers,
 								number);
 		}
 	}
@@ -1484,9 +1472,7 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
 
 done:
 	DBG("newmissedcalls %d", data->newmissedcalls);
-	g_slist_foreach(data->contacts, gstring_free_helper, NULL);
-	g_slist_free(data->contacts);
-	data->contacts = NULL;
+	free_data_numbers(data);
 
 	if (num_fields < 0) {
 		data->cb(NULL, 0, num_fields, 0, TRUE, data->user_data);
@@ -1513,6 +1499,27 @@ done:
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
+	free_data_numbers(data);
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

