Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] client: Use selected attribute when selecting by UUID
Date: Tue, 14 Mar 2017 13:52:41 +0200
Message-Id: <20170314115241.18886-2-luiz.dentz@gmail.com>
In-Reply-To: <20170314115241.18886-1-luiz.dentz@gmail.com>
References: <20170314115241.18886-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There could be multiple instances of the same UUID, like e.g CCC and CEP,
so instead of matching the first one found from the beginning this uses
the current selected attribute as parent looking up existing child
attributes first.
---
 client/gatt.c | 26 +++++++++++++++++++-------
 client/gatt.h |  2 +-
 client/main.c |  4 ++--
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index f7a2f0c..79bc7a3 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -314,7 +314,8 @@ static GDBusProxy *select_attribute(const char *path)
 	return select_proxy(path, descriptors);
 }
 
-static GDBusProxy *select_proxy_by_uuid(const char *uuid, GList *source)
+static GDBusProxy *select_proxy_by_uuid(GDBusProxy *parent, const char *uuid,
+					GList *source)
 {
 	GList *l;
 	const char *value;
@@ -323,6 +324,10 @@ static GDBusProxy *select_proxy_by_uuid(const char *uuid, GList *source)
 	for (l = source; l; l = g_list_next(l)) {
 		GDBusProxy *proxy = l->data;
 
+		if (parent && !g_str_has_prefix(g_dbus_proxy_get_path(proxy),
+						g_dbus_proxy_get_path(parent)))
+			continue;
+
 		if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
 			continue;
 
@@ -335,27 +340,34 @@ static GDBusProxy *select_proxy_by_uuid(const char *uuid, GList *source)
 	return NULL;
 }
 
-static GDBusProxy *select_attribute_by_uuid(const char *uuid)
+static GDBusProxy *select_attribute_by_uuid(GDBusProxy *parent,
+							const char *uuid)
 {
 	GDBusProxy *proxy;
 
-	proxy = select_proxy_by_uuid(uuid, services);
+	proxy = select_proxy_by_uuid(parent, uuid, services);
 	if (proxy)
 		return proxy;
 
-	proxy = select_proxy_by_uuid(uuid, characteristics);
+	proxy = select_proxy_by_uuid(parent, uuid, characteristics);
 	if (proxy)
 		return proxy;
 
-	return select_proxy_by_uuid(uuid, descriptors);
+	return select_proxy_by_uuid(parent, uuid, descriptors);
 }
 
-GDBusProxy *gatt_select_attribute(const char *arg)
+GDBusProxy *gatt_select_attribute(GDBusProxy *parent, const char *arg)
 {
 	if (arg[0] == '/')
 		return select_attribute(arg);
 
-	return select_attribute_by_uuid(arg);
+	if (parent) {
+		GDBusProxy *proxy = select_attribute_by_uuid(parent, arg);
+		if (proxy)
+			return proxy;
+	}
+
+	return select_attribute_by_uuid(parent, arg);
 }
 
 static char *attribute_generator(const char *text, int state, GList *source)
diff --git a/client/gatt.h b/client/gatt.h
index 689bb4d..7a91975 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -31,7 +31,7 @@ void gatt_add_descriptor(GDBusProxy *proxy);
 void gatt_remove_descriptor(GDBusProxy *proxy);
 
 void gatt_list_attributes(const char *device);
-GDBusProxy *gatt_select_attribute(const char *path);
+GDBusProxy *gatt_select_attribute(GDBusProxy *parent, const char *path);
 char *gatt_attribute_generator(const char *text, int state);
 
 void gatt_read_attribute(GDBusProxy *proxy);
diff --git a/client/main.c b/client/main.c
index d01e5fa..857c111 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1704,7 +1704,7 @@ static void cmd_select_attribute(const char *arg)
 		return;
 	}
 
-	proxy = gatt_select_attribute(arg);
+	proxy = gatt_select_attribute(default_attr, arg);
 	if (proxy)
 		set_default_attribute(proxy);
 }
@@ -1720,7 +1720,7 @@ static struct GDBusProxy *find_attribute(const char *arg)
 		return NULL;
 	}
 
-	proxy = gatt_select_attribute(arg);
+	proxy = gatt_select_attribute(default_attr, arg);
 	if (!proxy) {
 		rl_printf("Attribute %s not available\n", arg);
 		return NULL;
-- 
2.9.3

