Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 10/26] cups: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:40 -0300
Message-Id: <1368073016-28434-10-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 profiles/cups/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index 2079812..ba3b029 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -158,7 +159,7 @@ static char *device_get_ieee1284_id(const char *adapter, const char *device)
 	/* Hopefully we only get one handle, or take a punt */
 	while (dbus_message_iter_get_arg_type(&reply_iter_entry) ==
 							DBUS_TYPE_DICT_ENTRY) {
-		guint32 key;
+		uint32_t key;
 		DBusMessageIter dict_entry;
 
 		dbus_message_iter_recurse(&reply_iter_entry, &dict_entry);
@@ -245,7 +246,7 @@ static void add_device_to_list(const char *name, const char *bdaddr,
 static gboolean parse_device_properties(DBusMessageIter *reply_iter,
 						char **name, char **bdaddr)
 {
-	guint32 class = 0;
+	uint32_t class = 0;
 	DBusMessageIter reply_iter_entry;
 
 	if (dbus_message_iter_get_arg_type(reply_iter) != DBUS_TYPE_ARRAY)
-- 
1.8.2.2

