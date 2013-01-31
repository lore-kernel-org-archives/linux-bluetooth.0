Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] AVCTP: Fix memory leak
Date: Thu, 31 Jan 2013 11:12:41 -0600
Message-Id: <1359652363-25602-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359652363-25602-1-git-send-email-luiz.dentz@gmail.com>
References: <1359652363-25602-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

651 (280 direct, 371 indirect) bytes in 7 blocks are definitely lost in loss record 306 of 332
   at 0x4A06B2F: calloc (vg_replace_malloc.c:593)
   by 0x319724D706: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x418A54: avctp_send_browsing_req (avctp.c:1457)
   by 0x41A330: avrcp_handle_event (avrcp.c:1998)
   by 0x417810: session_cb (avctp.c:702)
   by 0x3197247A74: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3197247DA7: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x31972481A1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x409D6E: main (main.c:583)
---
 profiles/audio/avctp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 303427e..13dd4c3 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -749,6 +749,7 @@ static void browsing_response(struct avctp_channel *browsing,
 			return;
 
 		browsing->processed = g_slist_remove(browsing->processed, p);
+		pending_destroy(p, NULL);
 
 		return;
 	}
-- 
1.8.1

