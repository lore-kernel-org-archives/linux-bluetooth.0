Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] core: Fix crash due to agent callback freeing the agent
Date: Mon,  9 Dec 2013 20:20:55 +0100
Message-Id: <1386616856-16140-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Similar fix was provided for simple_agent_reply in a2f5d438 but missed
pincode_reply case.

Fix following:

src/agent.c:agent_disconnect() Agent :1.48 disconnected
src/agent.c:set_default_agent() Default agent cleared
src/agent.c:agent_destroy() agent :1.48
src/agent.c:agent_unref() 0x4701c68: ref=1
Agent /org/bluez/agent replied with an error:
    org.freedesktop.DBus.Error.NoReply, Message did not receive a reply
    (timeout by message bus)
src/adapter.c:btd_adapter_pincode_reply() hci0 addr 6C:0E:0D:DB:D1:16
    pinlen 0
src/agent.c:agent_unref() 0x4701c68: ref=0
src/adapter.c:btd_adapter_pincode_reply() hci0 addr 6C:0E:0D:DB:D1:16
    pinlen 0
src/agent.c:agent_unref() 0x4701c68: ref=-1
src/adapter.c:btd_adapter_pincode_reply() hci0 addr 6C:0E:0D:DB:D1:16
    pinlen 0
src/agent.c:agent_unref() 0x4701c68: ref=-2
...
---
 src/agent.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index bcba969..4c63cb9 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -426,6 +426,9 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 	 * is only called after a reply has been received */
 	message = dbus_pending_call_steal_reply(call);
 
+	/* Protect from the callback freeing the agent */
+	agent_ref(agent);
+
 	dbus_error_init(&err);
 	if (dbus_set_error_from_message(&err, message)) {
 		error("Agent %s replied with an error: %s, %s",
@@ -465,6 +468,7 @@ done:
 	dbus_pending_call_cancel(req->call);
 	agent->request = NULL;
 	agent_request_free(req, TRUE);
+	agent_unref(agent);
 }
 
 static int pincode_request_new(struct agent_request *req, const char *device_path,
-- 
1.8.5.1

