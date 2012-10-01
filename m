Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/10] AVRCP: Fix not removing session from player upon disconnect
Date: Mon,  1 Oct 2012 20:53:37 +0300
Message-Id: <1349114021-19067-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349114021-19067-1-git-send-email-luiz.dentz@gmail.com>
References: <1349114021-19067-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Invalid read of size 8
   at 0x1310E3: avrcp_unregister_player (avrcp.c:1604)
   by 0x13EB57: path_free (media.c:1834)
   by 0x123208: remove_interface.isra.1 (object.c:558)
   by 0x1238DD: g_dbus_unregister_interface (object.c:705)
   by 0x124BB8: media_server_remove (manager.c:1077)
   by 0x4E91C5C: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x17B349: adapter_remove (adapter.c:2309)
   by 0x176F39: manager_cleanup (manager.c:290)
   by 0x120E65: main (main.c:555)
 Address 0x6685058 is 24 bytes inside a block of size 80 free'd
   at 0x4C279AE: free (vg_replace_malloc.c:427)
   by 0x4E7C50E: g_free (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x12FC97: state_changed (avrcp.c:1380)
   by 0x12D351: avctp_set_state (avctp.c:396)
   by 0x12D7B4: session_cb (avctp.c:601)
   by 0x4E76824: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4E76B57: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4E76F51: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x120E51: main (main.c:551)
---
 audio/avrcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 49f1550..2e36fb7 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1328,6 +1328,11 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			avctp_unregister_browsing_pdu_handler(
 						session->browsing_handler);
 
+		if (session->player != NULL)
+			session->player->sessions = g_slist_remove(
+						session->player->sessions,
+						session);
+
 		g_free(session);
 		break;
 	case AVCTP_STATE_CONNECTING:
-- 
1.7.11.4

