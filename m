Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 12/14] obexd/client: Remove unused static functions
Date: Fri, 4 Oct 2013 11:05:36 +0200
Message-ID: <1380877538-22614-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build error:

  CC     obexd/client/obexd-dbus.o
obexd/client/dbus.c:70:13: error: ‘append_array_variant’ defined but
    not used [-Werror=unused-function]
obexd/client/dbus.c:97:13: error: ‘append_dict_variant’ defined but
    not used [-Werror=unused-function]
---
 obexd/client/dbus.c | 81 -----------------------------------------------------
 1 file changed, 81 deletions(-)

diff --git a/obexd/client/dbus.c b/obexd/client/dbus.c
index d635a45..243af59 100644
--- a/obexd/client/dbus.c
+++ b/obexd/client/dbus.c
@@ -67,87 +67,6 @@ void obex_dbus_dict_append(DBusMessageIter *dict,
 	dbus_message_iter_close_container(dict, &keyiter);
 }
 
-static void append_array_variant(DBusMessageIter *iter, int type, void *val)
-{
-	DBusMessageIter variant, array;
-	char typesig[2];
-	char arraysig[3];
-	const char **str_array = *(const char ***) val;
-	int i;
-
-	arraysig[0] = DBUS_TYPE_ARRAY;
-	arraysig[1] = typesig[0] = type;
-	arraysig[2] = typesig[1] = '\0';
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
-						arraysig, &variant);
-
-	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
-						typesig, &array);
-
-	for (i = 0; str_array[i]; i++)
-		dbus_message_iter_append_basic(&array, type,
-						&(str_array[i]));
-
-	dbus_message_iter_close_container(&variant, &array);
-
-	dbus_message_iter_close_container(iter, &variant);
-}
-
-static void append_dict_variant(DBusMessageIter *iter, int type, void *val)
-{
-	DBusMessageIter variant, array, entry;
-	char typesig[5];
-	char arraysig[6];
-	const void **val_array = *(const void ***) val;
-	int i;
-
-	arraysig[0] = DBUS_TYPE_ARRAY;
-	arraysig[1] = typesig[0] = DBUS_DICT_ENTRY_BEGIN_CHAR;
-	arraysig[2] = typesig[1] = DBUS_TYPE_STRING;
-	arraysig[3] = typesig[2] = type;
-	arraysig[4] = typesig[3] = DBUS_DICT_ENTRY_END_CHAR;
-	arraysig[5] = typesig[4] = '\0';
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
-						arraysig, &variant);
-
-	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
-						typesig, &array);
-
-	for (i = 0; val_array[i]; i += 2) {
-		dbus_message_iter_open_container(&array, DBUS_TYPE_DICT_ENTRY,
-							NULL, &entry);
-
-		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
-						&(val_array[i + 0]));
-
-		/*
-		 * D-Bus expects a char** or uint8* depending on the type
-		 * given. Since we are dealing with an array through a void**
-		 * (and thus val_array[i] is a pointer) we need to
-		 * differentiate DBUS_TYPE_STRING from the others. The other
-		 * option would be the user to pass the exact type to this
-		 * function, instead of a pointer to it. However in this case
-		 * a cast from type to void* would be needed, which is not
-		 * good.
-		 */
-		if (type == DBUS_TYPE_STRING) {
-			dbus_message_iter_append_basic(&entry, type,
-							&(val_array[i + 1]));
-		} else {
-			dbus_message_iter_append_basic(&entry, type,
-							val_array[i + 1]);
-		}
-
-		dbus_message_iter_close_container(&array, &entry);
-	}
-
-	dbus_message_iter_close_container(&variant, &array);
-
-	dbus_message_iter_close_container(iter, &variant);
-}
-
 int obex_dbus_signal_property_changed(DBusConnection *conn,
 					const char *path,
 					const char *interface,
-- 
1.8.4

