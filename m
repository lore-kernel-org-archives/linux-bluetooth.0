Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/10] audio: Fix not freeing gateway agent data on exit
Date: Mon,  1 Oct 2012 20:53:35 +0300
Message-Id: <1349114021-19067-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349114021-19067-1-git-send-email-luiz.dentz@gmail.com>
References: <1349114021-19067-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

434 (168 direct, 266 indirect) bytes in 7 blocks are definitely lost in loss record 322 of 338
   at 0x4A06F18: calloc (vg_replace_malloc.c:566)
   by 0x4C802C6: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x126C0C: register_agent (gateway.c:673)
   by 0x122960: process_message.isra.0 (object.c:197)
   by 0x4F70684: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x4F6290C: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x120FA7: message_dispatch (mainloop.c:76)
   by 0x4C7B22A: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C7A694: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C7A9C7: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C7ADC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x120671: main (main.c:551)
---
 audio/gateway.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index fe17284..cab32a1 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -110,6 +110,8 @@ static void agent_free(struct hf_agent *agent)
 	if (!agent)
 		return;
 
+	g_dbus_remove_watch(agent->watch);
+
 	g_free(agent->name);
 	g_free(agent->path);
 	g_free(agent);
@@ -704,8 +706,6 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 	if (strcmp(gw->agent->path, path) != 0)
 		return btd_error_does_not_exist(msg);
 
-	g_dbus_remove_watch(gw->agent->watch);
-
 	agent_free(gw->agent);
 	gw->agent = NULL;
 
@@ -741,6 +741,9 @@ static void path_unregister(void *data)
 
 	gateway_close(dev);
 
+	if (dev->gateway->agent)
+		agent_free(dev->gateway->agent);
+
 	g_free(dev->gateway);
 	dev->gateway = NULL;
 }
-- 
1.7.11.4

