Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] core/agent: Set first agent as default
Date: Tue, 26 Nov 2013 17:05:10 +0200
Message-Id: <1385478310-22520-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385478310-22520-1-git-send-email-luiz.dentz@gmail.com>
References: <1385478310-22520-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sets the first agent automatically as default so systems with a
single agent should never have to bother with RequestDefaultAgent.
---
 src/agent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index 7880ba6..aa8ba33 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -930,6 +930,9 @@ static DBusMessage *register_agent(DBusConnection *conn,
 
 	DBG("agent %s", agent->owner);
 
+	if (g_hash_table_size(agent_list) == 0)
+		set_default_agent(agent);
+
 	g_hash_table_replace(agent_list, agent->owner, agent);
 
 	return dbus_message_new_method_return(msg);
-- 
1.8.3.1

