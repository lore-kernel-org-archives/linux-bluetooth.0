Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] obexd: Add parameter Text to GetMessageListing response
Date: Tue, 15 Jan 2013 14:56:42 +0100
Message-Id: <1358258204-4090-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The Text flag indicates if the message contains any textual content
or has binary content only.
---
 doc/obex-api.txt   |  7 +++++++
 obexd/client/map.c | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index bb14fba..9e17f1a 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -587,6 +587,13 @@ Methods		void SetFolder(string name)
 
 					Message size in bytes
 
+				boolean Text:
+
+					Message text flag
+
+					Specifies whether message has textual
+					content or is binary only
+
 				string Status:
 
 					Message reception status
diff --git a/obexd/client/map.c b/obexd/client/map.c
index a51aa5e..d32d6ac 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -99,6 +99,7 @@ struct map_data {
 #define MAP_MSG_FLAG_READ	0x02
 #define MAP_MSG_FLAG_SENT	0x04
 #define MAP_MSG_FLAG_PROTECTED	0x08
+#define MAP_MSG_FLAG_TEXT	0x10
 
 struct map_msg {
 	struct map_data *data;
@@ -629,6 +630,12 @@ static gboolean get_protected(const GDBusPropertyTable *property,
 	return get_flag(property, iter, MAP_MSG_FLAG_PROTECTED, data);
 }
 
+static gboolean get_text(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	return get_flag(property, iter, MAP_MSG_FLAG_TEXT, data);
+}
+
 static void set_status(const GDBusPropertyTable *property,
 			DBusMessageIter *iter, GDBusPendingPropertySet id,
 			uint8_t status, void *data)
@@ -712,6 +719,7 @@ static const GDBusPropertyTable map_msg_properties[] = {
 						recipient_address_exists },
 	{ "Type", "s", get_type, NULL, type_exists },
 	{ "Size", "t", get_size },
+	{ "Text", "b", get_text },
 	{ "Priority", "b", get_priority },
 	{ "Read", "b", get_read, set_read },
 	{ "Sent", "b", get_sent },
@@ -817,6 +825,19 @@ static void parse_size(struct map_msg *msg, const char *value,
 	obex_dbus_dict_append(iter, "Size", DBUS_TYPE_UINT64, &msg->size);
 }
 
+static void parse_text(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	gboolean flag = strcasecmp(value, "no") != 0;
+
+	if (flag)
+		msg->flags |= MAP_MSG_FLAG_TEXT;
+	else
+		msg->flags &= ~MAP_MSG_FLAG_TEXT;
+
+	obex_dbus_dict_append(iter, "Text", DBUS_TYPE_BOOLEAN, &flag);
+}
+
 static void parse_status(struct map_msg *msg, const char *value,
 							DBusMessageIter *iter)
 {
@@ -891,6 +912,7 @@ static struct map_msg_parser {
 		{ "recipient_addressing", parse_recipient_address },
 		{ "type", parse_type },
 		{ "size", parse_size },
+		{ "text", parse_text },
 		{ "reception_status", parse_status },
 		{ "priority", parse_priority },
 		{ "read", parse_read },
-- 
1.8.1

