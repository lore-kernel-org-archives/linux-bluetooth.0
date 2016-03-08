Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] gdbus/client: Use g_dbus_send_message if callback is not set
Date: Tue,  8 Mar 2016 15:18:50 +0200
Message-Id: <1457443131-17895-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the user don't set a function it means it doesn't care about the reply
so g_dbus_send_message can be used.
---
 gdbus/client.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 068e778..a011e19 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -853,28 +853,30 @@ gboolean g_dbus_proxy_method_call(GDBusProxy *proxy, const char *method,
 	if (client == NULL)
 		return FALSE;
 
-	data = g_try_new0(struct method_call_data, 1);
-	if (data == NULL)
-		return FALSE;
-
-	data->function = function;
-	data->user_data = user_data;
-	data->destroy = destroy;
-
 	msg = dbus_message_new_method_call(client->service_name,
 				proxy->obj_path, proxy->interface, method);
-	if (msg == NULL) {
-		g_free(data);
+	if (msg == NULL)
 		return FALSE;
-	}
 
 	if (setup) {
 		DBusMessageIter iter;
 
 		dbus_message_iter_init_append(msg, &iter);
-		setup(&iter, data->user_data);
+		setup(&iter, user_data);
 	}
 
+	if (!function)
+		return g_dbus_send_message(client->dbus_conn, msg);
+
+	data = g_try_new0(struct method_call_data, 1);
+	if (data == NULL)
+		return FALSE;
+
+	data->function = function;
+	data->user_data = user_data;
+	data->destroy = destroy;
+
+
 	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
 					&call, METHOD_CALL_TIMEOUT) == FALSE) {
 		dbus_message_unref(msg);
-- 
2.5.0

