Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] Fix crash while registering player
Date: Thu,  6 Oct 2011 18:35:17 +0300
Message-Id: <1317915317-2257-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1317915317-2257-1-git-send-email-luiz.dentz@gmail.com>
References: <1317915317-2257-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Crash is caused by not removed freed player from the list:

Invalid read of size 8
   at 0x13E7B5: media_adapter_find_player (media.c:861)
   by 0x13FEBC: register_player (media.c:1561)
   by 0x120DFE: process_message (object.c:224)
   by 0x4F6E9A0: ??? (in /lib64/libdbus-1.so.3.5.6)
   by 0x4F6092F: dbus_connection_dispatch (in /lib64/libdbus-1.so.3.5.6)
   by 0x11F787: message_dispatch (mainloop.c:80)
   by 0x4C762CA: ??? (in /lib64/libglib-2.0.so.0.3000.0)
   by 0x4C74ADC: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.3000.0)
   by 0x4C752D7: ??? (in /lib64/libglib-2.0.so.0.3000.0)
   by 0x4C75824: g_main_loop_run (in /lib64/libglib-2.0.so.0.3000.0)
   by 0x11EE4B: main (main.c:485)
 Address 0x642ef30 is 16 bytes inside a block of size 80 free'd
   at 0x4A0662E: free (vg_replace_malloc.c:366)
   by 0x4C7B7F2: g_free (in /lib64/libglib-2.0.so.0.3000.0)
   by 0x12D292: player_destroy (avrcp.c:1099)
   by 0x120C38: service_filter (watch.c:477)
   by 0x120950: message_filter (watch.c:527)
   by 0x4F608E5: dbus_connection_dispatch (in /lib64/libdbus-1.so.3.5.6)
   by 0x11F787: message_dispatch (mainloop.c:80)
   by 0x4C762CA: ??? (in /lib64/libglib-2.0.so.0.3000.0)
   by 0x4C74ADC: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.3000.0)
   by 0x4C752D7: ??? (in /lib64/libglib-2.0.so.0.3000.0)
   by 0x4C75824: g_main_loop_run (in /lib64/libglib-2.0.so.0.3000.0)
   by 0x11EE4B: main (main.c:485)
---
 audio/media.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index a7866d2..32dab86 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -892,9 +892,12 @@ static void media_player_free(gpointer data)
 
 static void media_player_destroy(struct media_player *mp)
 {
+	struct media_adapter *adapter = mp->adapter;
+
 	DBG("sender=%s path=%s", mp->sender, mp->path);
 
 	if (mp->player) {
+		adapter->players = g_slist_remove(adapter->players, mp);
 		avrcp_unregister_player(mp->player);
 		return;
 	}
-- 
1.7.6.4

