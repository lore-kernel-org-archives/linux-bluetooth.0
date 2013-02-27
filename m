Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3 v3] gdbus: Fix not calling property_changed callback
Date: Wed, 27 Feb 2013 14:00:23 +0200
Message-Id: <1361966423-3582-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1361966423-3582-1-git-send-email-luiz.dentz@gmail.com>
References: <1361966423-3582-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case a property did not appear by the time proxy_added was called
property_changed has to be called if it appear latter otherwise the
application will be unaware of it.
---
 gdbus/client.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 369e3ac..2a7d2e1 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -205,6 +205,7 @@ static void prop_entry_free(gpointer data)
 static void add_property(GDBusProxy *proxy, const char *name,
 				DBusMessageIter *iter, gboolean send_changed)
 {
+	GDBusClient *client = proxy->client;
 	DBusMessageIter value;
 	struct prop_entry *prop;
 
@@ -215,20 +216,8 @@ static void add_property(GDBusProxy *proxy, const char *name,
 
 	prop = g_hash_table_lookup(proxy->prop_list, name);
 	if (prop != NULL) {
-		GDBusClient *client = proxy->client;
-
 		prop_entry_update(prop, &value);
-
-		if (proxy->prop_func)
-			proxy->prop_func(proxy, name, &value, proxy->prop_data);
-
-		if (client == NULL || send_changed == FALSE)
-			return;
-
-		if (client->property_changed)
-			client->property_changed(proxy, name, &value,
-							client->user_data);
-		return;
+		goto done;
 	}
 
 	prop = prop_entry_new(name, &value);
@@ -237,8 +226,16 @@ static void add_property(GDBusProxy *proxy, const char *name,
 
 	g_hash_table_replace(proxy->prop_list, prop->name, prop);
 
+done:
 	if (proxy->prop_func)
 		proxy->prop_func(proxy, name, &value, proxy->prop_data);
+
+	if (client == NULL || send_changed == FALSE)
+		return;
+
+	if (client->property_changed)
+		client->property_changed(proxy, name, &value,
+							client->user_data);
 }
 
 static void update_properties(GDBusProxy *proxy, DBusMessageIter *iter,
-- 
1.8.1.2

