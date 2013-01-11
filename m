Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Christian Fetzer <christian.fetzer@bmw-carit.de>
Subject: [PATCH 3/8] obexd: Fix infinite loop in ListMessages with filter "Types"
Date: Fri, 11 Jan 2013 16:55:52 +0100
Message-Id: <1357919757-10334-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Calls to ListMessages with filter 'Types' make obexd hang in an infinite loop.
This is caused by a missing dbus_message_iter_next in parse_filter_type.

0  0x00007ffff7304ca7 in dbus_message_iter_get_basic ()
   from /usr/lib/libdbus-1.so.3
1  0x0000000000434fba in parse_filter_type (iter=0x7fffffffd7d0, apparam=
    0x6987f0) at obexd/client/map.c:1086
2  parse_message_filters (iter=0x7fffffffd730, apparam=0x6987f0)
    at obexd/client/map.c:1222
3  map_list_messages (connection=<optimized out>, message=0x669ae0, user_data=
    0x698a60) at obexd/client/map.c:1273
4  0x00000000004109a1 in process_message (connection=0x662b20,
    message=<optimized out>, iface_user_data=<optimized out>,
    method=<optimized out>, method=<optimized out>) at gdbus/object.c:285
5  0x00007ffff7308e15 in ?? () from /usr/lib/libdbus-1.so.3
6  0x00007ffff72fb070 in dbus_connection_dispatch ()
   from /usr/lib/libdbus-1.so.3
7  0x000000000040e3d8 in message_dispatch (data=0x662b20)
    at gdbus/mainloop.c:76
8  0x00007ffff703d3cb in ?? () from /usr/lib/libglib-2.0.so.0
9  0x00007ffff703c845 in g_main_context_dispatch ()
   from /usr/lib/libglib-2.0.so.0
10 0x00007ffff703cb78 in ?? () from /usr/lib/libglib-2.0.so.0
11 0x00007ffff703cf72 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
12 0x000000000040df82 in main (argc=1, argv=0x7fffffffdd88)
    at obexd/src/main.c:323
---
 obexd/client/map.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 635d951..afb5f9a 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1123,6 +1123,8 @@ static GObexApparam *parse_filter_type(GObexApparam *apparam,
 			types |= 0x08; /* mms */
 		else
 			return NULL;
+
+		dbus_message_iter_next(&array);
 	}
 
 	return g_obex_apparam_set_uint8(apparam, MAP_AP_FILTERMESSAGETYPE,
-- 
1.8.1

