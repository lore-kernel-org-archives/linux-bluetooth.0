Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] agent: Allow to stack default agents
Date: Mon, 28 Apr 2014 16:27:15 +0200
Message-Id: <1398695235-19682-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no API for notifying agent that it is no longer default one.
This can lead to situation when ie. console agent (bluetoothctl) is
set as default leaving UI agent unfunctional after bluetoothctl exited.

This patch adds stacking of default agents in case more then one agent
requested being default.
---
 src/agent.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 4a2f606..e12bb39 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -46,6 +46,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "agent.h"
+#include "shared/queue.h"
 
 #define IO_CAPABILITY_DISPLAYONLY	0x00
 #define IO_CAPABILITY_DISPLAYYESNO	0x01
@@ -58,7 +59,7 @@
 #define AGENT_INTERFACE "org.bluez.Agent1"
 
 static GHashTable *agent_list;
-static struct agent *default_agent = NULL;
+struct queue *default_agents = NULL;
 
 typedef enum {
 	AGENT_REQUEST_PASSKEY,
@@ -152,18 +153,38 @@ static void set_io_cap(struct btd_adapter *adapter, gpointer user_data)
 	adapter_set_io_capability(adapter, io_cap);
 }
 
-static void set_default_agent(struct agent *agent)
+static bool add_default_agent(struct agent *agent)
 {
-	if (default_agent == agent)
+	if (queue_peek_head(default_agents) == agent)
+		return true;
+
+	queue_remove(default_agents, agent);
+
+	if (!queue_push_head(default_agents, agent))
+		return false;
+
+	DBG("Default agent set to %s %s", agent->owner, agent->path);
+
+	adapter_foreach(set_io_cap, agent);
+
+	return true;
+}
+
+static void remove_default_agent(struct agent *agent)
+{
+	if (queue_peek_head(default_agents) != agent) {
+		queue_remove(default_agents, agent);
 		return;
+	}
+
+	queue_remove(default_agents, agent);
 
+	agent = queue_peek_head(default_agents);
 	if (agent)
 		DBG("Default agent set to %s %s", agent->owner, agent->path);
 	else
 		DBG("Default agent cleared");
 
-	default_agent = agent;
-
 	adapter_foreach(set_io_cap, agent);
 }
 
@@ -178,8 +199,7 @@ static void agent_disconnect(DBusConnection *conn, void *user_data)
 		agent->watch = 0;
 	}
 
-	if (agent == default_agent)
-		set_default_agent(NULL);
+	remove_default_agent(agent);
 
 	g_hash_table_remove(agent_list, agent->owner);
 }
@@ -247,8 +267,8 @@ struct agent *agent_get(const char *owner)
 			return agent_ref(agent);
 	}
 
-	if (default_agent)
-		return agent_ref(default_agent);
+	if (!queue_isempty(default_agents))
+		return agent_ref(queue_peek_head(default_agents));
 
 	return NULL;
 }
@@ -889,6 +909,8 @@ static void agent_destroy(gpointer data)
 		agent_release(agent);
 	}
 
+	remove_default_agent(agent);
+
 	agent_unref(agent);
 }
 
@@ -987,7 +1009,8 @@ static DBusMessage *request_default(DBusConnection *conn, DBusMessage *msg,
 	if (g_str_equal(path, agent->path) == FALSE)
 		return btd_error_does_not_exist(msg);
 
-	set_default_agent(agent);
+	if(!add_default_agent(agent))
+		return btd_error_failed(msg, "Failed to set as default");
 
 	return dbus_message_new_method_return(msg);
 }
@@ -1008,6 +1031,8 @@ void btd_agent_init(void)
 	agent_list = g_hash_table_new_full(g_str_hash, g_str_equal,
 						NULL, agent_destroy);
 
+	default_agents = queue_new();
+
 	g_dbus_register_interface(btd_get_dbus_connection(),
 				"/org/bluez", "org.bluez.AgentManager1",
 				methods, NULL, NULL, NULL, NULL);
@@ -1018,6 +1043,6 @@ void btd_agent_cleanup(void)
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 				"/org/bluez", "org.bluez.AgentManager1");
 
-	set_default_agent(NULL);
 	g_hash_table_destroy(agent_list);
+	queue_destroy(default_agents, NULL);
 }
-- 
1.9.1

