Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] shared: Fix not calling destroy callback while clearing up handlers
Date: Thu,  9 Jan 2014 16:26:00 +0100
Message-Id: <1389281160-17452-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

read/write_watch_destroy is be called after io_set_read/write_handler
exits. This was resulting in io destroy callback being NULLem before
destroy was called resulting in io destroy not being called at all.

Fix this by assigning destroy callback only if setting non-NULL
callback. destroy_watch will clean it when called.

Fix following valgrind report:

168 (120 direct, 48 indirect) bytes in 1 blocks are definitely lost in
       loss record 34 of 36
   at 0x4C2C494: calloc (in /usr/lib/valgrind/
       vgpreload_memcheck-amd64-linux.so)
   by 0x409BAE: mgmt_new (mgmt.c:372)
   by 0x409D05: mgmt_new_default (mgmt.c:469)
   by 0x40E100: test_pre_setup (android-tester.c:371)
   by 0x40AD84: start_tester (tester.c:586)
   by 0x4E7C3B5: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
   by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
       libglib-2.0.so.0.3800.1)
   by 0x40B76C: tester_run (tester.c:784)
   by 0x4034F4: main (android-tester.c:2127)
---
 src/shared/io-glib.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index 488b1a2..b7b3ff2 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -191,8 +191,10 @@ bool io_set_read_handler(struct io *io, io_callback_func_t callback,
 
 done:
 	io->read_callback = callback;
-	io->read_destroy = destroy;
-	io->read_data = user_data;
+	if (callback) {
+		io->read_destroy = destroy;
+		io->read_data = user_data;
+	}
 
 	return true;
 }
@@ -252,8 +254,10 @@ bool io_set_write_handler(struct io *io, io_callback_func_t callback,
 
 done:
 	io->write_callback = callback;
-	io->write_destroy = destroy;
-	io->write_data = user_data;
+	if (callback) {
+		io->write_destroy = destroy;
+		io->write_data = user_data;
+	}
 
 	return true;
 }
-- 
1.8.3.2

