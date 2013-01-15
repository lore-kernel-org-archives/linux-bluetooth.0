Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] obexd: Add parameter AttachmentSize to GetMessageListing response
Date: Tue, 15 Jan 2013 14:56:43 +0100
Message-Id: <1358258204-4090-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The parameter AttachmentSize indicates if the message contains
any attachment and their overall size (in bytes).
---
 doc/obex-api.txt   |  4 ++++
 obexd/client/map.c | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 9e17f1a..e2eb55f 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -601,6 +601,10 @@ Methods		void SetFolder(string name)
 					Possible values: "complete",
 					"fractioned" and "notification"
 
+				uint64 AttachmentSize:
+
+					Message overall attachment size in bytes
+
 				boolean Priority:
 
 					Message priority flag
diff --git a/obexd/client/map.c b/obexd/client/map.c
index d32d6ac..f9f7c4f 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -115,6 +115,7 @@ struct map_msg {
 	char *type;
 	uint64_t size;
 	char *status;
+	uint64_t attachment_size;
 	uint8_t flags;
 	GDBusPendingPropertySet pending;
 };
@@ -594,6 +595,17 @@ static gboolean get_size(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_attachment_size(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64,
+							&msg->attachment_size);
+
+	return TRUE;
+}
+
 static gboolean get_flag(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, uint8_t flag,
 					void *data)
@@ -720,6 +732,7 @@ static const GDBusPropertyTable map_msg_properties[] = {
 	{ "Type", "s", get_type, NULL, type_exists },
 	{ "Size", "t", get_size },
 	{ "Text", "b", get_text },
+	{ "AttachmentSize", "t", get_attachment_size },
 	{ "Priority", "b", get_priority },
 	{ "Read", "b", get_read, set_read },
 	{ "Sent", "b", get_sent },
@@ -846,6 +859,14 @@ static void parse_status(struct map_msg *msg, const char *value,
 	obex_dbus_dict_append(iter, "Status", DBUS_TYPE_STRING, &value);
 }
 
+static void parse_attachment_size(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	msg->attachment_size = g_ascii_strtoll(value, NULL, 10);
+	obex_dbus_dict_append(iter, "AttachmentSize", DBUS_TYPE_UINT64,
+							&msg->attachment_size);
+}
+
 static void parse_priority(struct map_msg *msg, const char *value,
 							DBusMessageIter *iter)
 {
@@ -914,6 +935,7 @@ static struct map_msg_parser {
 		{ "size", parse_size },
 		{ "text", parse_text },
 		{ "reception_status", parse_status },
+		{ "attachment_size", parse_attachment_size },
 		{ "priority", parse_priority },
 		{ "read", parse_read },
 		{ "sent", parse_sent },
-- 
1.8.1

