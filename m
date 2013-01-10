Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] build: Fix using DBusBasicValue
Date: Thu, 10 Jan 2013 18:59:53 +0200
Message-Id: <1357837193-10092-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

DBusBasicValue needs a more recent libdbus so use const void * instead
---
v2: Fix all places

 tools/mpris-player.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index de66f97..246791a 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -151,7 +151,6 @@ static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
 						DBusMessageIter *metadata)
 {
 	DBusMessageIter var;
-	DBusBasicValue value;
 	int type;
 
 	printf("metadata %s found\n", key);
@@ -181,6 +180,8 @@ static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
 		dict_append_array(metadata, key, DBUS_TYPE_STRING, &values, i);
 		dbus_free(values);
 	} else if (dbus_type_is_basic(type)) {
+		const void *value;
+
 		dbus_message_iter_get_basic(&var, &value);
 		dict_append_entry(metadata, key, type, &value);
 	} else
@@ -312,7 +313,7 @@ static int parse_property(DBusConnection *conn, const char *path,
 						DBusMessageIter *properties)
 {
 	DBusMessageIter var;
-	DBusBasicValue value;
+	const void *value;
 	int type;
 
 	printf("property %s found\n", key);
-- 
1.8.0.1

