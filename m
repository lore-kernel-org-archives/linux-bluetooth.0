Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ] agent: Fix segmentation fault
Date: Tue, 29 May 2012 19:32:06 -0300
Message-Id: <1338330726-11517-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a segmentation fault when the agent leaves the bus
and there is a request passkey pending.

bluetoothd[3137]: src/agent.c:agent_exited() Agent exited without
calling Unregister
==3137== Invalid read of size 8
==3137==    at 0x4489E7: device_get_adapter (device.c:2197)
==3137==    by 0x448C69: passkey_cb (device.c:2757)
==3137==    by 0x43FA47: agent_free (agent.c:168)
==3137==    by 0x40A738: service_filter (watch.c:477)
==3137==    by 0x40A450: message_filter (watch.c:527)
==3137==    by 0x516451B: dbus_connection_dispatch (in
/usr/lib64/libdbus-1.so.3.5.8)
==3137==    by 0x409387: message_dispatch (mainloop.c:76)
==3137==    by 0x4E7986A: g_timeout_dispatch (in
/usr/lib64/libglib-2.0.so.0.3000.2)
==3137==    by 0x4E78091: g_main_context_dispatch (in
/usr/lib64/libglib-2.0.so.0.3000.2)
==3137==    by 0x4E78887: g_main_context_iterate.clone.6 (in
/usr/lib64/libglib-2.0.so.0.3000.2)
==3137==    by 0x4E78DD9: g_main_loop_run (in
/usr/lib64/libglib-2.0.so.0.3000.2)
==3137==    by 0x431AA6: main (main.c:542)
==3137==  Address 0xe818247c89102594 is not stack'd, malloc'd or
(recently) free'd
---
 src/agent.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index 579b03e..e542425 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -153,6 +153,7 @@ void agent_free(struct agent *agent)
 	if (agent->request) {
 		DBusError err;
 		agent_pincode_cb pincode_cb;
+		agent_passkey_cb passkey_cb;
 		agent_cb cb;
 
 		dbus_error_init(&err);
@@ -163,6 +164,10 @@ void agent_free(struct agent *agent)
 			pincode_cb = agent->request->cb;
 			pincode_cb(agent, &err, NULL, agent->request->user_data);
 			break;
+		case AGENT_REQUEST_PASSKEY:
+			passkey_cb = agent->request->cb;
+			passkey_cb(agent, &err, 0, agent->request->user_data);
+			break;
 		default:
 			cb = agent->request->cb;
 			cb(agent, &err, agent->request->user_data);
-- 
1.7.9.5

