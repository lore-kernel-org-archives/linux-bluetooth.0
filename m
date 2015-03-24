Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] gdbus: Make GDBusClient work without ObjectManager
Date: Tue, 24 Mar 2015 14:10:31 +0200
Message-Id: <1427199032-23492-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes GDBusClient work normally without ObjectManager.
---
 gdbus/client.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index fe0c0db..48711ae 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -1111,7 +1111,8 @@ static void get_managed_objects(GDBusClient *client)
 	if (!client->connected)
 		return;
 
-	if (!client->proxy_added && !client->proxy_removed) {
+	if ((!client->proxy_added && !client->proxy_removed) ||
+							!client->root_path) {
 		refresh_properties(client);
 		return;
 	}
@@ -1212,7 +1213,7 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
 	GDBusClient *client;
 	unsigned int i;
 
-	if (!connection || !service || !root_path)
+	if (!connection || !service)
 		return NULL;
 
 	client = g_try_new0(GDBusClient, 1);
@@ -1238,6 +1239,10 @@ GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
 						service_connect,
 						service_disconnect,
 						client, NULL);
+
+	if (!root_path)
+		return g_dbus_client_ref(client);
+
 	client->added_watch = g_dbus_add_signal_watch(connection, service,
 						client->root_path,
 						DBUS_INTERFACE_OBJECT_MANAGER,
-- 
2.1.0

