Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 1/3] Add return value to reply_list_foreach_t in phonebook-tracker
Date: Mon,  7 Feb 2011 14:27:36 +0200
Message-Id: <1297081658-30573-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This changes are needed for notyfying that fetching data
from tracker should be stopped.
This will be usable in scenarios like:
*some error occurred during processing data
*maximum number of results already processed (due to pbap
 maxlistcount parameter)
*suspending processing data if pbap buffer is too large
---
 plugins/phonebook-tracker.c |   53 ++++++++++++++++++++++++++-----------------
 1 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index e116175..44cedfc 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -890,7 +890,7 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call)) "	\
 	"LIMIT 40"
 
-typedef void (*reply_list_foreach_t) (const char **reply, int num_fields,
+typedef int (*reply_list_foreach_t) (const char **reply, int num_fields,
 							void *user_data);
 
 typedef void (*add_field_t) (struct phonebook_contact *contact,
@@ -1042,6 +1042,7 @@ static void async_query_cursor_next_cb(GObject *source, GAsyncResult *result,
 	GError *error = NULL;
 	gboolean success;
 	const char **node;
+	int err;
 
 	success = tracker_sparql_cursor_next_finish(
 						TRACKER_SPARQL_CURSOR(source),
@@ -1061,17 +1062,22 @@ static void async_query_cursor_next_cb(GObject *source, GAsyncResult *result,
 	}
 
 	node = string_array_from_cursor(cursor, pending->num_fields);
-	pending->callback(node, pending->num_fields, pending->user_data);
+	err = pending->callback(node, pending->num_fields, pending->user_data);
 	g_free(node);
 
-
-	/* getting next row from query results */
-	cancellable = g_cancellable_new();
-	update_cancellable(pending->user_data, cancellable);
-	tracker_sparql_cursor_next_async(cursor, cancellable,
+	/* Fetch next result only if processing current chunk ended with
+	 * success. Sometimes during processing data, we are able to determine
+	 * if there is no need to get more data from tracker - by example
+	 * stored amount of data parts is big enough for sending and we might
+	 * want to suspend processing or just some error occurred. */
+	if (!err) {
+		cancellable = g_cancellable_new();
+		update_cancellable(pending->user_data, cancellable);
+		tracker_sparql_cursor_next_async(cursor, cancellable,
 						async_query_cursor_next_cb,
 						pending);
-	return;
+		return;
+	}
 
 failed:
 	g_object_unref(cursor);
@@ -1330,23 +1336,24 @@ static GString *gen_vcards(GSList *contacts,
 	return vcards;
 }
 
-static void pull_contacts_size(const char **reply, int num_fields,
+static int pull_contacts_size(const char **reply, int num_fields,
 							void *user_data)
 {
 	struct phonebook_data *data = user_data;
 
 	if (num_fields < 0) {
 		data->cb(NULL, 0, num_fields, 0, data->user_data);
-		return;
+		return -1;
 	}
 
 	if (reply != NULL) {
 		data->index = atoi(reply[0]);
-		return;
+		return 0;
 	}
 
 	data->cb(NULL, 0, data->index, data->newmissedcalls, data->user_data);
 
+	return -1;
 	/*
 	 * phonebook_data is freed in phonebook_req_finalize. Useful in
 	 * cases when call is terminated.
@@ -1550,7 +1557,7 @@ static void contact_add_organization(struct phonebook_contact *contact,
 	add_affiliation(&contact->role, reply[COL_ORG_ROLE]);
 }
 
-static void pull_contacts(const char **reply, int num_fields, void *user_data)
+static int pull_contacts(const char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
 	const struct apparam_field *params = data->params;
@@ -1593,7 +1600,7 @@ static void pull_contacts(const char **reply, int num_fields, void *user_data)
 
 	if (i == num_fields - 4 && !g_str_equal(reply[CONTACTS_ID_COL],
 						TRACKER_DEFAULT_CONTACT_ME))
-		return;
+		return 0;
 
 	if (g_strcmp0(temp_id, reply[CONTACTS_ID_COL])) {
 		data->index++;
@@ -1606,7 +1613,7 @@ static void pull_contacts(const char **reply, int num_fields, void *user_data)
 	if ((data->index <= params->liststartoffset ||
 						data->index > last_index) &&
 						params->maxlistcount > 0)
-		return;
+		return 0;
 
 add_entry:
 	contact = g_new0(struct phonebook_contact, 1);
@@ -1630,7 +1637,7 @@ add_numbers:
 		data->contacts = g_slist_append(data->contacts, contact_data);
 	}
 
-	return;
+	return 0;
 
 done:
 	vcards = gen_vcards(data->contacts, params);
@@ -1645,13 +1652,14 @@ fail:
 	g_free(temp_id);
 	temp_id = NULL;
 
+	return -1;
 	/*
 	 * phonebook_data is freed in phonebook_req_finalize. Useful in
 	 * cases when call is terminated.
 	 */
 }
 
-static void add_to_cache(const char **reply, int num_fields, void *user_data)
+static int add_to_cache(const char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
 	char *formatted;
@@ -1668,7 +1676,7 @@ static void add_to_cache(const char **reply, int num_fields, void *user_data)
 
 	if (i == num_fields &&
 			!g_str_equal(reply[0], TRACKER_DEFAULT_CONTACT_ME))
-		return;
+		return 0;
 
 	if (i == 6)
 		formatted = g_strdup(reply[6]);
@@ -1687,12 +1695,13 @@ static void add_to_cache(const char **reply, int num_fields, void *user_data)
 
 	g_free(formatted);
 
-	return;
+	return 0;
 
 done:
 	if (num_fields <= 0)
 		data->ready_cb(data->user_data);
 
+	return -1;
 	/*
 	 * phonebook_data is freed in phonebook_req_finalize. Useful in
 	 * cases when call is terminated.
@@ -1834,7 +1843,7 @@ static void gstring_free_helper(gpointer data, gpointer user_data)
 	g_string_free(data, TRUE);
 }
 
-static void pull_newmissedcalls(const char **reply, int num_fields,
+static int pull_newmissedcalls(const char **reply, int num_fields,
 							void *user_data)
 {
 	struct phonebook_data *data = user_data;
@@ -1854,7 +1863,7 @@ static void pull_newmissedcalls(const char **reply, int num_fields,
 								number);
 		}
 	}
-	return;
+	return 0;
 
 done:
 	DBG("newmissedcalls %d", data->newmissedcalls);
@@ -1864,7 +1873,7 @@ done:
 
 	if (num_fields < 0) {
 		data->cb(NULL, 0, num_fields, 0, data->user_data);
-		return;
+		return -1;
 	}
 
 	if (data->params->maxlistcount == 0) {
@@ -1880,6 +1889,8 @@ done:
 	query_tracker(query, col_amount, pull_cb, data, &err);
 	if (err < 0)
 		data->cb(NULL, 0, err, 0, data->user_data);
+
+	return -1;
 }
 
 void *phonebook_pull(const char *name, const struct apparam_field *params,
-- 
1.7.0.4

