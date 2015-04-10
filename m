Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/9] unit/test-gdbus-client: Fix test client_no_object_manager
Date: Fri, 10 Apr 2015 17:05:59 +0300
Message-Id: <1428674761-24609-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
References: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This test creates a second connection without using the one created by
create_context and doesn't disconnect making test client_force_disconnect
fail.
---
 unit/test-gdbus-client.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 5d8bbf2..51cf8b4 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -811,7 +811,6 @@ static void client_proxy_removed(const void *data)
 static void client_no_object_manager(const void *data)
 {
 	struct context *context = create_context();
-	DBusConnection *conn;
 	DBusMessageIter iter;
 	static const GDBusPropertyTable string_properties[] = {
 		{ "String", "s", get_string, set_string, string_exists },
@@ -821,25 +820,22 @@ static void client_no_object_manager(const void *data)
 	if (context == NULL)
 		return;
 
-	conn = g_dbus_setup_private(DBUS_BUS_SESSION, SERVICE_NAME1, NULL);
-	g_assert(conn != NULL);
-
 	context->data = g_strdup("value");
 
-	g_dbus_register_interface(conn,
-				SERVICE_PATH, SERVICE_NAME1,
+	g_dbus_register_interface(context->dbus_conn,
+				SERVICE_PATH, SERVICE_NAME,
 				methods, signals, string_properties,
 				context, NULL);
 
 	context->dbus_client = g_dbus_client_new_full(context->dbus_conn,
-						SERVICE_NAME1, SERVICE_PATH,
+						SERVICE_NAME, SERVICE_PATH,
 						NULL);
 
 	g_dbus_client_set_disconnect_watch(context->dbus_client,
 						disconnect_handler, context);
 
 	context->proxy = g_dbus_proxy_new(context->dbus_client, SERVICE_PATH,
-								SERVICE_NAME1);
+								SERVICE_NAME);
 
 	g_dbus_client_set_proxy_handlers(context->dbus_client, proxy_get_string,
 						NULL, NULL, context);
-- 
2.1.0

