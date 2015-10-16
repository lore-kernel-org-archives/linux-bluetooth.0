Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ] src/profile: Fix segmentation fault
Date: Fri, 16 Oct 2015 20:03:47 -0300
Message-Id: <1445036627-5474-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The change that made the 'deviceinfo' profile "external" had an side
effect, now it is possible to have an external profile without 'owner'
and 'path' information. The fix considers that having an external
profile without that information is not an error.

Valgrind log:

bluetoothd[9974]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9974]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9974]: Endpoint registered: sender=:1.38 path=/MediaEndpoint/A2DPSink
bluetoothd[9974]: src/profile.c:register_profile() sender :1.38 path /Profile/HSPAGProfile
==9974== Invalid read of size 1
==9974==    at 0x65F21E0: __strcmp_sse2_unaligned (in /usr/x86_64-pc-linux-gnu/lib/libc-2.22.so)
==9974==    by 0x4E6C7E8: g_str_equal (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4600.1)
==9974==    by 0x467917: find_ext_profile (profile.c:745)
==9974==    by 0x469A8D: register_profile (profile.c:2373)
==9974==    by 0x4889C3: process_message.isra.5 (object.c:259)
==9974==    by 0x518E33E: _dbus_object_tree_dispatch_and_unlock (in /usr/x86_64-pc-linux-gnu/lib/libdbus-1.so.3.14.3)
==9974==    by 0x51805E3: dbus_connection_dispatch (in /usr/x86_64-pc-linux-gnu/lib/libdbus-1.so.3.14.3)
==9974==    by 0x4856DF: message_dispatch (mainloop.c:72)
==9974==    by 0x4E7C669: g_main_context_dispatch (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4600.1)
==9974==    by 0x4E7C9E7: g_main_context_iterate.isra.29 (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4600.1)
==9974==    by 0x4E7CD01: g_main_loop_run (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4600.1)
==9974==    by 0x40BABE: main (main.c:661)
==9974==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==9974==
==9974==
==9974== Process terminating with default action of signal 11 (SIGSEGV)
==9974==  Access not within mapped region at address 0x0
==9974==    at 0x65F21E0: __strcmp_sse2_unaligned (in /usr/x86_64-pc-linux-gnu/lib/libc-2.22.so)
==9974==    by 0x4E6C7E8: g_str_equal (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4600.1)
==9974==    by 0x467917: find_ext_profile (profile.c:745)
==9974==    by 0x469A8D: register_profile (profile.c:2373)
==9974==    by 0x4889C3: process_message.isra.5 (object.c:259)
==9974==    by 0x518E33E: _dbus_object_tree_dispatch_and_unlock (in /usr/x86_64-pc-linux-gnu/lib/libdbus-1.so.3.14.3)
==9974==    by 0x51805E3: dbus_connection_dispatch (in /usr/x86_64-pc-linux-gnu/lib/libdbus-1.so.3.14.3)
==9974==    by 0x4856DF: message_dispatch (mainloop.c:72)
==9974==    by 0x4E7C669: g_main_context_dispatch (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4600.1)
==9974==    by 0x4E7C9E7: g_main_context_iterate.isra.29 (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4600.1)
==9974==    by 0x4E7CD01: g_main_loop_run (in /usr/x86_64-pc-linux-gnu/lib/libglib-2.0.so.0.4600.1)
==9974==    by 0x40BABE: main (main.c:661)
==9974==  If you believe this happened as a result of a stack
==9974==  overflow in your program's main thread (unlikely but
==9974==  possible), you can try to increase the size of the
==9974==  main thread stack using the --main-stacksize= flag.
==9974==  The main thread stack size used in this run was 8388608.
==9974==
---
 src/profile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index 70ee4c1..99c0587 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -742,10 +742,10 @@ static struct ext_profile *find_ext_profile(const char *owner,
 	for (l = ext_profiles; l != NULL; l = g_slist_next(l)) {
 		struct ext_profile *ext = l->data;
 
-		if (!g_str_equal(ext->owner, owner))
+		if (g_strcmp0(ext->owner, owner))
 			continue;
 
-		if (g_str_equal(ext->path, path))
+		if (!g_strcmp0(ext->path, path))
 			return ext;
 	}
 
-- 
2.6.1

