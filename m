Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] src/agent: Fix busy errors after a time out
Date: Tue, 28 Oct 2014 13:10:19 +0200
Message-Id: <1414494619-8008-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a request times out it should still be cancelled properly so the
agent process receives a Cancel and the request is properly removed.
---
 src/agent.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/agent.c b/src/agent.c
index 9ab1c8b..97daf71 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -350,6 +350,7 @@ static void simple_agent_reply(DBusPendingCall *call, void *user_data)
 
 		if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY)) {
 			error("Timed out waiting for reply from agent");
+			agent_cancel(agent);
 			dbus_message_unref(message);
 			dbus_error_free(&err);
 			agent_unref(agent);
-- 
1.9.3

