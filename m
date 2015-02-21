Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 02/18] gdbus: Don't refresh objects/props if disconnected
Date: Fri, 20 Feb 2015 17:56:47 -0800
Message-Id: <1424483824-27374-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1424483824-27374-1-git-send-email-armansito@chromium.org>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If g_dbus_client_set_proxy_handlers gets called from within a
proxy_removed callback, the code may end up refreshing the proxy's
properties and incorrectly access the client's proxy_list as it gets
freed. This patch fixes this, so that get_managed_objects does nothing
if it gets called during a service disconnect.
---
 gdbus/client.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index eb68a0f..8c32084 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -52,6 +52,7 @@ struct GDBusClient {
 	void *connect_data;
 	GDBusWatchFunction disconn_func;
 	gboolean connected;
+	gboolean in_disconn;
 	void *disconn_data;
 	GDBusMessageFunction signal_func;
 	void *signal_data;
@@ -1107,6 +1108,9 @@ static void get_managed_objects(GDBusClient *client)
 {
 	DBusMessage *msg;
 
+	if (client->in_disconn)
+		return;
+
 	if (!client->proxy_added && !client->proxy_removed) {
 		refresh_properties(client);
 		return;
@@ -1156,6 +1160,8 @@ static void service_disconnect(DBusConnection *conn, void *user_data)
 {
 	GDBusClient *client = user_data;
 
+	client->in_disconn = TRUE;
+
 	g_list_free_full(client->proxy_list, proxy_free);
 	client->proxy_list = NULL;
 
@@ -1163,6 +1169,8 @@ static void service_disconnect(DBusConnection *conn, void *user_data)
 		client->disconn_func(conn, client->disconn_data);
 		client->connected = FALSE;
 	}
+
+	client->in_disconn = FALSE;
 }
 
 static DBusHandlerResult message_filter(DBusConnection *connection,
-- 
2.2.0.rc0.207.ga3a616c

