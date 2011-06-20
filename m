Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <yongli@qca.qualcomm.com>,
	Nami <nami.li@atheros.com>
Subject: [PATCH obexd 08/14] Add psm parameter for create_session.
Date: Mon, 20 Jun 2011 17:44:54 +0800
Message-ID: <1308563100-18917-8-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c    |   26 +++++++++++++++++---------
 client/session.c |    1 +
 client/session.h |    1 +
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/client/main.c b/client/main.c
index 478181c..5752831 100644
--- a/client/main.c
+++ b/client/main.c
@@ -125,7 +125,7 @@ done:

 static int parse_device_dict(DBusMessageIter *iter,
 		const char **source, const char **dest, const char **target,
-		uint8_t *channel)
+		uint8_t *channel, uint16_t *psm)
 {
 	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter entry, value;
@@ -150,6 +150,10 @@ static int parse_device_dict(DBusMessageIter *iter,
 			if (g_str_equal(key, "Channel") == TRUE)
 				dbus_message_iter_get_basic(&value, channel);
 			break;
+		case DBUS_TYPE_UINT16:
+			if (g_str_equal(key, "Psm") == TRUE)
+				dbus_message_iter_get_basic(&value, psm);
+			break;
 		}

 		dbus_message_iter_next(iter);
@@ -168,11 +172,12 @@ static DBusMessage *send_files(DBusConnection *connection,
 	const char *agent, *source = NULL, *dest = NULL, *target = NULL;
 	const char *sender;
 	uint8_t channel = 0;
+	uint16_t psm = 0;

 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &array);

-	parse_device_dict(&array, &source, &dest, &target, &channel);
+	parse_device_dict(&array, &source, &dest, &target, &channel, &psm);
 	if (dest == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -218,7 +223,7 @@ static DBusMessage *send_files(DBusConnection *connection,
 	data->agent = g_strdup(agent);
 	data->files = files;

-	session = session_create(source, dest, "OPP", channel, sender,
+	session = session_create(source, dest, "OPP", channel, psm, sender,
 							create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -295,11 +300,12 @@ static DBusMessage *pull_business_card(DBusConnection *connection,
 	const char *source = NULL, *dest = NULL, *target = NULL;
 	const char *name = NULL;
 	uint8_t channel = 0;
+	uint16_t psm = 0;

 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &dict);

-	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	parse_device_dict(&dict, &source, &dest, &target, &channel, &psm);
 	if (dest == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -322,7 +328,7 @@ static DBusMessage *pull_business_card(DBusConnection *connection,
 	data->sender = g_strdup(dbus_message_get_sender(message));
 	data->filename = g_strdup(name);

-	session = session_create(source, dest, "OPP", channel, data->sender,
+	session = session_create(source, dest, "OPP", channel, psm, data->sender,
 					pull_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -366,11 +372,12 @@ static DBusMessage *create_session(DBusConnection *connection,
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
 	uint8_t channel = 0;
+	uint16_t psm = 0;

 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &dict);

-	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	parse_device_dict(&dict, &source, &dest, &target, &channel, &psm);
 	if (dest == NULL || target == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -384,7 +391,7 @@ static DBusMessage *create_session(DBusConnection *connection,
 	data->message = dbus_message_ref(message);
 	data->sender = g_strdup(dbus_message_get_sender(message));

-	session = session_create(source, dest, target, channel, data->sender,
+	session = session_create(source, dest, target, channel, psm, data->sender,
 							create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -493,11 +500,12 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
 	uint8_t channel = 0;
+	uint16_t psm = 0;

 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &dict);

-	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	parse_device_dict(&dict, &source, &dest, &target, &channel, &psm);
 	if (dest == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -514,7 +522,7 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 	if (!target)
 		target = "OPP";

-	session = session_create(source, dest, target, channel, data->sender,
+	session = session_create(source, dest, target, channel, psm, data->sender,
 					capability_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
diff --git a/client/session.c b/client/session.c
index 266d00c..dd08610 100644
--- a/client/session.c
+++ b/client/session.c
@@ -535,6 +535,7 @@ struct session_data *session_create(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
+						uint16_t psm,
 						const char *owner,
 						session_callback_t function,
 						void *user_data)
diff --git a/client/session.h b/client/session.h
index 6f8a434..af79ac8 100644
--- a/client/session.h
+++ b/client/session.h
@@ -60,6 +60,7 @@ struct session_data *session_create(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
+						uint16_t psm,
 						const char *owner,
 						session_callback_t function,
 						void *user_data);
--
1.7.1

