Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gdbus: Force service to start if proxy is created while not connected
Date: Tue, 28 Nov 2017 12:57:46 +0200
Message-Id: <20171128105746.13000-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Because GetAll is no longer send right away the service may never be
started.
---
 gdbus/client.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 9b0f7f7a9..3d7105ef8 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -484,6 +484,28 @@ static void proxy_remove(GDBusClient *client, const char *path,
 	}
 }
 
+static void start_service(GDBusProxy *proxy)
+{
+	GDBusClient *client = proxy->client;
+	const char *service_name = client->service_name;
+	dbus_uint32_t flags = 0;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(DBUS_SERVICE_DBUS, DBUS_PATH_DBUS,
+						DBUS_INTERFACE_DBUS,
+						"StartServiceByName");
+	if (msg == NULL)
+		return;
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &service_name,
+					DBUS_TYPE_UINT32, &flags,
+					DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(client->dbus_conn, msg);
+	dbus_message_unref(msg);
+	return;
+}
+
 GDBusProxy *g_dbus_proxy_new(GDBusClient *client, const char *path,
 							const char *interface)
 {
@@ -500,7 +522,13 @@ GDBusProxy *g_dbus_proxy_new(GDBusClient *client, const char *path,
 	if (proxy == NULL)
 		return NULL;
 
-	if (client->connected && !client->get_objects_call)
+	if (!client->connected) {
+		/* Force service to start */
+		start_service(proxy);
+		return g_dbus_proxy_ref(proxy);
+	}
+
+	if (!client->get_objects_call)
 		get_all_properties(proxy);
 
 	return g_dbus_proxy_ref(proxy);
-- 
2.13.6

