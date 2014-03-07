Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0] unit: Add test for g_dbus_client_set_ready_watch()
Date: Fri,  7 Mar 2014 10:14:32 -0300
Message-Id: <1394198072-21522-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gdbus-client.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index ee8a760..d0b6ce7 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -38,6 +38,7 @@ struct context {
 	GDBusClient *dbus_client;
 	GDBusProxy *proxy;
 	void *data;
+	gboolean client_ready;
 	guint timeout_source;
 };
 
@@ -85,6 +86,7 @@ static struct context *create_context(void)
 	dbus_connection_set_exit_on_disconnect(context->dbus_conn, FALSE);
 
 	g_dbus_attach_object_manager(context->dbus_conn);
+	context->client_ready = FALSE;
 
 	return context;
 }
@@ -964,6 +966,56 @@ static void client_force_disconnect(void)
 	destroy_context(context);
 }
 
+static void client_ready_watch(GDBusClient *client, void *user_data)
+{
+	struct context *context = user_data;
+
+	context->client_ready = TRUE;
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	struct context *context = user_data;
+
+	/*
+	 * Proxy added callback should not be called after Client ready
+	 * watch. Ready means that all objects has been reported to the
+	 * upper-layer.
+	 */
+	g_assert(context->client_ready == FALSE);
+
+	g_main_loop_quit(context->main_loop);
+}
+
+static void client_ready(void)
+{
+	struct context *context = create_context();
+	static const GDBusPropertyTable string_properties[] = {
+		{ "String", "s", get_string, set_string, string_exists },
+		{ },
+	};
+
+	if (context == NULL)
+		return;
+
+	g_dbus_register_interface(context->dbus_conn,
+				SERVICE_PATH, SERVICE_NAME,
+				methods, signals, string_properties,
+				context, NULL);
+
+	context->dbus_client = g_dbus_client_new(context->dbus_conn,
+						SERVICE_NAME, SERVICE_PATH);
+
+	g_dbus_client_set_ready_watch(context->dbus_client, client_ready_watch,
+								context);
+	g_dbus_client_set_proxy_handlers(context->dbus_client,
+						proxy_added, NULL, NULL, context);
+
+	g_main_loop_run(context->main_loop);
+
+	destroy_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -1001,5 +1053,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gdbus/client_force_disconnect",
 						client_force_disconnect);
 
+	g_test_add_func("/gdbus/client_ready", client_ready);
+
 	return g_test_run();
 }
-- 
1.8.3.1

