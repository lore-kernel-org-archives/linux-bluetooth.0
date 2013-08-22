Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] obexd: Use g_dbus_get_properties when parsing MAP-msg-listing
Date: Thu, 22 Aug 2013 18:08:40 +0200
Message-Id: <1377187721-3758-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Currently the message D-Bus properties for the ListMessages response are put
together manually in the parse_* functions unsing obex_dbus_dict_append.
This patch simplifies it by calling g_dbus_get_properties for every message.
---
 obexd/client/map.c | 84 ++++++++++++++----------------------------------------
 1 file changed, 21 insertions(+), 63 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 3d8acc4..8864a54 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -790,81 +790,60 @@ static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
 	return msg;
 }
 
-static void parse_subject(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_subject(struct map_msg *msg, const char *value)
 {
 	g_free(msg->subject);
 	msg->subject = g_strdup(value);
-	obex_dbus_dict_append(iter, "Subject", DBUS_TYPE_STRING, &value);
 }
 
-static void parse_datetime(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_datetime(struct map_msg *msg, const char *value)
 {
 	g_free(msg->timestamp);
 	msg->timestamp = g_strdup(value);
-	obex_dbus_dict_append(iter, "Timestamp", DBUS_TYPE_STRING, &value);
 }
 
-static void parse_sender(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_sender(struct map_msg *msg, const char *value)
 {
 	g_free(msg->sender);
 	msg->sender = g_strdup(value);
-	obex_dbus_dict_append(iter, "Sender", DBUS_TYPE_STRING, &value);
 }
 
-static void parse_sender_address(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_sender_address(struct map_msg *msg, const char *value)
 {
 	g_free(msg->sender_address);
 	msg->sender_address = g_strdup(value);
-	obex_dbus_dict_append(iter, "SenderAddress", DBUS_TYPE_STRING,
-								&value);
 }
 
-static void parse_replyto(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_replyto(struct map_msg *msg, const char *value)
 {
 	g_free(msg->replyto);
 	msg->replyto = g_strdup(value);
-	obex_dbus_dict_append(iter, "ReplyTo", DBUS_TYPE_STRING, &value);
 }
 
-static void parse_recipient(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_recipient(struct map_msg *msg, const char *value)
 {
 	g_free(msg->recipient);
 	msg->recipient = g_strdup(value);
-	obex_dbus_dict_append(iter, "Recipient", DBUS_TYPE_STRING, &value);
 }
 
-static void parse_recipient_address(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_recipient_address(struct map_msg *msg, const char *value)
 {
 	g_free(msg->recipient_address);
 	msg->recipient_address = g_strdup(value);
-	obex_dbus_dict_append(iter, "RecipientAddress", DBUS_TYPE_STRING,
-								&value);
 }
 
-static void parse_type(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_type(struct map_msg *msg, const char *value)
 {
 	g_free(msg->type);
 	msg->type = g_strdup(value);
-	obex_dbus_dict_append(iter, "Type", DBUS_TYPE_STRING, &value);
 }
 
-static void parse_size(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_size(struct map_msg *msg, const char *value)
 {
 	msg->size = g_ascii_strtoll(value, NULL, 10);
-	obex_dbus_dict_append(iter, "Size", DBUS_TYPE_UINT64, &msg->size);
 }
 
-static void parse_text(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_text(struct map_msg *msg, const char *value)
 {
 	gboolean flag = strcasecmp(value, "no") != 0;
 
@@ -873,27 +852,20 @@ static void parse_text(struct map_msg *msg, const char *value,
 	else
 		msg->flags &= ~MAP_MSG_FLAG_TEXT;
 
-	obex_dbus_dict_append(iter, "Text", DBUS_TYPE_BOOLEAN, &flag);
 }
 
-static void parse_status(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_status(struct map_msg *msg, const char *value)
 {
 	g_free(msg->status);
 	msg->status = g_strdup(value);
-	obex_dbus_dict_append(iter, "Status", DBUS_TYPE_STRING, &value);
 }
 
-static void parse_attachment_size(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_attachment_size(struct map_msg *msg, const char *value)
 {
 	msg->attachment_size = g_ascii_strtoll(value, NULL, 10);
-	obex_dbus_dict_append(iter, "AttachmentSize", DBUS_TYPE_UINT64,
-							&msg->attachment_size);
 }
 
-static void parse_priority(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_priority(struct map_msg *msg, const char *value)
 {
 	gboolean flag = strcasecmp(value, "no") != 0;
 
@@ -902,11 +874,9 @@ static void parse_priority(struct map_msg *msg, const char *value,
 	else
 		msg->flags &= ~MAP_MSG_FLAG_PRIORITY;
 
-	obex_dbus_dict_append(iter, "Priority", DBUS_TYPE_BOOLEAN, &flag);
 }
 
-static void parse_read(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_read(struct map_msg *msg, const char *value)
 {
 	gboolean flag = strcasecmp(value, "no") != 0;
 
@@ -915,11 +885,9 @@ static void parse_read(struct map_msg *msg, const char *value,
 	else
 		msg->flags &= ~MAP_MSG_FLAG_READ;
 
-	obex_dbus_dict_append(iter, "Read", DBUS_TYPE_BOOLEAN, &flag);
 }
 
-static void parse_sent(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_sent(struct map_msg *msg, const char *value)
 {
 	gboolean flag = strcasecmp(value, "no") != 0;
 
@@ -928,11 +896,9 @@ static void parse_sent(struct map_msg *msg, const char *value,
 	else
 		msg->flags &= ~MAP_MSG_FLAG_SENT;
 
-	obex_dbus_dict_append(iter, "Sent", DBUS_TYPE_BOOLEAN, &flag);
 }
 
-static void parse_protected(struct map_msg *msg, const char *value,
-							DBusMessageIter *iter)
+static void parse_protected(struct map_msg *msg, const char *value)
 {
 	gboolean flag = strcasecmp(value, "no") != 0;
 
@@ -941,13 +907,11 @@ static void parse_protected(struct map_msg *msg, const char *value,
 	else
 		msg->flags &= ~MAP_MSG_FLAG_PROTECTED;
 
-	obex_dbus_dict_append(iter, "Protected", DBUS_TYPE_BOOLEAN, &flag);
 }
 
 static struct map_msg_parser {
 	const char *name;
-	void (*func) (struct map_msg *msg, const char *value,
-							DBusMessageIter *iter);
+	void (*func) (struct map_msg *msg, const char *value);
 } msg_parsers[] = {
 		{ "subject", parse_subject },
 		{ "datetime", parse_datetime },
@@ -974,7 +938,7 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 {
 	struct map_parser *parser = user_data;
 	struct map_data *data = parser->data;
-	DBusMessageIter entry, dict, *iter = parser->iter;
+	DBusMessageIter entry, *iter = parser->iter;
 	struct map_msg *msg;
 	const char *key;
 	int i;
@@ -1000,25 +964,19 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
 								&msg->path);
 
-	dbus_message_iter_open_container(&entry, DBUS_TYPE_ARRAY,
-					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-					DBUS_TYPE_STRING_AS_STRING
-					DBUS_TYPE_VARIANT_AS_STRING
-					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
-					&dict);
-
 	for (i = 0, key = names[i]; key; key = names[++i]) {
 		struct map_msg_parser *parser;
 
 		for (parser = msg_parsers; parser && parser->name; parser++) {
 			if (strcasecmp(key, parser->name) == 0) {
-				parser->func(msg, values[i], &dict);
+				parser->func(msg, values[i]);
 				break;
 			}
 		}
 	}
 
-	dbus_message_iter_close_container(&entry, &dict);
+	g_dbus_get_properties(conn, msg->path, MAP_MSG_INTERFACE, &entry);
+
 	dbus_message_iter_close_container(iter, &entry);
 }
 
-- 
1.8.3.4

