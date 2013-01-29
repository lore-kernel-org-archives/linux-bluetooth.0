Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] neard: Fix memory leak on registering as agent
Date: Tue, 29 Jan 2013 09:54:31 +0100
Message-ID: <1359449671-14584-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1359449671-14584-1-git-send-email-szymon.janc@tieto.com>
References: <1359449671-14584-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message reference was not dropped in register_agent. This fix following
memory leak reported by valgrind:

454 (184 direct, 270 indirect) bytes in 1 blocks are definitely lost in loss record 207 of 220
   at 0x4C29DB4: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x513DCF2: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514222E: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5149F46: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514A070: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514AA63: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514B0A5: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5149E0C: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5134D24: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5136088: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5135643: dbus_connection_send_with_reply_and_block (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5130C93: dbus_bus_register (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)

102 bytes in 1 blocks are indirectly lost in loss record 154 of 220
   at 0x4C2B7B2: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x514F02F: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514F0DD: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514F239: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514DE0A: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514E3D3: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x513C138: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x513FF4D: dbus_message_iter_append_basic (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5141790: dbus_message_new_error (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5135C70: dbus_connection_dispatch (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x40A747: message_dispatch (mainloop.c:76)
   by 0x4E7A91A: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)

168 bytes in 1 blocks are indirectly lost in loss record 185 of 220
   at 0x4C2B7B2: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x514F02F: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514F0DD: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514F239: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x513A3B3: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514228F: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5149F46: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514A070: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514AA63: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x514B0A5: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5149E0C: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
   by 0x5134D24: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.5.8)
---
 plugins/neard.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/neard.c b/plugins/neard.c
index a68500a..b0150e9 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -121,12 +121,15 @@ static void register_agent(void)
 
 	if (!dbus_connection_send_with_reply(btd_get_dbus_connection(),
 							message, &call, -1)) {
+		dbus_message_unref(message);
 		error("D-Bus send failed");
 		return;
 	}
 
 	dbus_pending_call_set_notify(call, register_agent_cb, NULL, NULL);
 	dbus_pending_call_unref(call);
+
+	dbus_message_unref(message);
 }
 
 static void unregister_agent(void)
-- 
1.8.1.1

