Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 8/9] unit/test-gdbus-client: Use
 g_dbus_dict_append_entry()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Message-ID: <fcda4dd3-e8ec-9fbe-b99c-94c3bc8422ef@jp.fujitsu.com>
Date: Wed, 28 Feb 2018 16:38:25 +0900
MIME-Version: 1.0
In-Reply-To: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gdbus-client.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index dd17c00f7..a2c88f309 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -178,39 +178,6 @@ static void client_connect_disconnect(const void *data)
 								context);
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
-static void dict_append_entry(DBusMessageIter *dict, const char *key, int type,
-								void *val)
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
 static gboolean get_dict(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -223,8 +190,9 @@ static gboolean get_dict(const GDBusPropertyTable *property,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	dict_append_entry(&dict, "String", DBUS_TYPE_STRING, &string);
-	dict_append_entry(&dict, "Boolean", DBUS_TYPE_BOOLEAN, &boolean);
+	g_dbus_dict_append_entry(&dict, "String", DBUS_TYPE_STRING, &string);
+	g_dbus_dict_append_entry(&dict, "Boolean",
+					DBUS_TYPE_BOOLEAN, &boolean);
 
 	dbus_message_iter_close_container(iter, &dict);
 
-- 
2.14.1

