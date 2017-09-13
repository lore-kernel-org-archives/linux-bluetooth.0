Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH v3] client: Fix default_ctrl change when new adapter is found
Date: Wed, 13 Sep 2017 00:36:27 -0700
Message-Id: <20170913073627.59799-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When another adapter is found, the default adapter would be changed, which is not expected. Default adapter can only be changed by select command.
---
 client/main.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/client/main.c b/client/main.c
index 75696c2c1..e6737b961 100644
--- a/client/main.c
+++ b/client/main.c
@@ -148,10 +148,8 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	printf("\r");
 	rl_on_new_line();
 	rl_redisplay();
-
 	g_list_free_full(ctrl_list, proxy_leak);
 	ctrl_list = NULL;
-
 	default_ctrl = NULL;
 }
 
@@ -521,15 +519,36 @@ static void device_added(GDBusProxy *proxy)
 
 static void adapter_added(GDBusProxy *proxy)
 {
-	default_ctrl = g_malloc0(sizeof(struct adapter));
-	default_ctrl->proxy = proxy;
-	ctrl_list = g_list_append(ctrl_list, default_ctrl);
+	struct adapter *adapter = g_malloc0(sizeof(struct adapter));
+
+	adapter->proxy = proxy;
+	ctrl_list = g_list_append(ctrl_list, adapter);
+
+	if (!default_ctrl)
+		default_ctrl = adapter;
+
 	print_adapter(proxy, COLORED_NEW);
 }
 
+static int match_proxy(const void *a, const void *b)
+{
+	GDBusProxy *proxy1 = (void *) a;
+	GDBusProxy *proxy2 = (void *) b;
+
+	return strcmp(g_dbus_proxy_get_path(proxy1),
+				  g_dbus_proxy_get_path(proxy2));
+}
+
 static void ad_manager_added(GDBusProxy *proxy)
 {
-	default_ctrl->ad_proxy = proxy;
+	GList *list;
+
+	for (list = g_list_first(ctrl_list); list; list = g_list_next(list)) {
+		struct adapter *adapter = list->data;
+
+		if (match_proxy(proxy, adapter->proxy) == 0)
+			adapter->ad_proxy = proxy;
+	}
 }
 
 static void proxy_added(GDBusProxy *proxy, void *user_data)
-- 
2.14.1.581.gf28d330327-goog

