Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 5/8] gdbus: Introduce g_dbus_proxy_path_lookup()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Message-ID: <4ed31460-c1ba-0e0d-f110-2aed9ab0b7d5@jp.fujitsu.com>
Date: Thu, 28 Dec 2017 14:44:15 +0900
MIME-Version: 1.0
In-Reply-To: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_dbus_proxy_path_lookup() returns the path of the proxy that matches the
passed path. It also returns the index of the proxy coming next to the
matched proxy in the passed list.
---
 gdbus/client.c | 21 +++++++++++++++++++++
 gdbus/gdbus.h  |  1 +
 2 files changed, 22 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index 3768d2f59..66cd43786 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <stdio.h>
+#include <string.h>
 #include <glib.h>
 #include <dbus/dbus.h>
 
@@ -377,6 +378,26 @@ GDBusProxy *g_dbus_proxy_lookup(GList *list, int *index, const char *path,
 	return NULL;
 }
 
+char *g_dbus_proxy_path_lookup(GList *list, int *index, const char *path)
+{
+	int len = strlen(path);
+	GList *l;
+
+	for (l = g_list_nth(list, index ? *index : 0); l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
+
+		const char *proxy_path = g_dbus_proxy_get_path(proxy);
+
+		if (index)
+			(*index)++;
+
+		if (!strncasecmp(proxy_path, path, len))
+			return strdup(proxy_path);
+	}
+
+	return NULL;
+}
+
 static gboolean properties_changed(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 85cb9682e..4880c84e7 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -341,6 +341,7 @@ gboolean g_dbus_proxy_get_property(GDBusProxy *proxy, const char *name,
 
 GDBusProxy *g_dbus_proxy_lookup(GList *list, int *index, const char *path,
 						const char *interface);
+char *g_dbus_proxy_path_lookup(GList *list, int *index, const char *path);
 
 gboolean g_dbus_proxy_refresh_property(GDBusProxy *proxy, const char *name);
 
-- 
2.14.1

