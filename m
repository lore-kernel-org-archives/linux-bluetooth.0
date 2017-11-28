Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ] obexd: Fix crash when canceling without agent
Message-ID: <3025382d-97b8-b4ca-2595-327060506f5b@jp.fujitsu.com>
Date: Tue, 28 Nov 2017 15:42:06 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When obexd is started with the option auto-accept or the agent is killed
after starting to transfer a file, obexd crashes due to cancellation of
the transfer from a client as below:

  Process terminating with default action of signal 11 (SIGSEGV)
   Access not within mapped region at address 0x0
     at 0x158A40: transfer_cancel (manager.c:272)
     by 0x18A5D2: process_message.isra.4 (object.c:259)
     by 0x18AE44: generic_message (object.c:1079)
     by 0x5290FD2: ??? (in /lib/x86_64-linux-gnu/libdbus-1.so.3.14.13)
     by 0x5282623: dbus_connection_dispatch (in /lib/x86_64-linux-gnu/libdbus-1.so.3.14.13)
     by 0x184DBF: message_dispatch (mainloop.c:72)
     by 0x5505E24: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
     by 0x55061EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
     by 0x5506501: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
     by 0x137902: main (main.c:322)
---
 obexd/src/manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index f84384ae4..78b138c85 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -265,6 +265,9 @@ static DBusMessage *transfer_cancel(DBusConnection *connection,
 	struct obex_session *os = transfer->session;
 	const char *sender;
 
+	if (!agent)
+		return agent_does_not_exist(msg);
+
 	if (!os)
 		return invalid_args(msg);
 
-- 
2.14.1

