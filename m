Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 11/11] shared/hfp: Don't try read uninitialized data in ringbuffer
Date: Wed,  5 Mar 2014 20:22:56 +0100
Message-Id: <1394047376-11495-11-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't try to read uninitialized value if '\r' was not found.
This is call stack from test-hfp run with valgrind:

/hfp/test_fragmented_1: ==24869== Conditional jump or move depends on uninitialised value(s)
==24869==    at 0x400A5E4: memchr (in /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==24869==    by 0x804D24D: can_read_data (hfp.c:359)
==24869==    by 0x804A6E2: read_callback (io-glib.c:168)
==24869==    by 0x4108BFD5: ??? (in /usr/lib/libglib-2.0.so.0.3600.4)
==24869==    by 0x410470E5: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.3600.4)
==24869==    by 0x41047497: ??? (in /usr/lib/libglib-2.0.so.0.3600.4)
==24869==    by 0x41047912: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.3600.4)
==24869==    by 0x8049EE0: execute_context (test-hfp.c:186)
==24869==    by 0x4106CBC1: ??? (in /usr/lib/libglib-2.0.so.0.3600.4)
==24869==    by 0x4106CD5B: ??? (in /usr/lib/libglib-2.0.so.0.3600.4)
==24869==    by 0x4106D0E0: g_test_run_suite (in /usr/lib/libglib-2.0.so.0.3600.4)
==24869==    by 0x4106D13C: g_test_run (in /usr/lib/libglib-2.0.so.0.3600.4)
---
 src/shared/hfp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index 9523243..1be53fb 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -374,6 +374,12 @@ static void process_input(struct hfp_gw *hfp)
 		char *str2;
 		size_t len2;
 
+		/* If there is no more data in ringbuffer,
+		 * it's just an incomplete command.
+		 */
+		if (len == ringbuf_len(hfp->read_buf))
+			return;
+
 		str2 = ringbuf_peek(hfp->read_buf, len, &len2);
 		if (!str2)
 			return;
-- 
1.8.3.1

