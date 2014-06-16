Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/4] profiles/health/hdp: Fix memory leak in SDP record preparati Sdp record preparation part is copied to android/health.c from profiles/health/hdp_utils.c. Memory leak is noticed while testing. Memory summay is from android daemon, but code snippet is same. It is already fixed in android/health.c while submitting android related patches.
Date: Mon, 16 Jun 2014 20:51:11 +0300
Message-Id: <1402941074-14407-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402941074-14407-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402941074-14407-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

==12515== 286 (16 direct, 270 indirect) bytes in 1 blocks are definitely lost in loss record 158 of 165
==12515==    at 0x4C2AB80: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==12515==    by 0x44AC45: sdp_list_append (sdp.c:1743)
==12515==    by 0x4398F9: register_features (health.c:381)
==12515==    by 0x4091CC: queue_foreach (queue.c:219)
==12515==    by 0x43A31F: bt_health_mdep_cfg_data (health.c:398)
==12515==    by 0x418B50: cmd_watch_cb (ipc.c:144)
==12515==    by 0x4E7FCE4: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==12515==    by 0x4E80047: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==12515==    by 0x4E80309: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==12515==    by 0x4044F2: main (main.c:538)
---
 profiles/health/hdp_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 58770b5..47c464e 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -652,6 +652,8 @@ static gboolean register_service_sup_features(GSList *app_list,
 		return FALSE;
 	}
 
+	sdp_list_free(sup_features, free_hdp_list);
+
 	return TRUE;
 }
 
-- 
1.9.1

