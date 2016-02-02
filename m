Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anurag Biradar <biradar.a@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Anurag Biradar <biradar.a@samsung.com>
Subject: [PATCH 1/1] obex: Fix for obex crash
Date: Tue, 02 Feb 2016 17:39:37 +0530
Message-id: <1454414978-8173-1-git-send-email-biradar.a@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When MAP Connection is initiated and for some reason if mag-agent launch fails
then obexd crash.

Reason : user_data is null and while clean-up it is deferenced.

0  mas_disconnect (os=0xb8e75ad8, user_data=0x0) at obexd/plugins/mas.c:181
181	obexd/plugins/mas.c: No such file or directory.
(gdb) bt
0  mas_disconnect (os=0xb8e75ad8, user_data=0x0) at obexd/plugins/mas.c:181
1  0xb6ee10be in obex_session_destroy (os=0xb8e75ad8) at obexd/src/obex.c:1016
2  disconn_func (obex=<optimized out>, err=<optimized out>,
    user_data=0xb8e75ad8) at obexd/src/obex.c:1026
3  0xb6ed22b0 in incoming_data (io=<optimized out>, cond=<optimized out>,
    user_data=0xb8e75a10) at gobex/gobex.c:1410
4  0xb6d63f7e in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
5  0xb6d641de in ?? () from /usr/lib/libglib-2.0.so.0
6  0xb6d6446c in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
7  0xb6eceabe in main (argc=1, argv=0xbebdcd04) at obexd/src/main.c:332

bluetoothd[1395]: src/profile.c:send_new_connection() Sending New Connection owner :1.240 path /org/bluez/obex/00001132_0000_1000_8000_00805f9b34fb
obexd[1407]: obexd/plugins/bluetooth.c:profile_new_connection() device /org/bluez/hci0/dev_00_80_98_09_0E_6D
obexd[1407]: obexd/src/obex.c:obex_session_start()
obexd[1407]: obexd/src/obex.c:cmd_connect()
obexd[1407]: CONNECT(0x0), (null)(0xffffffff)
obexd[1407]: obexd/src/obex.c:cmd_connect() Selected driver: Message Access server
obexd[1407]: obexd/plugins/mas.c:mas_connect()
obexd[1407]: obexd/plugins/messages-tizen.c:messages_connect() +
obexd[1407]: obexd/plugins/messages-tizen.c:messages_connect()  Reply failed
obexd[1407]: obexd/plugins/messages-tizen.c:messages_connect() The name org.bluez.map_agent was not provided by any .service files
obexd[1407]: CONNECT(0x0), FORBIDDEN(0x43)
obexd[1407]: disconnected: Transport got disconnected
obexd[1407]: obexd/src/obex.c:obex_session_destroy()
obexd[1407]: obexd/plugins/mas.c:mas_disconnect()
---
 obexd/plugins/mas.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index ef67ec5..e2931a2 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -153,6 +153,9 @@ static void mas_disconnect(struct obex_session *os, void *user_data)
 	DBG("");
 
 	manager_unregister_session(os);
+
+	if (!mas)
+		return;
 	messages_disconnect(mas->backend_data);
 
 	mas_clean(mas);
-- 
1.7.9.5

