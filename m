Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] obexd: Add property Folder to MAP message
Date: Fri, 30 Aug 2013 14:45:12 +0200
Message-Id: <1377866712-5253-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1377866712-5253-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1377866712-5253-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 8864a54..03be77f 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -123,6 +123,7 @@ struct map_msg {
 	char *status;
 	uint64_t attachment_size;
 	uint8_t flags;
+	char *folder;
 	GDBusPendingPropertySet pending;
 };
 
@@ -379,6 +380,7 @@ static void map_msg_free(void *data)
 	g_free(msg->path);
 	g_free(msg->subject);
 	g_free(msg->handle);
+	g_free(msg->folder);
 	g_free(msg->timestamp);
 	g_free(msg->sender);
 	g_free(msg->sender_address);
@@ -451,6 +453,16 @@ done:
 	msg->pending = 0;
 }
 
+static gboolean get_folder(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &msg->folder);
+
+	return TRUE;
+}
+
 static gboolean subject_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct map_msg *msg = data;
@@ -744,6 +756,7 @@ static const GDBusMethodTable map_msg_methods[] = {
 };
 
 static const GDBusPropertyTable map_msg_properties[] = {
+	{ "Folder", "s", get_folder },
 	{ "Subject", "s", get_subject, NULL, subject_exists },
 	{ "Timestamp", "s", get_timestamp, NULL, timestamp_exists },
 	{ "Sender", "s", get_sender, NULL, sender_exists },
@@ -766,7 +779,8 @@ static const GDBusPropertyTable map_msg_properties[] = {
 	{ }
 };
 
-static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
+static struct map_msg *map_msg_create(struct map_data *data, const char *handle,
+							const char *folder)
 {
 	struct map_msg *msg;
 
@@ -775,6 +789,7 @@ static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
 	msg->path = g_strdup_printf("%s/message%s",
 					obc_session_get_path(data->session),
 					handle);
+	msg->folder = g_strdup(folder);
 
 	if (!g_dbus_register_interface(conn, msg->path, MAP_MSG_INTERFACE,
 						map_msg_methods, NULL,
@@ -953,7 +968,8 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 
 	msg = g_hash_table_lookup(data->messages, values[i]);
 	if (msg == NULL) {
-		msg = map_msg_create(data, values[i]);
+		msg = map_msg_create(data, values[i],
+				obc_session_get_folder(data->session));
 		if (msg == NULL)
 			return;
 	}
-- 
1.8.3.4

