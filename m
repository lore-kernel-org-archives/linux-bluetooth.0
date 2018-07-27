Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] agent: Make the first agent to register the default
Date: Fri, 27 Jul 2018 16:02:18 +0300
Message-Id: <20180727130218.16975-2-luiz.dentz@gmail.com>
In-Reply-To: <20180727130218.16975-1-luiz.dentz@gmail.com>
References: <20180727130218.16975-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This simplifies the handling of default agent and enforce the IO
capabilities to be set whenever there is an agent available in the
system.
---
 src/agent.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index ff44d5755..183e2f190 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -50,13 +50,6 @@
 #include "agent.h"
 #include "shared/queue.h"
 
-#define IO_CAPABILITY_DISPLAYONLY	0x00
-#define IO_CAPABILITY_DISPLAYYESNO	0x01
-#define IO_CAPABILITY_KEYBOARDONLY	0x02
-#define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
-#define IO_CAPABILITY_KEYBOARDDISPLAY	0x04
-#define IO_CAPABILITY_INVALID		0xFF
-
 #define REQUEST_TIMEOUT (60 * 1000)		/* 60 seconds */
 #define AGENT_INTERFACE "org.bluez.Agent1"
 
@@ -150,7 +143,7 @@ static void set_io_cap(struct btd_adapter *adapter, gpointer user_data)
 	if (agent)
 		io_cap = agent->capability;
 	else
-		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+		io_cap = IO_CAPABILITY_INVALID;
 
 	adapter_set_io_capability(adapter, io_cap);
 }
@@ -294,6 +287,11 @@ static struct agent *agent_create( const char *name, const char *path,
 							name, agent_disconnect,
 							agent, NULL);
 
+	if (queue_isempty(default_agents))
+		add_default_agent(agent);
+	else
+		queue_push_tail(default_agents, agent);
+
 	return agent_ref(agent);
 }
 
-- 
2.17.1

