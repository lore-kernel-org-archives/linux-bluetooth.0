Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] tools/obexctl: Remove unused variable
Date: Thu, 05 Mar 2015 18:29:47 +0530
Message-id: <1425560387-9504-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removes variable 'ctype' which is assigned but never used.
---
 tools/obexctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 8dcada8..4faff6b 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -1233,7 +1233,6 @@ static void list_messages_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
 	DBusMessageIter iter, array;
-	int ctype;
 
 	dbus_error_init(&error);
 
@@ -1250,8 +1249,8 @@ static void list_messages_reply(DBusMessage *message, void *user_data)
 
 	dbus_message_iter_recurse(&iter, &array);
 
-	while ((ctype = dbus_message_iter_get_arg_type(&array)) ==
-							DBUS_TYPE_DICT_ENTRY) {
+	while ((dbus_message_iter_get_arg_type(&array)) ==
+						DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter entry;
 		const char *obj;
 
-- 
1.9.1

