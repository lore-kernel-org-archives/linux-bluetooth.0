Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH] client: Fix the selection bug of ad manager
Date: Fri, 11 Aug 2017 14:09:57 -0700
Message-Id: <20170811210957.37181-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there are multiple adapters, bluetoothctl may choose the wrong
advertising manager. In addition, select command cannot update
current advertising manager when choosing another adapter. Therefore, we
need to introduce default_ad_manager to handle the above situation,
which is similar to default_ctrl.
---
 client/main.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/client/main.c b/client/main.c
index 17de7f81f..1af6f576f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -65,11 +65,18 @@ struct adapter {
 	GList *devices;
 };
 
+struct LEAdvertisingManager {
+	GDBusProxy *proxy;
+	char * address;
+};
+
 static struct adapter *default_ctrl;
+static struct LEAdvertisingManager *default_ad_manager;
 static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
-static GDBusProxy *ad_manager;
+static GList *ad_manager_list;
 static GList *ctrl_list;
+static char *adapter_address;
 
 static guint input = 0;
 
@@ -522,7 +529,7 @@ static void device_added(GDBusProxy *proxy)
 static void adapter_added(GDBusProxy *proxy)
 {
 	struct adapter *adapter = g_malloc0(sizeof(struct adapter));
-
+	DBusMessageIter iter;
 	adapter->proxy = proxy;
 	ctrl_list = g_list_append(ctrl_list, adapter);
 
@@ -530,6 +537,22 @@ static void adapter_added(GDBusProxy *proxy)
 		default_ctrl = adapter;
 
 	print_adapter(proxy, COLORED_NEW);
+
+	if (g_dbus_proxy_get_property(adapter->proxy, "Address", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &adapter_address);
+}
+
+static void ad_manager_added(GDBusProxy *proxy)
+{
+	struct LEAdvertisingManager *ad_manager = g_malloc0(sizeof(struct LEAdvertisingManager));
+	ad_manager->proxy = proxy;
+	ad_manager->address = adapter_address;
+	ad_manager_list = g_list_append(ad_manager_list, ad_manager);
+
+	if(!default_ad_manager)
+		default_ad_manager = ad_manager;
 }
 
 static void proxy_added(GDBusProxy *proxy, void *user_data)
@@ -560,7 +583,7 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface, "org.bluez.GattManager1")) {
 		gatt_add_manager(proxy);
 	} else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
-		ad_manager = proxy;
+		ad_manager_added(proxy);
 	}
 }
 
@@ -615,6 +638,26 @@ static void adapter_removed(GDBusProxy *proxy)
 	}
 }
 
+static void ad_manager_removed(GDBusProxy *proxy)
+{
+	GList *ll;
+
+	for (ll = g_list_first(ctrl_list); ll; ll = g_list_next(ll)) {
+		struct LEAdvertisingManager *ad_manager = ll->data;
+
+		if (ad_manager->proxy == proxy) {
+			if (default_ad_manager && default_ad_manager->proxy == proxy) {
+				default_ad_manager = NULL;
+			}
+
+			ad_manager_list = g_list_remove_link(ad_manager_list, ll);
+			g_free(ad_manager);
+			g_list_free(ll);
+			return;
+		}
+	}
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -649,11 +692,9 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface, "org.bluez.GattManager1")) {
 		gatt_remove_manager(proxy);
 	} else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
-		if (ad_manager == proxy) {
-			agent_manager = NULL;
-			ad_unregister(dbus_conn, NULL);
+		ad_unregister(dbus_conn, proxy);
+		ad_manager_removed(proxy);
 		}
-	}
 }
 
 static struct adapter *find_ctrl(GList *source, const char *path)
@@ -786,6 +827,20 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
 	return NULL;
 }
 
+static struct LEAdvertisingManager *find_ad_manager_by_address(GList *source, const char *address)
+{
+	GList *list;
+
+	for (list = g_list_first(source); list; list = g_list_next(list)) {
+		struct LEAdvertisingManager *ad_manager = list->data;
+
+		if (!strcasecmp(ad_manager->address, address))
+			return ad_manager;
+	}
+
+	return NULL;
+}
+
 static GDBusProxy *find_proxy_by_address(GList *source, const char *address)
 {
 	GList *list;
@@ -922,6 +977,7 @@ static void cmd_show(const char *arg)
 static void cmd_select(const char *arg)
 {
 	struct adapter *adapter;
+	struct LEAdvertisingManager *ad_manager;
 
 	if (!arg || !strlen(arg)) {
 		rl_printf("Missing controller address argument\n");
@@ -929,6 +985,7 @@ static void cmd_select(const char *arg)
 	}
 
 	adapter = find_ctrl_by_address(ctrl_list, arg);
+
 	if (!adapter) {
 		rl_printf("Controller %s not available\n", arg);
 		return;
@@ -937,7 +994,18 @@ static void cmd_select(const char *arg)
 	if (default_ctrl && default_ctrl->proxy == adapter->proxy)
 		return;
 
+	ad_manager = find_ad_manager_by_address(ad_manager_list, arg);
+
+	if (!ad_manager) {
+		rl_printf("Advertising manager %s not available\n", arg);
+		return;
+	}
+
+	if (default_ad_manager && default_ad_manager->proxy == ad_manager->proxy)
+		return;
+
 	default_ctrl = adapter;
+	default_ad_manager = ad_manager;
 	print_adapter(adapter->proxy, NULL);
 }
 
@@ -2296,15 +2364,15 @@ static void cmd_advertise(const char *arg)
 	if (parse_argument_advertise(arg, &enable, &type) == FALSE)
 		return;
 
-	if (!ad_manager) {
+	if (!default_ad_manager || !default_ad_manager->proxy) {
 		rl_printf("LEAdvertisingManager not found\n");
 		return;
 	}
 
 	if (enable == TRUE)
-		ad_register(dbus_conn, ad_manager, type);
+		ad_register(dbus_conn, default_ad_manager->proxy, type);
 	else
-		ad_unregister(dbus_conn, ad_manager);
+		ad_unregister(dbus_conn, default_ad_manager->proxy);
 }
 
 static char *ad_generator(const char *text, int state)
-- 
2.14.0.434.g98096fd7a8-goog

