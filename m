Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Atul Rai <a.rai@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@samsung.com,
        Atul Rai <a.rai@samsung.com>
Subject: [PATCH] Mesh: Close net session on device disconnection
Date: Fri, 16 Mar 2018 13:11:57 +0530
Message-id: <1521186117-12216-1-git-send-email-a.rai@samsung.com>
References: <CGME20180316074208epcas2p22e43ea7190d2ce88a5cf952269c8939a@epcas2p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On device disconnection, net session is not closed. On next
attempt to provision/connect a device, net session proxy is
not updated by net_session_open() as proxy_in is not NULL.
This causes meshctl to use invalid proxy resulting in below
crash.

0  strlen () at ../sysdeps/x86_64/strlen.S:106
1  0x00007f3a3c8b1ac4 in _dbus_string_init_const () from libdbus-1.so.3
2  0x00007f3a3c89ed15 in ?? () from libdbus-1.so.3
3  0x00007f3a3c89fba0 in dbus_message_new_method_call () from libdbus-1.so.3
4  0x0000000000419880 in g_dbus_proxy_method_call at gdbus/client.c:997
5  0x000000000040ab9d in mesh_gatt_write at mesh/gatt.c:347
6  0x000000000040d761 in send_mesh_pkt at mesh/net.c:1227
7  send_seg at mesh/net.c:1325
8  0x000000000040fa60 in net_access_layer_send at mesh/net.c:2163
9  0x0000000000413c74 in config_send at mesh/config-client.c:418
10 0x0000000000414886 in cmd_composition_get at mesh/config-client.c:470
11 0x000000000041ffd9 in cmd_exec at src/shared/shell.c:356
12 menu_exec at src/shared/shell.c:383
13 0x00000000004203a5 in shell_exec at src/shared/shell.c:426
14 0x0000000000420d24 in rl_handler (input=0x2259aa0 "composition-get ")
at src/shared/shell.c:571
15 0x00007f3a3c45d6f5 in rl_callback_read_char () from libreadline.so.6
16 0x0000000000420229 in input_read at src/shared/shell.c:1034
17 0x0000000000421655 in watch_callback at src/shared/io-glib.c:170
18 0x00007f3a3cb1a04a in g_main_context_dispatch () from libglib-2.0.so.0
19 0x00007f3a3cb1a3f0 in ?? () from libglib-2.0.so.0
20 0x00007f3a3cb1a712 in g_main_loop_run () from libglib-2.0.so.0
21 0x0000000000421bf5 in mainloop_run () at src/shared/mainloop-glib.c:73
22 0x000000000042115a in bt_shell_run () at src/shared/shell.c:962
23 0x0000000000405c5d in main at mesh/main.c:1992
---
 mesh/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 7c72f49..d991c9f 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -949,7 +949,6 @@ static void mesh_session_setup(GDBusProxy *proxy)
 		data_out_notify(connection.data_out, true, notify_prov_out_cb);
 
 	} else if (connection.type != CONN_TYPE_INVALID){
-
 		connection.data_in = get_characteristic(proxy,
 						MESH_PROXY_DATA_IN_UUID_STR);
 		if (!connection.data_in)
@@ -1202,8 +1201,10 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 				if (connected && connection.device == NULL)
 					set_connected_device(proxy);
 				else if (!connected &&
-						connection.device == proxy)
+						connection.device == proxy) {
+					net_session_close(connection.data_in);
 					set_connected_device(NULL);
+				}
 			} else if ((strcmp(name, "Alias") == 0) &&
 						connection.device == proxy) {
 				/* Re-generate prompt */
-- 
2.7.4

