Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: Yunhan Wang <yunhanw@google.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ v4] client: Fix default_ctrl change when new adapter is
 found
Message-ID: <ca2a0377-e617-e586-bf25-5a0df4fcc677@jp.fujitsu.com>
Date: Thu, 14 Sep 2017 11:50:49 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since 4e111f3448a126786f3620be1b5ce969456edc65, when another adapter is
found, the default adapter would be changed, which is not expected.
Default adapter can only be changed by select command.
---
 client/main.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

 v4: add adapter_new() which allocates memory for a new adapter.
     call find_ctrl() to find out the exist adapter.

diff --git a/client/main.c b/client/main.c
index 87eb131..2cb449f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -525,17 +525,40 @@ static void device_added(GDBusProxy *proxy)
 	}
 }
 
+static struct adapter *find_ctrl(GList *source, const char *path);
+
+static struct adapter *adapter_new(GDBusProxy *proxy)
+{
+	struct adapter *adapter = g_malloc0(sizeof(struct adapter));
+
+	ctrl_list = g_list_append(ctrl_list, adapter);
+
+	if (!default_ctrl)
+		default_ctrl = adapter;
+
+	return adapter;
+}
+
 static void adapter_added(GDBusProxy *proxy)
 {
-	default_ctrl = g_malloc0(sizeof(struct adapter));
-	default_ctrl->proxy = proxy;
-	ctrl_list = g_list_append(ctrl_list, default_ctrl);
+	struct adapter *adapter;
+	adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
+	if (!adapter)
+		adapter = adapter_new(proxy);
+
+	adapter->proxy = proxy;
+
 	print_adapter(proxy, COLORED_NEW);
 }
 
 static void ad_manager_added(GDBusProxy *proxy)
 {
-	default_ctrl->ad_proxy = proxy;
+	struct adapter *adapter;
+	adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
+	if (!adapter)
+		adapter = adapter_new(proxy);
+
+	adapter->ad_proxy = proxy;
 }
 
 static void proxy_added(GDBusProxy *proxy, void *user_data)
-- 
2.7.4

