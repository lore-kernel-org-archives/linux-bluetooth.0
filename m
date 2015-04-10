Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] client: Add wait-controller option
Date: Fri, 10 Apr 2015 12:06:20 +0200
Message-Id: <1428660380-7152-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add new wait-controller option that allows to delay input processing
until first adapter is reported. This should be usefull for scripting
where caller will not have to do addition D-Bus work before calling
eg. 'power on'.
---
 client/main.c | 74 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/client/main.c b/client/main.c
index bb67f3d..374ed6a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -315,6 +315,38 @@ static gboolean service_is_child(GDBusProxy *service)
 	return FALSE;
 }
 
+static gboolean input_handler(GIOChannel *channel, GIOCondition condition,
+							gpointer user_data)
+{
+	if (condition & G_IO_IN) {
+		rl_callback_read_char();
+		return TRUE;
+	}
+
+	if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		g_main_loop_quit(main_loop);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static guint setup_standard_input(void)
+{
+	GIOChannel *channel;
+	guint source;
+
+	channel = g_io_channel_unix_new(fileno(stdin));
+
+	source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				input_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -333,6 +365,10 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		if (!default_ctrl)
 			default_ctrl = proxy;
 
+		/* input was not initialized due to wait option, do it now */
+		if (!input)
+			input = setup_standard_input();
+
 		print_adapter(proxy, COLORED_NEW);
 	} else if (!strcmp(interface, "org.bluez.AgentManager1")) {
 		if (!agent_manager) {
@@ -1623,38 +1659,6 @@ done:
 	free(input);
 }
 
-static gboolean input_handler(GIOChannel *channel, GIOCondition condition,
-							gpointer user_data)
-{
-	if (condition & G_IO_IN) {
-		rl_callback_read_char();
-		return TRUE;
-	}
-
-	if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	return TRUE;
-}
-
-static guint setup_standard_input(void)
-{
-	GIOChannel *channel;
-	guint source;
-
-	channel = g_io_channel_unix_new(fileno(stdin));
-
-	source = g_io_add_watch(channel,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				input_handler, NULL);
-
-	g_io_channel_unref(channel);
-
-	return source;
-}
-
 static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
 							gpointer user_data)
 {
@@ -1742,6 +1746,7 @@ static guint setup_signalfd(void)
 }
 
 static gboolean option_version = FALSE;
+static gboolean option_input_wait = FALSE;
 
 static gboolean parse_agent(const char *key, const char *value,
 					gpointer user_data, GError **error)
@@ -1760,6 +1765,8 @@ static GOptionEntry options[] = {
 	{ "agent", 'a', G_OPTION_FLAG_OPTIONAL_ARG,
 				G_OPTION_ARG_CALLBACK, parse_agent,
 				"Register agent handler", "CAPABILITY" },
+	{ "wait-controller", 'w', 0, G_OPTION_ARG_NONE, &option_input_wait,
+				"Wait for controller before processing input" },
 	{ NULL },
 };
 
@@ -1767,6 +1774,9 @@ static void client_ready(GDBusClient *client, void *user_data)
 {
 	guint *input = user_data;
 
+	if (option_input_wait)
+		return;
+
 	*input = setup_standard_input();
 }
 
-- 
1.9.3

