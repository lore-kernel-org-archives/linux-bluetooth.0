Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 1/7 v2] Add return value to query tracker
Date: Fri, 11 Feb 2011 16:05:33 +0200
Message-Id: <1297433139-10923-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously errors were returned via parameter err - it was needed
because some time ago query_tracker was returning newly allocated
structure. Now returning error through return value has more
sense.
---
 plugins/phonebook-tracker.c |   40 +++++++++++++++++++++-------------------
 1 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index e116175..623e294 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1078,9 +1078,8 @@ failed:
 	g_free(pending);
 }
 
-static void query_tracker(const char *query, int num_fields,
-				reply_list_foreach_t callback, void *user_data,
-				int *err)
+static int query_tracker(const char *query, int num_fields,
+				reply_list_foreach_t callback, void *user_data)
 {
 	struct pending_reply *pending;
 	GCancellable *cancellable;
@@ -1099,7 +1098,7 @@ static void query_tracker(const char *query, int num_fields,
 			g_error_free(error);
 		}
 
-		goto failed;
+		return -EINTR;
 	}
 
 	cancellable = g_cancellable_new();
@@ -1115,7 +1114,7 @@ static void query_tracker(const char *query, int num_fields,
 
 		g_object_unref(cancellable);
 
-		goto failed;
+		return -EINTR;
 	}
 
 	pending = g_new0(struct pending_reply, 1);
@@ -1130,14 +1129,7 @@ static void query_tracker(const char *query, int num_fields,
 						async_query_cursor_next_cb,
 						pending);
 
-	if (err)
-		*err = 0;
-
-	return;
-
-failed:
-	if (err)
-		*err = -EPERM;
+	return 0;
 }
 
 static char *iso8601_utc_to_localtime(const char *datetime)
@@ -1877,7 +1869,7 @@ done:
 		pull_cb = pull_contacts;
 	}
 
-	query_tracker(query, col_amount, pull_cb, data, &err);
+	err = query_tracker(query, col_amount, pull_cb, data);
 	if (err < 0)
 		data->cb(NULL, 0, err, 0, data->user_data);
 }
@@ -1888,7 +1880,7 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	struct phonebook_data *data;
 	const char *query;
 	reply_list_foreach_t pull_cb;
-	int col_amount;
+	int col_amount, ret;
 
 	DBG("name %s", name);
 
@@ -1916,7 +1908,10 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	data->params = params;
 	data->user_data = user_data;
 	data->cb = cb;
-	query_tracker(query, col_amount, pull_cb, data, err);
+	ret = query_tracker(query, col_amount, pull_cb, data);
+
+	if(err)
+		*err = ret;
 
 	return data;
 }
@@ -1927,6 +1922,7 @@ void *phonebook_get_entry(const char *folder, const char *id,
 {
 	struct phonebook_data *data;
 	char *query;
+	int ret;
 
 	DBG("folder %s id %s", folder, id);
 
@@ -1944,11 +1940,13 @@ void *phonebook_get_entry(const char *folder, const char *id,
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
 
-	query_tracker(query, PULL_QUERY_COL_AMOUNT,
-						pull_contacts, data, err);
+	ret = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data);
 
 	g_free(query);
 
+	if(err)
+		*err = ret;
+
 	return data;
 }
 
@@ -1957,6 +1955,7 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 {
 	struct phonebook_data *data;
 	const char *query;
+	int ret;
 
 	DBG("name %s", name);
 
@@ -1971,7 +1970,10 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	data->entry_cb = entry_cb;
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
-	query_tracker(query, 7, add_to_cache, data, err);
+	ret = query_tracker(query, 7, add_to_cache, data);
+
+	if(err)
+		*err = ret;
 
 	return data;
 }
-- 
1.7.0.4

