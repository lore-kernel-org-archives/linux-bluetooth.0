Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 6/9] tools/obexctl: Use g_dbus_dict_append_entry()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Message-ID: <995c4950-2327-0d34-8f3b-3b7f02b48a13@jp.fujitsu.com>
Date: Wed, 28 Feb 2018 16:38:16 +0900
MIME-Version: 1.0
In-Reply-To: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/obexctl.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index b6333842e..c197f5e5d 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -121,39 +121,6 @@ static void connect_reply(DBusMessage *message, void *user_data)
 	bt_shell_printf("Connection successful\n");
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
-static void dict_append_entry(DBusMessageIter *dict, const char *key,
-							int type, void *val)
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
 struct connect_args {
 	char *dev;
 	char *target;
@@ -185,7 +152,8 @@ static void connect_setup(DBusMessageIter *iter, void *user_data)
 	if (args->target == NULL)
 		goto done;
 
-	dict_append_entry(&dict, "Target", DBUS_TYPE_STRING, &args->target);
+	g_dbus_dict_append_entry(&dict, "Target",
+					DBUS_TYPE_STRING, &args->target);
 
 done:
 	dbus_message_iter_close_container(iter, &dict);
-- 
2.14.1

