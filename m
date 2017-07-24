Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] client: Print properties changes of LEAdvertisingManager1
Date: Mon, 24 Jul 2017 17:45:39 +0300
Message-Id: <20170724144539.27704-2-luiz.dentz@gmail.com>
In-Reply-To: <20170724144539.27704-1-luiz.dentz@gmail.com>
References: <20170724144539.27704-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints properties changes of org.bluez.LEAdvertisingManager1
interface:

[bluetooth]# advertise on
[CHG] Controller B8:8A:60:D8:17:D7 AdvertisementInstances: 0x04
Advertising object registered
[bluetooth]# advertise off
[CHG] Controller B8:8A:60:D8:17:D7 AdvertisementInstances: 0x05
---
 client/main.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/client/main.c b/client/main.c
index ae7d6b84c..e0336a14c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -583,10 +583,25 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	}
 }
 
+static struct adapter *find_ctrl(GList *source, const char *path)
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		struct adapter *adapter = list->data;
+
+		if (!strcasecmp(g_dbus_proxy_get_path(adapter->proxy), path))
+			return adapter;
+	}
+
+	return NULL;
+}
+
 static void property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
 	const char *interface;
+	struct adapter *ctrl;
 
 	interface = g_dbus_proxy_get_interface(proxy);
 
@@ -637,6 +652,27 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 		print_iter(str, name, iter);
 		g_free(str);
+	} else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
+		DBusMessageIter addr_iter;
+		char *str;
+
+		ctrl = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
+		if (!ctrl)
+			return;
+
+		if (g_dbus_proxy_get_property(ctrl->proxy, "Address",
+						&addr_iter) == TRUE) {
+			const char *address;
+
+			dbus_message_iter_get_basic(&addr_iter, &address);
+			str = g_strdup_printf("[" COLORED_CHG
+						"] Controller %s ",
+						address);
+		} else
+			str = g_strdup("");
+
+		print_iter(str, name, iter);
+		g_free(str);
 	} else if (proxy == default_attr) {
 		char *str;
 
-- 
2.13.3

