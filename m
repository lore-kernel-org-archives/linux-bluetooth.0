Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Christian Fetzer <christian.fetzer@bmw-carit.de>
Subject: [PATCH 2/8] obexd: Add property exist functions to map client
Date: Fri, 11 Jan 2013 16:55:51 +0100
Message-Id: <1357919757-10334-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This fixes crashes in MAP client when the server does not send optional properties.

0  0x00007ffff6a792c5 in raise () from /usr/lib/libc.so.6
1  0x00007ffff6a7a748 in abort () from /usr/lib/libc.so.6
2  0x00007ffff731c145 in ?? () from /usr/lib/libdbus-1.so.3
3  0x00007ffff7312a25 in ?? () from /usr/lib/libdbus-1.so.3
4  0x00007ffff73050d6 in dbus_message_iter_append_basic () from /usr/lib/libdbus-1.so.3
5  0x0000000000433cc5 in get_replyto (property=<optimized out>, iter=<optimized out>,
    data=<optimized out>) at obexd/client/map.c:484
6  0x00000000004103b6 in append_property (p=p@entry=0x6594c0 <map_msg_properties+192>,
    dict=dict@entry=0x7fffffffd8e0, iface=0x6a3720) at gdbus/object.c:547
7  0x0000000000410472 in append_properties (data=data@entry=0x6a3720, iter=iter@entry=
    0x7fffffffd960) at gdbus/object.c:576
8  0x00000000004104d1 in append_interface (data=0x6a3720, user_data=0x7fffffffda40)
    at gdbus/object.c:591
9  0x00007ffff7058a4d in g_slist_foreach () from /usr/lib/libglib-2.0.so.0
10 0x0000000000411d05 in emit_interfaces_added (data=0x6a2ff0) at gdbus/object.c:623
11 process_changes (user_data=0x6a2ff0) at gdbus/object.c:1006
12 0x00007ffff703c845 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
13 0x00007ffff703cb78 in ?? () from /usr/lib/libglib-2.0.so.0
14 0x00007ffff703cf72 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
15 0x000000000040df82 in main (argc=1, argv=0x7fffffffdd88) at obexd/src/main.c:323
---
 obexd/client/map.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 08914a6..635d951 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -435,6 +435,13 @@ done:
 	msg->pending = 0;
 }
 
+static gboolean subject_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct map_msg *msg = data;
+
+	return msg->subject != NULL;
+}
+
 static gboolean get_subject(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -445,6 +452,13 @@ static gboolean get_subject(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean timestamp_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct map_msg *msg = data;
+
+	return msg->timestamp != NULL;
+}
+
 static gboolean get_timestamp(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -455,6 +469,13 @@ static gboolean get_timestamp(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean sender_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct map_msg *msg = data;
+
+	return msg->sender != NULL;
+}
+
 static gboolean get_sender(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -465,6 +486,14 @@ static gboolean get_sender(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean sender_address_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct map_msg *msg = data;
+
+	return msg->sender_address != NULL;
+}
+
 static gboolean get_sender_address(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -476,6 +505,13 @@ static gboolean get_sender_address(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean replyto_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct map_msg *msg = data;
+
+	return msg->replyto != NULL;
+}
+
 static gboolean get_replyto(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -486,6 +522,13 @@ static gboolean get_replyto(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean recipient_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct map_msg *msg = data;
+
+	return msg->recipient != NULL;
+}
+
 static gboolean get_recipient(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -496,6 +539,14 @@ static gboolean get_recipient(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean recipient_address_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct map_msg *msg = data;
+
+	return msg->recipient_address != NULL;
+}
+
 static gboolean get_recipient_address(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -507,6 +558,13 @@ static gboolean get_recipient_address(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean type_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct map_msg *msg = data;
+
+	return msg->type != NULL;
+}
+
 static gboolean get_type(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -635,14 +693,16 @@ static const GDBusMethodTable map_msg_methods[] = {
 };
 
 static const GDBusPropertyTable map_msg_properties[] = {
-	{ "Subject", "s", get_subject },
-	{ "Timestamp", "s", get_timestamp },
-	{ "Sender", "s", get_sender },
-	{ "SenderAddress", "s", get_sender_address },
-	{ "ReplyTo", "s", get_replyto },
-	{ "Recipient", "s", get_recipient },
-	{ "RecipientAddress", "s", get_recipient_address },
-	{ "Type", "s", get_type },
+	{ "Subject", "s", get_subject, NULL, subject_exists },
+	{ "Timestamp", "s", get_timestamp, NULL, timestamp_exists },
+	{ "Sender", "s", get_sender, NULL, sender_exists },
+	{ "SenderAddress", "s", get_sender_address, NULL,
+						sender_address_exists },
+	{ "ReplyTo", "s", get_replyto, NULL, replyto_exists },
+	{ "Recipient", "s", get_recipient, NULL, recipient_exists },
+	{ "RecipientAddress", "s", get_recipient_address, NULL,
+						recipient_address_exists },
+	{ "Type", "s", get_type, NULL, type_exists },
 	{ "Size", "t", get_size },
 	{ "Priority", "b", get_priority },
 	{ "Read", "b", get_read, set_read },
-- 
1.8.1

