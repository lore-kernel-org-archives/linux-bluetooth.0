Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] gdbus: Fix memory leak on properties_set()
Date: Sat,  5 Jan 2013 20:47:46 -0400
Message-Id: <1357433266-31642-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The pointer returned by dbus_message_iter_get_signature() must be freed
with dbus_free().

Fixes this memory leak:

==1857== 16 bytes in 1 blocks are definitely lost in loss record 104 of
251
==1857==    at 0x402BF52: realloc (in
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==1857==    by 0x415E286: dbus_realloc (in
/lib/i386-linux-gnu/libdbus-1.so.3.5.8)
==1857==    by 0x415E70B: ??? (in
/lib/i386-linux-gnu/libdbus-1.so.3.5.8)
==1857==    by 0x415F17B: ??? (in
/lib/i386-linux-gnu/libdbus-1.so.3.5.8)
==1857==    by 0x414CB33: dbus_message_iter_get_signature (in
/lib/i386-linux-gnu/libdbus-1.so.3.5.8)
==1857==    by 0x8053239: properties_set (object.c:899)
==1857==    by 0x5FFFFF: ???
==1857==
---
 gdbus/object.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 688cd05..1a54b3f 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -846,6 +846,8 @@ static DBusMessage *properties_set(DBusConnection *connection,
 	const GDBusPropertyTable *property;
 	const char *name, *interface;
 	struct property_data *propdata;
+	gboolean valid_signature;
+	char *signature;
 
 	if (!dbus_message_iter_init(message, &iter))
 		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
@@ -896,7 +898,10 @@ static DBusMessage *properties_set(DBusConnection *connection,
 						DBUS_ERROR_UNKNOWN_PROPERTY,
 						"No such property '%s'", name);
 
-	if (strcmp(dbus_message_iter_get_signature(&sub), property->type))
+	signature = dbus_message_iter_get_signature(&sub);
+	valid_signature = strcmp(signature, property->type) ? FALSE : TRUE;
+	dbus_free(signature);
+	if (!valid_signature)
 		return g_dbus_create_error(message,
 					DBUS_ERROR_INVALID_SIGNATURE,
 					"Invalid signature for '%s'", name);
-- 
1.7.9.5

