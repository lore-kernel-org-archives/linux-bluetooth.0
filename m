Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd] Support more fine-grained filtering of sdp records
Date: Fri, 12 Aug 2011 01:52:12 +0200
Message-Id: <1313106732-30484-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Obex-client provides currently a method to filter sdp
records by service class. The service class is determined
from the Target dictionary entry passed to the CreateSession
method.

For some profiles it is usefull to provide better control
over the filtering process in order to weed out services
that do not provide the necessary functionality we need.
This patch provides this by adding an sdp_filter callback
to session_data. This method can be set based on the Target
dictionary entry.

This functionality in not strictly necessary, since one
can always specify the exact channel to use in an argument
to CreateSession, bypassing SDP querying entirely.

Additionally, a Parameters entry is added to the dictionary
passed to CreateSession. This is later passed to the sdp_filter
callback. A use case for this is for eg. to connect
to a service that has a specific Service ID, where the ID
is passed in string form through the Parameters entry.

Should obex-client be broken up into plugins as per Luiz's
patches, the sdp_filter callback could become part
of the driver_data structure.
---
 client/manager.c |   32 +++++++++++++++++++-------------
 client/session.c |   16 ++++++++++++++++
 client/session.h |    1 +
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index e7eb70d..4dc66d8 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -131,7 +131,7 @@ done:
 
 static int parse_device_dict(DBusMessageIter *iter,
 		const char **source, const char **dest, const char **target,
-		uint8_t *channel)
+		const char **params, uint8_t *channel)
 {
 	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter entry, value;
@@ -151,6 +151,8 @@ static int parse_device_dict(DBusMessageIter *iter,
 				dbus_message_iter_get_basic(&value, dest);
 			else if (g_str_equal(key, "Target") == TRUE)
 				dbus_message_iter_get_basic(&value, target);
+			else if (g_str_equal(key, "Parameters") == TRUE)
+				dbus_message_iter_get_basic(&value, params);
 			break;
 		case DBUS_TYPE_BYTE:
 			if (g_str_equal(key, "Channel") == TRUE)
@@ -172,13 +174,13 @@ static DBusMessage *send_files(DBusConnection *connection,
 	GPtrArray *files;
 	struct send_data *data;
 	const char *agent, *source = NULL, *dest = NULL, *target = NULL;
-	const char *sender;
+	const char *sender, *params = NULL;
 	uint8_t channel = 0;
 
 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &array);
 
-	parse_device_dict(&array, &source, &dest, &target, &channel);
+	parse_device_dict(&array, &source, &dest, &target, &params, &channel);
 	if (dest == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -224,7 +226,7 @@ static DBusMessage *send_files(DBusConnection *connection,
 	data->agent = g_strdup(agent);
 	data->files = files;
 
-	session = session_create(source, dest, "OPP", channel, sender,
+	session = session_create(source, dest, "OPP", params, channel, sender,
 							create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -299,13 +301,13 @@ static DBusMessage *pull_business_card(DBusConnection *connection,
 	struct session_data *session;
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
-	const char *name = NULL;
+	const char *name = NULL, *params = NULL;
 	uint8_t channel = 0;
 
 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &dict);
 
-	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	parse_device_dict(&dict, &source, &dest, &target, &params, &channel);
 	if (dest == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -328,7 +330,7 @@ static DBusMessage *pull_business_card(DBusConnection *connection,
 	data->sender = g_strdup(dbus_message_get_sender(message));
 	data->filename = g_strdup(name);
 
-	session = session_create(source, dest, "OPP", channel, data->sender,
+	session = session_create(source, dest, "OPP", params, channel, data->sender,
 					pull_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -371,12 +373,13 @@ static DBusMessage *create_session(DBusConnection *connection,
 	struct session_data *session;
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
+	const char *params = NULL;
 	uint8_t channel = 0;
 
 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &dict);
 
-	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	parse_device_dict(&dict, &source, &dest, &target, &params, &channel);
 	if (dest == NULL || target == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -390,8 +393,8 @@ static DBusMessage *create_session(DBusConnection *connection,
 	data->message = dbus_message_ref(message);
 	data->sender = g_strdup(dbus_message_get_sender(message));
 
-	session = session_create(source, dest, target, channel, data->sender,
-							create_callback, data);
+	session = session_create(source, dest, target, params, channel,
+					data->sender, create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
 		return NULL;
@@ -499,12 +502,13 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 	struct session_data *session;
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
+	const char *params = NULL;
 	uint8_t channel = 0;
 
 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &dict);
 
-	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	parse_device_dict(&dict, &source, &dest, &target, &params, &channel);
 	if (dest == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -521,8 +525,10 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 	if (!target)
 		target = "OPP";
 
-	session = session_create(source, dest, target, channel, data->sender,
-					capability_session_callback, data);
+	session = session_create(source, dest, target, params,
+					channel, data->sender,
+					capability_session_callback,
+					data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
 		return NULL;
diff --git a/client/session.c b/client/session.c
index a89c760..59dd7eb 100644
--- a/client/session.c
+++ b/client/session.c
@@ -88,6 +88,10 @@ struct pending_req {
 	void *user_data;
 };
 
+typedef gboolean (*sdp_filter_func) (const void *user_data,
+						const sdp_record_t *record,
+						const char *params);
+
 struct session_data {
 	gint refcount;
 	bdaddr_t src;
@@ -111,6 +115,9 @@ struct session_data {
 	GSList *pending_calls;
 	void *priv;
 	char *adapter;
+	sdp_filter_func sdp_filter;
+	const void *sdp_filter_data;
+	char *params;
 };
 
 static GSList *sessions = NULL;
@@ -231,6 +238,7 @@ static void session_free(struct session_data *session)
 	g_free(session->path);
 	g_free(session->service);
 	g_free(session->owner);
+	g_free(session->params);
 	g_free(session);
 }
 
@@ -395,6 +403,11 @@ static void search_callback(uint8_t type, uint16_t status,
 			break;
 		}
 
+		if (session->sdp_filter)
+			if (!session->sdp_filter(session->sdp_filter_data,
+							rec, session->params))
+				goto pass;
+
 		if (!sdp_get_access_protos(rec, &protos)) {
 			ch = sdp_get_proto_port(protos, RFCOMM_UUID);
 			sdp_list_foreach(protos,
@@ -403,6 +416,7 @@ static void search_callback(uint8_t type, uint16_t status,
 			protos = NULL;
 		}
 
+pass:
 		sdp_record_free(rec);
 
 		if (ch > 0) {
@@ -722,6 +736,7 @@ proceed:
 struct session_data *session_create(const char *source,
 						const char *destination,
 						const char *service,
+						const char *params,
 						uint8_t channel,
 						const char *owner,
 						session_callback_t function,
@@ -766,6 +781,7 @@ struct session_data *session_create(const char *source,
 
 	str2ba(destination, &session->dst);
 	session->service = g_strdup(service);
+	session->params = g_strdup(params);
 
 	if (!g_ascii_strncasecmp(service, "OPP", 3)) {
 		sdp_uuid16_create(&session->uuid, OBEX_OBJPUSH_SVCLASS_ID);
diff --git a/client/session.h b/client/session.h
index 081a2c3..1454405 100644
--- a/client/session.h
+++ b/client/session.h
@@ -36,6 +36,7 @@ typedef void (*session_callback_t) (struct session_data *session,
 struct session_data *session_create(const char *source,
 						const char *destination,
 						const char *service,
+						const char *params,
 						uint8_t channel,
 						const char *owner,
 						session_callback_t function,
-- 
1.7.4.1

