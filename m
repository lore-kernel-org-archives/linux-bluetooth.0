Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] AVRCP: Fix not freeing player session list on exit
Date: Mon,  1 Oct 2012 14:37:46 +0300
Message-Id: <1349091471-17396-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349091471-17396-1-git-send-email-luiz.dentz@gmail.com>
References: <1349091471-17396-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

16 bytes in 1 blocks are definitely lost in loss record 111 of 359
   at 0x4A0884D: malloc (vg_replace_malloc.c:263)
   by 0x4C8026E: g_malloc (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C94671: g_slice_alloc (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C959B2: g_slist_append (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x130FCC: avrcp_register_player (avrcp.c:1584)
   by 0x13FA1F: register_player (media.c:1689)
   by 0x123100: process_message.isra.0 (object.c:197)
   by 0x4F70684: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x4F6290C: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.5.6)
   by 0x121747: message_dispatch (mainloop.c:76)
   by 0x4C7B22A: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C7A694: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
---
 audio/avrcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 376f4a1..49f1550 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1472,6 +1472,7 @@ static void player_destroy(gpointer data)
 	if (player->destroy)
 		player->destroy(player->user_data);
 
+	g_slist_free(player->sessions);
 	g_free(player);
 }
 
-- 
1.7.11.4

