Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 2/9] obexd: Use g_dbus_dict_append_entry()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <b4b7e77f-8575-36ec-62ef-b879c20f64f2@jp.fujitsu.com>
Message-ID: <fc4adfac-aaea-c758-1686-1d826d5c83f7@jp.fujitsu.com>
Date: Thu, 1 Mar 2018 13:27:10 +0900
MIME-Version: 1.0
In-Reply-To: <b4b7e77f-8575-36ec-62ef-b879c20f64f2@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 obexd/client/ftp.c        |  6 +++---
 obexd/client/map.c        |  5 +++--
 obexd/plugins/bluetooth.c | 40 +++-------------------------------------
 3 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
index 3628657d3..f4923b304 100644
--- a/obexd/client/ftp.c
+++ b/obexd/client/ftp.c
@@ -115,7 +115,7 @@ static void xml_element(GMarkupParseContext *ctxt,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	obex_dbus_dict_append(&dict, "Type", DBUS_TYPE_STRING, &element);
+	g_dbus_dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &element);
 
 	/* FIXME: User, Group, Other permission must be reviewed */
 
@@ -125,10 +125,10 @@ static void xml_element(GMarkupParseContext *ctxt,
 		if (g_str_equal("Size", key) == TRUE) {
 			guint64 size;
 			size = g_ascii_strtoll(values[i], NULL, 10);
-			obex_dbus_dict_append(&dict, key, DBUS_TYPE_UINT64,
+			g_dbus_dict_append_entry(&dict, key, DBUS_TYPE_UINT64,
 								&size);
 		} else
-			obex_dbus_dict_append(&dict, key, DBUS_TYPE_STRING,
+			g_dbus_dict_append_entry(&dict, key, DBUS_TYPE_STRING,
 								&values[i]);
 	}
 
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 4c6d67629..d1c897677 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -231,8 +231,9 @@ static void folder_element(GMarkupParseContext *ctxt, const char *element,
 
 	for (i = 0, key = names[i]; key; key = names[++i]) {
 		if (strcasecmp("name", key) == 0)
-			obex_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING,
-								&values[i]);
+			g_dbus_dict_append_entry(&dict, "Name",
+							DBUS_TYPE_STRING,
+							&values[i]);
 	}
 
 	dbus_message_iter_close_container(iter, &dict);
diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index d6028d114..ba1e0a99a 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -231,40 +231,6 @@ static void profile_free(void *data)
 	g_free(profile);
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
 static int register_profile(struct bluetooth_profile *profile)
 {
 	DBusMessage *msg;
@@ -303,7 +269,7 @@ static int register_profile(struct bluetooth_profile *profile)
 					DBUS_TYPE_VARIANT_AS_STRING
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
 					&opt);
-	dict_append_entry(&opt, "AutoConnect", DBUS_TYPE_BOOLEAN,
+	g_dbus_dict_append_entry(&opt, "AutoConnect", DBUS_TYPE_BOOLEAN,
 								&auto_connect);
 	if (profile->driver->record) {
 		if (profile->driver->port != 0)
@@ -315,8 +281,8 @@ static int register_profile(struct bluetooth_profile *profile)
 			xml = g_markup_printf_escaped(profile->driver->record,
 						profile->driver->channel,
 						profile->driver->name);
-		dict_append_entry(&opt, "ServiceRecord", DBUS_TYPE_STRING,
-								&xml);
+		g_dbus_dict_append_entry(&opt, "ServiceRecord",
+						DBUS_TYPE_STRING, &xml);
 		g_free(xml);
 	}
 	dbus_message_iter_close_container(&iter, &opt);
-- 
2.14.1

