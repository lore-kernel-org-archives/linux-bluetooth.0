Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] profile: Create a service for incomming connections
Date: Thu,  2 May 2013 19:29:36 -0300
Message-Id: <1367533776-3987-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When receiving an incomming connection, we need to create a btd_service
associated with that external profile.

Valgrind log:

bluetoothd[27771]: src/adapter.c:connected_callback() hci0 device 00:02:72:D6:99:69 connected eir_len 10
bluetoothd[27771]: src/profile.c:ext_confirm() incoming connect from 00:02:72:D6:99:69
bluetoothd[27771]: src/profile.c:ext_confirm() hfp_ag authorizing connection from 00:02:72:D6:99:69
bluetoothd[27771]: src/profile.c:ext_auth() Connection from 00:02:72:D6:99:69 authorized but still waiting for SDP
bluetoothd[27771]: src/profile.c:ext_svc_complete() Services resolved for 00:02:72:D6:99:69
bluetoothd[27771]: src/profile.c:ext_svc_complete() 00:02:72:D6:99:69 authorized to connect to hfp_ag
bluetoothd[27771]: src/profile.c:ext_connect() hfp_ag connected to 00:02:72:D6:99:69
==27771== Invalid read of size 4
==27771==    at 0x467720: btd_service_connecting_complete (service.c:315)
==27771==    by 0x465FD2: new_conn_reply (profile.c:775)
==27771==    by 0x515A839: complete_pending_call_and_unlock (in /usr/lib64/libdbus-1.so.3.7.3)
==27771==    by 0x515D8E2: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.3)
==27771==    by 0x40AF07: message_dispatch (mainloop.c:76)
==27771==    by 0x4E7663A: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==27771==    by 0x4E75B24: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==27771==    by 0x4E75E57: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==27771==    by 0x4E76241: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==27771==    by 0x40A73E: main (main.c:583)
==27771==  Address 0x20 is not stack'd, malloc'd or (recently) free'd
==27771==
==27771==
==27771== Process terminating with default action of signal 11 (SIGSEGV)
==27771==  Access not within mapped region at address 0x20
==27771==    at 0x467720: btd_service_connecting_complete (service.c:315)
==27771==    by 0x465FD2: new_conn_reply (profile.c:775)
==27771==    by 0x515A839: complete_pending_call_and_unlock (in /usr/lib64/libdbus-1.so.3.7.3)
==27771==    by 0x515D8E2: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.3)
==27771==    by 0x40AF07: message_dispatch (mainloop.c:76)
==27771==    by 0x4E7663A: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==27771==    by 0x4E75B24: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==27771==    by 0x4E75E57: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==27771==    by 0x4E76241: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==27771==    by 0x40A73E: main (main.c:583)
==27771==  If you believe this happened as a result of a stack
==27771==  overflow in your program's main thread (unlikely but
==27771==  possible), you can try to increase the size of the
==27771==  main thread stack using the --main-stacksize= flag.
==27771==  The main thread stack size used in this run was 8388608.
---
 src/profile.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/profile.c b/src/profile.c
index 0500983..2c35dc7 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1045,6 +1045,7 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 {
 	struct btd_device *device;
 	struct ext_io *conn;
+	struct btd_profile *profile;
 	GIOCondition cond;
 
 	conn = g_new0(struct ext_io, 1);
@@ -1052,11 +1053,14 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
 	conn->proto = server->proto;
 	conn->ext = server->ext;
 	conn->adapter = btd_adapter_ref(server->adapter);
+	profile = &server->ext->p;
 
 	device = adapter_find_device(server->adapter, dst);
 
-	if (device)
+	if (device) {
 		conn->device = btd_device_ref(device);
+		conn->service = service_create(device, profile);
+	}
 
 	cond = G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	conn->io_id = g_io_add_watch(io, cond, ext_io_disconnected, conn);
-- 
1.8.2.1

