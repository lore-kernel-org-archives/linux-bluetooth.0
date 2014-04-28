Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH RESEND BlueZ 1/2] client: Add 'auto' parameter to agent command
Date: Mon, 28 Apr 2014 12:57:01 +0300
Message-Id: <1398679022-13863-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds 'auto' parameter to agent command which auto accepts requests
whenever possible.
---
 client/agent.c | 14 +++++++++++++-
 client/agent.h |  2 +-
 client/main.c  | 29 +++++++++++++++++------------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 2d9dffd..81526a1 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -27,6 +27,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <readline/readline.h>
 #include <gdbus.h>
 
@@ -40,6 +41,7 @@
 
 static gboolean agent_registered = FALSE;
 static const char *agent_capability = NULL;
+static bool agent_auto_accept = false;
 static DBusMessage *pending_message = NULL;
 static char *agent_saved_prompt = NULL;
 static int agent_saved_point = 0;
@@ -259,6 +261,9 @@ static DBusMessage *request_confirmation(DBusConnection *conn,
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 				DBUS_TYPE_UINT32, &passkey, DBUS_TYPE_INVALID);
 
+	if (agent_auto_accept)
+		return dbus_message_new_method_return(msg);
+
 	str = g_strdup_printf("Confirm passkey %06u (yes/no): ", passkey);
 	agent_prompt(str);
 	g_free(str);
@@ -278,6 +283,9 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 							DBUS_TYPE_INVALID);
 
+	if (agent_auto_accept)
+		return dbus_message_new_method_return(msg);
+
 	agent_prompt("Accept pairing (yes/no): ");
 
 	pending_message = dbus_message_ref(msg);
@@ -296,6 +304,9 @@ static DBusMessage *authorize_service(DBusConnection *conn,
 	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
 				DBUS_TYPE_STRING, &uuid, DBUS_TYPE_INVALID);
 
+	if (agent_auto_accept)
+		return dbus_message_new_method_return(msg);
+
 	str = g_strdup_printf("Authorize service %s (yes/no): ", uuid);
 	agent_prompt(str);
 	g_free(str);
@@ -375,7 +386,7 @@ static void register_agent_reply(DBusMessage *message, void *user_data)
 }
 
 void agent_register(DBusConnection *conn, GDBusProxy *manager,
-						const char *capability)
+				const char *capability, bool auto_accept)
 
 {
 	if (agent_registered == TRUE) {
@@ -401,6 +412,7 @@ void agent_register(DBusConnection *conn, GDBusProxy *manager,
 	}
 
 	agent_capability = NULL;
+	agent_auto_accept = auto_accept;
 }
 
 static void unregister_agent_setup(DBusMessageIter *iter, void *user_data)
diff --git a/client/agent.h b/client/agent.h
index 0fbe8e5..467afb0 100644
--- a/client/agent.h
+++ b/client/agent.h
@@ -22,7 +22,7 @@
  */
 
 void agent_register(DBusConnection *conn, GDBusProxy *manager,
-						const char *capability);
+				const char *capability, bool auto_accept);
 void agent_unregister(DBusConnection *conn, GDBusProxy *manager);
 void agent_default(DBusConnection *conn, GDBusProxy *manager);
 
diff --git a/client/main.c b/client/main.c
index 5a9d41a..bce678a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -54,13 +54,15 @@ static GMainLoop *main_loop;
 static DBusConnection *dbus_conn;
 
 static GDBusProxy *agent_manager;
-static char *auto_register_agent = NULL;
+static char *agent_capability = NULL;
+static bool agent_auto_accept = false;
 
 static GDBusProxy *default_ctrl;
 static GList *ctrl_list;
 static GList *dev_list;
 
 static const char * const agent_arguments[] = {
+	"auto",
 	"on",
 	"off",
 	"DisplayOnly",
@@ -305,9 +307,10 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 		if (!agent_manager) {
 			agent_manager = proxy;
 
-			if (auto_register_agent)
+			if (agent_capability)
 				agent_register(dbus_conn, agent_manager,
-							auto_register_agent);
+							agent_capability,
+							agent_auto_accept);
 		}
 	}
 }
@@ -455,7 +458,8 @@ static gboolean parse_argument_agent(const char *arg, dbus_bool_t *value,
 		return FALSE;
 	}
 
-	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
+	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0 ||
+						strcmp(arg, "auto") == 0) {
 		*value = TRUE;
 		*capability = "";
 		return TRUE;
@@ -701,17 +705,18 @@ static void cmd_agent(const char *arg)
 		return;
 
 	if (enable == TRUE) {
-		g_free(auto_register_agent);
-		auto_register_agent = g_strdup(capability);
+		g_free(agent_capability);
+		agent_capability = g_strdup(capability);
+		agent_auto_accept = strcmp(arg, "auto") == 0 ? true : false;
 
 		if (agent_manager)
 			agent_register(dbus_conn, agent_manager,
-						auto_register_agent);
+					agent_capability, agent_auto_accept);
 		else
 			rl_printf("Agent registration enabled\n");
 	} else {
-		g_free(auto_register_agent);
-		auto_register_agent = NULL;
+		g_free(agent_capability);
+		agent_capability = NULL;
 
 		if (agent_manager)
 			agent_unregister(dbus_conn, agent_manager);
@@ -1445,9 +1450,9 @@ static gboolean parse_agent(const char *key, const char *value,
 					gpointer user_data, GError **error)
 {
 	if (value)
-		auto_register_agent = g_strdup(value);
+		agent_capability = g_strdup(value);
 	else
-		auto_register_agent = g_strdup("");
+		agent_capability = g_strdup("");
 
 	return TRUE;
 }
@@ -1524,7 +1529,7 @@ int main(int argc, char *argv[])
 	g_list_free_full(ctrl_list, proxy_leak);
 	g_list_free_full(dev_list, proxy_leak);
 
-	g_free(auto_register_agent);
+	g_free(agent_capability);
 
 	return 0;
 }
-- 
1.9.0

