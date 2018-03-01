Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 7/9] tools/bluetooth-player: Use
 g_dbus_dict_append_entry()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <b4b7e77f-8575-36ec-62ef-b879c20f64f2@jp.fujitsu.com>
Message-ID: <d6a3d759-4965-f1c5-8499-50848cd79305@jp.fujitsu.com>
Date: Thu, 1 Mar 2018 13:27:33 +0900
MIME-Version: 1.0
In-Reply-To: <b4b7e77f-8575-36ec-62ef-b879c20f64f2@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/bluetooth-player.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index a170aef24..4eb3153e9 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -734,39 +734,6 @@ static void cmd_change_folder(int argc, char *argv[])
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
@@ -787,12 +754,13 @@ static void list_items_setup(DBusMessageIter *iter, void *user_data)
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

