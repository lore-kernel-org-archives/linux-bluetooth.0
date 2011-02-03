Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 3/3 v4] Use libtracker-sparql in PBAP
Date: Thu,  3 Feb 2011 11:43:23 +0200
Message-Id: <1296726203-22613-3-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1296726203-22613-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1296726203-22613-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now direct tracker connection for transporting retrieved
parts of data is used, instead of D-Bus. This should result better
performance for PBAP requests.
Each part of results is now fetched from tracker asynchronously
and getting more results can be stopped in any moment -
GCancellable stored in phonebook_data is used for that purpose.
If processing of data has finished (or it was cancelled) then cleanup
of pending_reply is done in last invocation of
async_query_cursor_next_cb.
---
 plugins/phonebook-tracker.c |  262 ++++++++++++++++++++++---------------------
 1 files changed, 135 insertions(+), 127 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 3b61d6b..214961d 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -29,6 +29,7 @@
 #include <dbus/dbus.h>
 #include <openobex/obex.h>
 #include <openobex/obex_const.h>
+#include <libtracker-sparql/tracker-sparql.h>
 
 #include "log.h"
 #include "obex.h"
@@ -891,7 +892,7 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call)) "	\
 	"LIMIT 40"
 
-typedef void (*reply_list_foreach_t) (char **reply, int num_fields,
+typedef void (*reply_list_foreach_t) (const char **reply, int num_fields,
 							void *user_data);
 
 typedef void (*add_field_t) (struct phonebook_contact *contact,
@@ -918,7 +919,7 @@ struct phonebook_data {
 	phonebook_cache_ready_cb ready_cb;
 	phonebook_entry_cb entry_cb;
 	int newmissedcalls;
-	DBusPendingCall *call;
+	GCancellable *query_canc;
 };
 
 struct phonebook_index {
@@ -926,7 +927,7 @@ struct phonebook_index {
 	int index;
 };
 
-static DBusConnection *connection = NULL;
+static TrackerSparqlConnection *connection = NULL;
 
 static const char *name2query(const char *name)
 {
@@ -999,131 +1000,124 @@ static const char *folder2query(const char *folder)
 	return NULL;
 }
 
-static char **string_array_from_iter(DBusMessageIter iter, int array_len)
+static const char **string_array_from_cursor(TrackerSparqlCursor *cursor,
+								int array_len)
 {
-	DBusMessageIter sub;
-	char **result;
+	const char **result;
 	int i;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
-		return NULL;
-
-	result = g_new0(char *, array_len);
+	result = g_new0(const char *, array_len);
 
-	dbus_message_iter_recurse(&iter, &sub);
+	for (i = 0; i < array_len; ++i) {
+		TrackerSparqlValueType type;
 
-	i = 0;
-	while (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_INVALID) {
-		char *arg;
-
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING) {
-			g_free(result);
-			return NULL;
-		}
+		type = tracker_sparql_cursor_get_value_type(cursor, i);
 
-		dbus_message_iter_get_basic(&sub, &arg);
-
-		result[i] = arg;
-
-		i++;
-		dbus_message_iter_next(&sub);
+		if (type == TRACKER_SPARQL_VALUE_TYPE_BLANK_NODE ||
+				type == TRACKER_SPARQL_VALUE_TYPE_UNBOUND)
+			/* For null/unbound type filling result part with ""*/
+			result[i] = "";
+		else
+			/* Filling with string representation of content*/
+			result[i] = tracker_sparql_cursor_get_string(cursor, i,
+									NULL);
 	}
 
 	return result;
 }
 
-static void query_reply(DBusPendingCall *call, void *user_data)
+static void update_cancellable(struct phonebook_data *pdata,
+							GCancellable *canc)
 {
-	DBusMessage *reply = dbus_pending_call_steal_reply(call);
-	struct pending_reply *pending = user_data;
-	DBusMessageIter iter, element;
-	DBusError derr;
-	int err;
-
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		error("Replied with an error: %s, %s", derr.name,
-							derr.message);
-		dbus_error_free(&derr);
-
-		err = -1;
-		goto done;
-	}
-
-	dbus_message_iter_init(reply, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		error("SparqlQuery reply is not an array");
+	if (pdata->query_canc)
+		g_object_unref(pdata->query_canc);
 
-		err = -1;
-		goto done;
-	}
-
-	dbus_message_iter_recurse(&iter, &element);
-
-	err = 0;
-
-	while (dbus_message_iter_get_arg_type(&element) != DBUS_TYPE_INVALID) {
-		char **node;
-
-		if (dbus_message_iter_get_arg_type(&element) !=
-						DBUS_TYPE_ARRAY) {
-			error("element is not an array");
-			goto done;
-		}
-
-		node = string_array_from_iter(element, pending->num_fields);
-		pending->callback(node, pending->num_fields,
-							pending->user_data);
+	pdata->query_canc = canc;
+}
 
-		g_free(node);
+static void async_query_cursor_next_cb(GObject *source, GAsyncResult *result,
+							gpointer user_data)
+{
+	struct pending_reply *pending = user_data;
+	TrackerSparqlCursor *cursor = TRACKER_SPARQL_CURSOR(source);
+	GCancellable *cancellable;
+	GError *error = NULL;
+	gboolean success;
+	const char **node;
+
+	success = tracker_sparql_cursor_next_finish(
+						TRACKER_SPARQL_CURSOR(source),
+						result, &error);
+
+	if (!success) {
+		if (error) {
+			DBG("cursor_next error: %s", error->message);
+			g_error_free(error);
+		} else
+			/* When tracker_sparql_cursor_next_finish ends with
+			 * failure and no error is set, that means end of
+			 * results returned by query */
+			pending->callback(NULL, 0, pending->user_data);
 
-		dbus_message_iter_next(&element);
+		goto failed;
 	}
 
-done:
-	/* This is the last entry */
-	pending->callback(NULL, err, pending->user_data);
+	node = string_array_from_cursor(cursor, pending->num_fields);
+	pending->callback(node, pending->num_fields, pending->user_data);
+	g_free(node);
 
-	dbus_message_unref(reply);
 
-	/* pending data is freed in query_free_data after call is unreffed. */
-}
-
-static void query_free_data(void *user_data)
-{
-	struct pending_reply *pending = user_data;
-
-	if (!pending)
-		return;
+	/* getting next row from query results */
+	cancellable = g_cancellable_new();
+	update_cancellable(pending->user_data, cancellable);
+	tracker_sparql_cursor_next_async(cursor, cancellable,
+						async_query_cursor_next_cb,
+						pending);
+	return;
 
+failed:
+	g_object_unref(cursor);
 	g_free(pending);
 }
 
-static DBusPendingCall *query_tracker(const char *query, int num_fields,
-		reply_list_foreach_t callback, void *user_data, int *err)
+static void query_tracker(const char *query, int num_fields,
+				reply_list_foreach_t callback, void *user_data,
+				int *err)
 {
 	struct pending_reply *pending;
-	DBusPendingCall *call;
-	DBusMessage *msg;
+	GCancellable *cancellable;
+	TrackerSparqlCursor *cursor;
+	GError *error = NULL;
+
+	DBG("");
 
 	if (connection == NULL)
-		connection = obex_dbus_get_connection();
+		connection = tracker_sparql_connection_get_direct(
+								NULL, &error);
 
-	msg = dbus_message_new_method_call(TRACKER_SERVICE,
-			TRACKER_RESOURCES_PATH, TRACKER_RESOURCES_INTERFACE,
-								"SparqlQuery");
+	if (!connection) {
+		if (error) {
+			DBG("direct-connection error: %s", error->message);
+			g_error_free(error);
+		}
 
-	dbus_message_append_args(msg, DBUS_TYPE_STRING, &query,
-						DBUS_TYPE_INVALID);
+		goto failed;
+	}
 
-	if (dbus_connection_send_with_reply(connection, msg, &call,
-							-1) == FALSE) {
-		error("Could not send dbus message");
-		dbus_message_unref(msg);
-		if (err)
-			*err = -EPERM;
-		return NULL;
+	cancellable = g_cancellable_new();
+	update_cancellable(user_data, cancellable);
+	cursor = tracker_sparql_connection_query(connection, query,
+							cancellable, &error);
+
+	if (cursor == NULL) {
+		if (error) {
+			DBG("connection_query error: %s", error->message);
+			g_error_free(error);
+		}
+
+		g_object_unref(cancellable);
+
+		goto failed;
 	}
 
 	pending = g_new0(struct pending_reply, 1);
@@ -1131,14 +1125,21 @@ static DBusPendingCall *query_tracker(const char *query, int num_fields,
 	pending->user_data = user_data;
 	pending->num_fields = num_fields;
 
-	dbus_pending_call_set_notify(call, query_reply, pending,
-							query_free_data);
-	dbus_message_unref(msg);
+	/* Now asynchronously going through each row of results - callback
+	 * async_query_cursor_next_cb will be called ALWAYS, even if async
+	 * request was canceled */
+	tracker_sparql_cursor_next_async(cursor, cancellable,
+						async_query_cursor_next_cb,
+						pending);
 
 	if (err)
 		*err = 0;
 
-	return call;
+	return;
+
+failed:
+	if (err)
+		*err = -EPERM;
 }
 
 static char *iso8601_utc_to_localtime(const char *datetime)
@@ -1331,7 +1332,8 @@ static GString *gen_vcards(GSList *contacts,
 	return vcards;
 }
 
-static void pull_contacts_size(char **reply, int num_fields, void *user_data)
+static void pull_contacts_size(const char **reply, int num_fields,
+							void *user_data)
 {
 	struct phonebook_data *data = user_data;
 
@@ -1363,7 +1365,8 @@ static void add_affiliation(char **field, const char *value)
 	*field = g_strdup(value);
 }
 
-static void contact_init(struct phonebook_contact *contact, char **reply)
+static void contact_init(struct phonebook_contact *contact,
+							const char **reply)
 {
 
 	contact->fullname = g_strdup(reply[COL_FULL_NAME]);
@@ -1395,8 +1398,8 @@ static enum phonebook_number_type get_phone_type(const char *affilation)
 	return TEL_TYPE_OTHER;
 }
 
-static void add_aff_number(struct phonebook_contact *contact, char *pnumber,
-								char *aff_type)
+static void add_aff_number(struct phonebook_contact *contact,
+				const char *pnumber, const char *aff_type)
 {
 	char **num_parts;
 	char *type, *number;
@@ -1433,7 +1436,7 @@ failed:
 }
 
 static void contact_add_numbers(struct phonebook_contact *contact,
-								char **reply)
+							const char **reply)
 {
 	char **aff_numbers;
 	int i;
@@ -1459,8 +1462,8 @@ static enum phonebook_field_type get_field_type(const char *affilation)
 	return FIELD_TYPE_OTHER;
 }
 
-static void add_aff_field(struct phonebook_contact *contact, char *aff_email,
-						add_field_t add_field_cb)
+static void add_aff_field(struct phonebook_contact *contact,
+			const char *aff_email, add_field_t add_field_cb)
 {
 	char **email_parts;
 	char *type, *email;
@@ -1490,7 +1493,7 @@ failed:
 }
 
 static void contact_add_emails(struct phonebook_contact *contact,
-								char **reply)
+							const char **reply)
 {
 	char **aff_emails;
 	int i;
@@ -1506,7 +1509,7 @@ static void contact_add_emails(struct phonebook_contact *contact,
 }
 
 static void contact_add_addresses(struct phonebook_contact *contact,
-								char **reply)
+							const char **reply)
 {
 	char **aff_addr;
 	int i;
@@ -1522,7 +1525,8 @@ static void contact_add_addresses(struct phonebook_contact *contact,
 	g_strfreev(aff_addr);
 }
 
-static void contact_add_urls(struct phonebook_contact *contact, char **reply)
+static void contact_add_urls(struct phonebook_contact *contact,
+							const char **reply)
 {
 	char **aff_url;
 	int i;
@@ -1538,7 +1542,7 @@ static void contact_add_urls(struct phonebook_contact *contact, char **reply)
 }
 
 static void contact_add_organization(struct phonebook_contact *contact,
-								char **reply)
+							const char **reply)
 {
 	/* Adding fields connected by nco:hasAffiliation - they may be in
 	 * separate replies */
@@ -1548,7 +1552,7 @@ static void contact_add_organization(struct phonebook_contact *contact,
 	add_affiliation(&contact->role, reply[COL_ORG_ROLE]);
 }
 
-static void pull_contacts(char **reply, int num_fields, void *user_data)
+static void pull_contacts(const char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
 	const struct apparam_field *params = data->params;
@@ -1649,7 +1653,7 @@ fail:
 	 */
 }
 
-static void add_to_cache(char **reply, int num_fields, void *user_data)
+static void add_to_cache(const char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
 	char *formatted;
@@ -1699,6 +1703,9 @@ done:
 
 int phonebook_init(void)
 {
+	g_thread_init(NULL);
+	g_type_init();
+
 	return 0;
 }
 
@@ -1792,12 +1799,13 @@ void phonebook_req_finalize(void *request)
 	if (!data)
 		return;
 
-	if (!dbus_pending_call_get_completed(data->call))
-		dbus_pending_call_cancel(data->call);
-
-	dbus_pending_call_unref(data->call);
+	/* canceling asynchronous operation on tracker if any is active */
+	if (data->query_canc) {
+		g_cancellable_cancel(data->query_canc);
+		g_object_unref(data->query_canc);
+	}
 
-	/* freeing list of contacts used for generating vcards */
+	/* freeing contacts */
 	for (l = data->contacts; l; l = l->next) {
 		struct contact_data *c_data = l->data;
 
@@ -1828,7 +1836,8 @@ static void gstring_free_helper(gpointer data, gpointer user_data)
 	g_string_free(data, TRUE);
 }
 
-static void pull_newmissedcalls(char **reply, int num_fields, void *user_data)
+static void pull_newmissedcalls(const char **reply, int num_fields,
+							void *user_data)
 {
 	struct phonebook_data *data = user_data;
 	reply_list_foreach_t pull_cb;
@@ -1870,8 +1879,7 @@ done:
 		pull_cb = pull_contacts;
 	}
 
-	dbus_pending_call_unref(data->call);
-	data->call = query_tracker(query, col_amount, pull_cb, data, &err);
+	query_tracker(query, col_amount, pull_cb, data, &err);
 	if (err < 0)
 		data->cb(NULL, 0, err, 0, data->user_data);
 }
@@ -1910,7 +1918,7 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	data->params = params;
 	data->user_data = user_data;
 	data->cb = cb;
-	data->call = query_tracker(query, col_amount, pull_cb, data, err);
+	query_tracker(query, col_amount, pull_cb, data, err);
 
 	return data;
 }
@@ -1938,8 +1946,8 @@ void *phonebook_get_entry(const char *folder, const char *id,
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
 
-	data->call = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts,
-								data, err);
+	query_tracker(query, PULL_QUERY_COL_AMOUNT,
+						pull_contacts, data, err);
 
 	g_free(query);
 
@@ -1965,7 +1973,7 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	data->entry_cb = entry_cb;
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
-	data->call = query_tracker(query, 7, add_to_cache, data, err);
+	query_tracker(query, 7, add_to_cache, data, err);
 
 	return data;
 }
-- 
1.7.0.4

