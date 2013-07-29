Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] audio/AVRCP: Fix memory leaks
Date: Mon, 29 Jul 2013 17:04:33 +0300
Message-Id: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When the remote stack support both AVAILABLE_PLAYER_CHANGED and
ADDRESSED_PLAYER_CHANGED the player twice are inited twice leaking
the memory allocated in the first time:

16 bytes in 1 blocks are definitely lost in loss record 45 of 236
   at 0x4A06409: malloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x32F544D89E: g_malloc (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x32F5464BF7: g_memdup (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x4247CC: avrcp_get_media_player_list_rsp (avrcp.c:2432)
   by 0x41ECAB: session_browsing_cb (avctp.c:826)
   by 0x32F5447E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x32F5448157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x32F5448559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x40A28F: main (main.c:583)

16 bytes in 1 blocks are definitely lost in loss record 46 of 236
   at 0x4A082F7: realloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x32F544D946: g_realloc (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x32F5466D43: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x32F5467032: g_string_insert_len (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x32F5435287: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x421E62: avrcp_set_browsed_player_rsp (avrcp.c:2349)
   by 0x41ECAB: session_browsing_cb (avctp.c:826)
   by 0x32F5447E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x32F5448157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x32F5448559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x40A28F: main (main.c:583)
---
 profiles/audio/avrcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index a9373f3..1160f68 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2868,7 +2868,8 @@ avrcp_parse_media_player_item(struct avrcp *session, uint8_t *operands,
 		player = create_ct_player(session, id);
 		if (player == NULL)
 			return NULL;
-	}
+	} else if (player->features != NULL)
+		return player;
 
 	mp = player->user_data;
 
-- 
1.8.3.1

