Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 5/8] gdbus: Introduce g_dbus_proxy_path_lookup()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Message-ID: <ce0da439-86d4-eafd-80b7-8591e287f5b0@jp.fujitsu.com>
Date: Fri, 22 Dec 2017 16:35:49 +0900
MIME-Version: 1.0
In-Reply-To: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_dbus_proxy_path_lookup() returns the path of the proxy that matches the
passed text. It also returns the index of the proxy coming next to the
matched proxy in the passed list.
---
 gdbus/client.c | 19 +++++++++++++++++++
 gdbus/gdbus.h  |  1 +
 2 files changed, 20 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index 6ec611455..bb13709be 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <stdio.h>
+#include <string.h>
 #include <glib.h>
 #include <dbus/dbus.h>
 
@@ -371,6 +372,24 @@ GDBusProxy *g_dbus_proxy_lookup(GList *list, const char *path,
 	return NULL;
 }
 
+char *g_dbus_proxy_path_lookup(GList *source, int *index, const char *text)
+{
+	GList *l;
+
+	for (l = g_list_nth(source, *index); l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
+		const char *path;
+
+		(*index)++;
+
+		path = g_dbus_proxy_get_path(proxy);
+		if (!strncasecmp(path, text, strlen(text)))
+			return strdup(path);
+	}
+
+	return NULL;
+}
+
 static gboolean properties_changed(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 930aa5f77..99f21b3ce 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -341,6 +341,7 @@ gboolean g_dbus_proxy_get_property(GDBusProxy *proxy, const char *name,
 
 GDBusProxy *g_dbus_proxy_lookup(GList *list, const char *path,
 						const char *interface);
+char *g_dbus_proxy_path_lookup(GList *source, int *index, const char *text);
 
 gboolean g_dbus_proxy_refresh_property(GDBusProxy *proxy, const char *name);
 
-- 
2.14.1

