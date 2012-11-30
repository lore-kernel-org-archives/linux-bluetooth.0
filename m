Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 8/8] hog: Fix unregistering profile on exit
Date: Fri, 30 Nov 2012 12:25:03 +0100
Message-ID: <1354274703-15604-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354274703-15604-1-git-send-email-szymon.janc@tieto.com>
References: <1354274703-15604-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On exit should call btd_profile_unregister instead of
btd_profile_register. Fixes following:

16 bytes in 1 blocks are still reachable in loss record 54 of 215
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E93FC2: g_slist_append (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x17F6C2: btd_profile_register (profile.c:533)
   by 0x171456: plugin_cleanup (plugin.c:242)
   by 0x12164F: main (main.c:563)

16 bytes in 1 blocks are still reachable in loss record 37 of 215
   at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E7FA78: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E92CA2: g_slice_alloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x4E93FC2: g_slist_append (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.3)
   by 0x17F6C2: btd_profile_register (profile.c:533)
   by 0x1712EB: plugin_init (plugin.c:217)
   by 0x1215D2: main (main.c:544)
---
 profiles/input/hog_manager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index 21ceb79..595b160 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -144,7 +144,7 @@ static void hog_manager_exit(void)
 	if (suspend_supported)
 		suspend_exit();
 
-	btd_profile_register(&hog_profile);
+	btd_profile_unregister(&hog_profile);
 }
 
 static int hog_init(void)
-- 
1.7.9.5

