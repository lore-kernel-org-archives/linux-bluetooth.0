Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] obexd: Add parameter Status to GetMessageListing response
Date: Tue, 15 Jan 2013 14:56:44 +0100
Message-Id: <1358258204-4090-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1358258204-4090-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The parameter Status indicates the status of reception of the message.
It can be used to differentiate between messages with a reception status
of "completed", "fractioned" and "notification".

This parameter got lost when obexd was refactored to use of D-Bus properties.
The documentation and the parsing code for it was still there.
---
 obexd/client/map.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index f9f7c4f..ea5681a 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -595,6 +595,24 @@ static gboolean get_size(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean reception_status_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct map_msg *msg = data;
+
+	return msg->status != NULL;
+}
+
+static gboolean get_reception_status(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &msg->status);
+
+	return TRUE;
+}
+
 static gboolean get_attachment_size(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -732,6 +750,7 @@ static const GDBusPropertyTable map_msg_properties[] = {
 	{ "Type", "s", get_type, NULL, type_exists },
 	{ "Size", "t", get_size },
 	{ "Text", "b", get_text },
+	{ "Status", "s", get_reception_status, NULL, reception_status_exists },
 	{ "AttachmentSize", "t", get_attachment_size },
 	{ "Priority", "b", get_priority },
 	{ "Read", "b", get_read, set_read },
-- 
1.8.1

