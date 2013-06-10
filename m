Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/15] AVRCP: Fix crash while setting player volume
Date: Mon, 10 Jun 2013 13:37:05 +0300
Message-Id: <1370860630-30359-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Invalid read of size 8
   at 0x41A4EA: avrcp_handle_set_volume (avrcp.c:3619)
   by 0x418598: session_cb (avctp.c:790)
   by 0x3F31A47A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3F31A47D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3F31A48181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x40A335: main (main.c:595)
 Address 0x48 is not stack'd, malloc'd or (recently) free'd
---
 profiles/audio/avrcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 06bffca..f439ab3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3248,7 +3248,8 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn,
 
 	volume = pdu->params[0] & 0x7F;
 
-	player->cb->set_volume(volume, session->dev, player->user_data);
+	if (player != NULL)
+		player->cb->set_volume(volume, session->dev, player->user_data);
 
 	return FALSE;
 }
-- 
1.8.1.4

