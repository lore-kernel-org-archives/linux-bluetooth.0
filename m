Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 7/9] tools/bluetooth-player: Use
 g_dbus_dict_append_entry()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Message-ID: <4bdfc40f-3cda-a39d-5fab-96981013ab0b@jp.fujitsu.com>
Date: Wed, 28 Feb 2018 16:38:21 +0900
MIME-Version: 1.0
In-Reply-To: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/bluetooth-player.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 32ae4f6bb..074edfee9 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -702,39 +702,6 @@ static void cmd_change_folder(int argc, char *argv[])
 	bt_shell_printf("Attempting to change folder\n");
 }
 
-static void append_variant(DBusMessageIter *iter, int type, void *val)
-{
-	DBusMessageIter value;
-	char sig[2] = { type, '\0' };
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
-
-	dbus_message_iter_append_basic(&value, type, val);
-
-	dbus_message_iter_close_container(iter, &value);
-}
-
-static void dict_append_entry(DBusMessageIter *dict,
-			const char *key, int type, void *val)
-{
-	DBusMessageIter entry;
-
-	if (type == DBUS_TYPE_STRING) {
-		const char *str = *((const char **) val);
-		if (str == NULL)
-			return;
-	}
-
-	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-							NULL, &entry);
-
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
-
-	append_variant(&entry, type, val);
-
-	dbus_message_iter_close_container(dict, &entry);
-}
-
 struct list_items_args {
 	int start;
 	int end;
@@ -755,12 +722,13 @@ static void list_items_setup(DBusMessageIter *iter, void *user_data)
 	if (args->start < 0)
 		goto done;
 
-	dict_append_entry(&dict, "Start", DBUS_TYPE_UINT32, &args->start);
+	g_dbus_dict_append_entry(&dict, "Start",
+					DBUS_TYPE_UINT32, &args->start);
 
 	if (args->end < 0)
 		goto done;
 
-	dict_append_entry(&dict, "End", DBUS_TYPE_UINT32, &args->end);
+	g_dbus_dict_append_entry(&dict, "End", DBUS_TYPE_UINT32, &args->end);
 
 done:
 	dbus_message_iter_close_container(iter, &dict);
-- 
2.14.1

