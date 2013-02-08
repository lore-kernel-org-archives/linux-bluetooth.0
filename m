Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] A2DP: Fix invalid write
Date: Fri,  8 Feb 2013 16:12:08 +0200
Message-Id: <1360332728-27051-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Invalid write of size 8
   at 0x41F297: setconf_cfm (a2dp.c:567)
   by 0x42526B: session_cb (avdtp.c:3176)
   by 0x39B0847A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x39B0847D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x39B0848181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x409C3E: main (main.c:583)
 Address 0x555fda8 is 40 bytes inside a block of size 88 free'd
   at 0x4A077A6: free (vg_replace_malloc.c:446)
   by 0x39B084D79E: g_free (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x41E217: setup_cb_free (a2dp.c:191)
   by 0x41E410: finalize_config (a2dp.c:234)
   by 0x41F296: setconf_cfm (a2dp.c:566)
   by 0x42526B: session_cb (avdtp.c:3176)
   by 0x39B0847A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x39B0847D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x39B0848181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x409C3E: main (main.c:583)
---
 profiles/audio/a2dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 4b28465..f1646ee 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -562,9 +562,11 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	if (err) {
 		if (setup) {
+			setup_ref(setup);
 			setup->err = err;
 			finalize_config(setup);
 			setup->err = NULL;
+			setup_unref(setup);
 		}
 		return;
 	}
-- 
1.8.1

