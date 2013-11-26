Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] client: Fix not releasing agent if bluetoothd exit without calling Release
Date: Tue, 26 Nov 2013 17:05:09 +0200
Message-Id: <1385478310-22520-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385478310-22520-1-git-send-email-luiz.dentz@gmail.com>
References: <1385478310-22520-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If AgentManager1 disappear the agent should auto release itself
otherwise next time AgentManager1 appears bluetoothctl wont register
the agent again.
---
 client/agent.c | 26 ++++++++++++++++----------
 client/main.c  |  5 ++++-
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 81526a1..f074d82 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -156,14 +156,11 @@ dbus_bool_t agent_input(DBusConnection *conn, const char *input)
 	return TRUE;
 }
 
-static DBusMessage *release_agent(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
+static void agent_release(DBusConnection *conn)
 {
 	agent_registered = FALSE;
 	agent_capability = NULL;
 
-	rl_printf("Agent released\n");
-
 	if (pending_message) {
 		dbus_message_unref(pending_message);
 		pending_message = NULL;
@@ -172,6 +169,14 @@ static DBusMessage *release_agent(DBusConnection *conn,
 	agent_release_prompt();
 
 	g_dbus_unregister_interface(conn, AGENT_PATH, AGENT_INTERFACE);
+}
+
+static DBusMessage *release_agent(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	rl_printf("Agent released\n");
+
+	agent_release(conn);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -430,13 +435,8 @@ static void unregister_agent_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
-		agent_registered = FALSE;
-		agent_capability = NULL;
 		rl_printf("Agent unregistered\n");
-
-		if (g_dbus_unregister_interface(conn, AGENT_PATH,
-						AGENT_INTERFACE) == FALSE)
-			rl_printf("Failed to unregister agent object\n");
+		agent_release(conn);
 	} else {
 		rl_printf("Failed to unregister agent: %s\n", error.name);
 		dbus_error_free(&error);
@@ -450,6 +450,12 @@ void agent_unregister(DBusConnection *conn, GDBusProxy *manager)
 		return;
 	}
 
+	if (!manager) {
+		rl_printf("Agent unregistered\n");
+		agent_release(conn);
+		return;
+	}
+
 	if (g_dbus_proxy_method_call(manager, "UnregisterAgent",
 						unregister_agent_setup,
 						unregister_agent_reply,
diff --git a/client/main.c b/client/main.c
index 5639f0e..fe5f290 100644
--- a/client/main.c
+++ b/client/main.c
@@ -319,8 +319,11 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 			dev_list = NULL;
 		}
 	} else if (!strcmp(interface, "org.bluez.AgentManager1")) {
-		if (agent_manager == proxy)
+		if (agent_manager == proxy) {
 			agent_manager = NULL;
+			if (agent_capability)
+				agent_unregister(dbus_conn, NULL);
+		}
 	}
 }
 
-- 
1.8.3.1

