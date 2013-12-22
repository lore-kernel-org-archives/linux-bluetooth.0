Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/2] client: Minor code style fix
Date: Sun, 22 Dec 2013 22:24:56 +0100
Message-Id: <1387747496-20654-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1387747496-20654-1-git-send-email-szymon.janc@gmail.com>
References: <1387747496-20654-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/agent.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/client/agent.c b/client/agent.c
index b34ad77..20787bc 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -390,7 +390,6 @@ static void register_agent_reply(DBusMessage *message, void *user_data)
 
 void agent_register(DBusConnection *conn, GDBusProxy *manager,
 						const char *capability)
-
 {
 	if (agent_registered == TRUE) {
 		rl_printf("Agent is already registered\n");
-- 
1.8.5.2

