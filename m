Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 3/4] tools/obexctl: Fix retrieving non-existent
 iterator
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <8df3e799-c7a3-3f49-32dd-2e5c4cabc9ff@jp.fujitsu.com>
Message-ID: <5c6c0bd4-3680-deb3-23af-32f54d5217cd@jp.fujitsu.com>
Date: Fri, 9 Feb 2018 18:12:15 +0900
MIME-Version: 1.0
In-Reply-To: <8df3e799-c7a3-3f49-32dd-2e5c4cabc9ff@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If transfer is completed with one time file transfer,
transfer_property_changed() is called with the iter argument, which is
NULL, as below:

  #0  transfer_property_changed (proxy=<optimized out>, name=<optimized out>, iter=0x0, user_data=0x5555557b9060) at tools/obexctl.c:1896
  #1  0x000055555556e3cf in properties_changed (conn=<optimized out>, msg=<optimized out>, user_data=0x5555557c8300) at gdbus/client.c:433
  #2  0x000055555556c830 in signal_filter (connection=0x5555557c65a0, message=0x5555557ccea0, user_data=0x5555557cdbf0) at gdbus/watch.c:407
  #3  0x000055555556c291 in message_filter (connection=0x5555557c65a0, message=0x5555557ccea0, user_data=<optimized out>) at gdbus/watch.c:557
  #4  0x00007ffff7888661 in dbus_connection_dispatch () from /lib/x86_64-linux-gnu/libdbus-1.so.3
  #5  0x000055555556b010 in message_dispatch (data=0x5555557c65a0) at gdbus/mainloop.c:72
  #6  0x00007ffff7b0be25 in g_main_context_dispatch () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
  #7  0x00007ffff7b0c1f0 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
  #8  0x00007ffff7b0c502 in g_main_loop_run () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
  #9  0x0000555555577594 in bt_shell_run () at src/shared/shell.c:833
  #10 0x000055555556516d in main (argc=<optimized out>, argv=<optimized out>) at tools/obexctl.c:2116
---
 tools/obexctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index 05bbd3e84..4e46c7541 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -1885,6 +1885,9 @@ static void transfer_property_changed(GDBusProxy *proxy, const char *name,
 	struct transfer_data *data = user_data;
 	char *str;
 
+	if (iter == NULL)
+		return;
+
 	str = proxy_description(proxy, "Transfer", COLORED_CHG);
 
 	if (strcmp(name, "Transferred") == 0) {
-- 
2.14.1

