Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] obexd: Move parse_size function in map.c
Date: Tue, 15 Jan 2013 14:56:41 +0100
Message-Id: <1358258204-4090-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This reorders msg_parsers and moves the function parse_size
to match the order in the MAP specification.
---
 obexd/client/map.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 54a6a7f..a51aa5e 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -810,19 +810,19 @@ static void parse_type(struct map_msg *msg, const char *value,
 	obex_dbus_dict_append(iter, "Type", DBUS_TYPE_STRING, &value);
 }
 
-static void parse_status(struct map_msg *msg, const char *value,
+static void parse_size(struct map_msg *msg, const char *value,
 							DBusMessageIter *iter)
 {
-	g_free(msg->status);
-	msg->status = g_strdup(value);
-	obex_dbus_dict_append(iter, "Status", DBUS_TYPE_STRING, &value);
+	msg->size = g_ascii_strtoll(value, NULL, 10);
+	obex_dbus_dict_append(iter, "Size", DBUS_TYPE_UINT64, &msg->size);
 }
 
-static void parse_size(struct map_msg *msg, const char *value,
+static void parse_status(struct map_msg *msg, const char *value,
 							DBusMessageIter *iter)
 {
-	msg->size = g_ascii_strtoll(value, NULL, 10);
-	obex_dbus_dict_append(iter, "Size", DBUS_TYPE_UINT64, &msg->size);
+	g_free(msg->status);
+	msg->status = g_strdup(value);
+	obex_dbus_dict_append(iter, "Status", DBUS_TYPE_STRING, &value);
 }
 
 static void parse_priority(struct map_msg *msg, const char *value,
@@ -890,8 +890,8 @@ static struct map_msg_parser {
 		{ "recipient_name", parse_recipient },
 		{ "recipient_addressing", parse_recipient_address },
 		{ "type", parse_type },
-		{ "reception_status", parse_status },
 		{ "size", parse_size },
+		{ "reception_status", parse_status },
 		{ "priority", parse_priority },
 		{ "read", parse_read },
 		{ "sent", parse_sent },
-- 
1.8.1

