Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] profile: Fix crash when registering an invalid profile
Date: Fri, 22 Feb 2013 19:50:56 -0300
Message-Id: <1361573456-11528-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a uuid string is sent and it doesn't indentify a profile
(bt_name2string() returns NULL), bluetoothd crash later when trying
to access the external profile uuid field.

Valgrind log:

bluetoothd[3986]: src/profile.c:register_profile() sender :1.492
==3986== Invalid read of size 1
==3986==    at 0x4C2ACA4: strcasecmp (mc_replace_strmem.c:583)
==3986==    by 0x4656F0: register_profile (profile.c:1920)
==3986==    by 0x40CFF0: process_message.isra.4 (object.c:258)
==3986==    by 0x517C9E5: _dbus_object_tree_dispatch_and_unlock (in /usr/lib64/libdbus-1.so.3.7.2)
==3986==    by 0x5167349: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.2)
==3986==    by 0x40AB77: message_dispatch (mainloop.c:76)
==3986==    by 0x4E77BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==3986==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==3986==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==3986==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==3986==    by 0x40A3AE: main (main.c:583)
==3986==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==3986==
==3986==
==3986== Process terminating with default action of signal 11 (SIGSEGV)
==3986==  Access not within mapped region at address 0x0
==3986==    at 0x4C2ACA4: strcasecmp (mc_replace_strmem.c:583)
==3986==    by 0x4656F0: register_profile (profile.c:1920)
==3986==    by 0x40CFF0: process_message.isra.4 (object.c:258)
==3986==    by 0x517C9E5: _dbus_object_tree_dispatch_and_unlock (in /usr/lib64/libdbus-1.so.3.7.2)
==3986==    by 0x5167349: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.2)
==3986==    by 0x40AB77: message_dispatch (mainloop.c:76)
==3986==    by 0x4E77BCA: g_timeout_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==3986==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==3986==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==3986==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==3986==    by 0x40A3AE: main (main.c:583)
==3986==  If you believe this happened as a result of a stack
==3986==  overflow in your program's main thread (unlikely but
==3986==  possible), you can try to increase the size of the
==3986==  main thread stack using the --main-stacksize= flag.
==3986==  The main thread stack size used in this run was 8388608.
==3986==
---
 src/profile.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/profile.c b/src/profile.c
index 631a03f..3f5401f 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -2085,10 +2085,14 @@ static struct ext_profile *create_ext(const char *owner, const char *path,
 	struct ext_profile *ext;
 
 	ext = g_new0(struct ext_profile, 1);
+	ext->uuid = bt_name2string(uuid);
+	if (ext->uuid == NULL) {
+		g_free(ext);
+		return NULL;
+	}
 
 	ext->owner = g_strdup(owner);
 	ext->path = g_strdup(path);
-	ext->uuid = bt_name2string(uuid);
 
 	ext_set_defaults(ext);
 
-- 
1.8.1.3

