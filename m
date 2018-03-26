Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] client: Add envs for proxies
Date: Mon, 26 Mar 2018 16:33:03 +0300
Message-Id: <20180326133304.14531-3-luiz.dentz@gmail.com>
In-Reply-To: <20180326133304.14531-1-luiz.dentz@gmail.com>
References: <20180326133304.14531-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds envs for device and adapter proxies found so other files are
able to access them.
---
 client/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/client/main.c b/client/main.c
index 584217a82..a36e932ac 100644
--- a/client/main.c
+++ b/client/main.c
@@ -456,6 +456,7 @@ static void device_added(GDBusProxy *proxy)
 
 	adapter->devices = g_list_append(adapter->devices, proxy);
 	print_device(proxy, COLORED_NEW);
+	bt_shell_set_env(g_dbus_proxy_get_path(proxy), proxy);
 
 	if (default_dev)
 		return;
@@ -494,6 +495,7 @@ static void adapter_added(GDBusProxy *proxy)
 	adapter->proxy = proxy;
 
 	print_adapter(proxy, COLORED_NEW);
+	bt_shell_set_env(g_dbus_proxy_get_path(proxy), proxy);
 }
 
 static void ad_manager_added(GDBusProxy *proxy)
@@ -561,6 +563,7 @@ static void device_removed(GDBusProxy *proxy)
 	adapter->devices = g_list_remove(adapter->devices, proxy);
 
 	print_device(proxy, COLORED_DEL);
+	bt_shell_set_env(g_dbus_proxy_get_path(proxy), NULL);
 
 	if (default_dev == proxy)
 		set_default_device(NULL, NULL);
@@ -575,6 +578,7 @@ static void adapter_removed(GDBusProxy *proxy)
 
 		if (adapter->proxy == proxy) {
 			print_adapter(proxy, COLORED_DEL);
+			bt_shell_set_env(g_dbus_proxy_get_path(proxy), NULL);
 
 			if (default_ctrl && default_ctrl->proxy == proxy) {
 				default_ctrl = NULL;
-- 
2.14.3

