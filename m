Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH BlueZ] client: Fix default_ctrl change when new adapter is found
Date: Thu, 31 Aug 2017 20:56:15 -0700
Message-Id: <20170901035615.95402-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When another adapter is found, the default adapter would be changed,
which is not expected. Default adapter can only be changed by select
command.
---
 client/main.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/client/main.c b/client/main.c
index 75696c2c1..29b3978e1 100644
--- a/client/main.c
+++ b/client/main.c
@@ -67,6 +67,7 @@ struct adapter {
 };
 
 static struct adapter *default_ctrl;
+static struct adapter *cache_ctrl;
 static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
@@ -151,7 +152,7 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 
 	g_list_free_full(ctrl_list, proxy_leak);
 	ctrl_list = NULL;
-
+	cache_ctrl = NULL;
 	default_ctrl = NULL;
 }
 
@@ -521,15 +522,21 @@ static void device_added(GDBusProxy *proxy)
 
 static void adapter_added(GDBusProxy *proxy)
 {
-	default_ctrl = g_malloc0(sizeof(struct adapter));
-	default_ctrl->proxy = proxy;
-	ctrl_list = g_list_append(ctrl_list, default_ctrl);
+	struct adapter *adapter = g_malloc0(sizeof(struct adapter));
+
+	adapter->proxy = proxy;
+	cache_ctrl = adapter;
+	ctrl_list = g_list_append(ctrl_list, adapter);
+
+	if (!default_ctrl)
+		default_ctrl = adapter;
+
 	print_adapter(proxy, COLORED_NEW);
 }
 
 static void ad_manager_added(GDBusProxy *proxy)
 {
-	default_ctrl->ad_proxy = proxy;
+	cache_ctrl->ad_proxy = proxy;
 }
 
 static void proxy_added(GDBusProxy *proxy, void *user_data)
@@ -602,7 +609,6 @@ static void adapter_removed(GDBusProxy *proxy)
 			print_adapter(proxy, COLORED_DEL);
 
 			if (default_ctrl && default_ctrl->proxy == proxy) {
-				default_ctrl = NULL;
 				set_default_device(NULL, NULL);
 			}
 
-- 
2.14.1.581.gf28d330327-goog

