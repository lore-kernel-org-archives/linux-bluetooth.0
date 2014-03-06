Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 3/9] gatt: Add proxy removed handler
Date: Thu,  6 Mar 2014 10:44:21 -0300
Message-Id: <1394113467-24331-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394113467-24331-1-git-send-email-claudio.takahasi@openbossa.org>
References: <CAKT1EBfVP_aYMDFdK+vqBxOKEZh2tdfasKkEks4v5H6h-ZXerw@mail.gmail.com>
 <1394113467-24331-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/gatt-dbus.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index f8486f3..28d7f78 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -116,6 +116,19 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 							proxy_path_cmp);
 }
 
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	struct external_app *eapp = user_data;
+	const char *interface, *path;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
+
+	DBG("path %s iface %s", path, interface);
+
+	eapp->proxies = g_slist_remove(eapp->proxies, proxy);
+}
+
 static struct external_app *new_external_app(DBusConnection *conn,
 					const char *sender, const char *path)
 {
@@ -140,8 +153,8 @@ static struct external_app *new_external_app(DBusConnection *conn,
 	eapp->client = client;
 	eapp->path = g_strdup(path);
 
-	g_dbus_client_set_proxy_handlers(client, proxy_added, NULL, NULL,
-								eapp);
+	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
+								NULL, eapp);
 
 	return eapp;
 }
-- 
1.8.3.1

