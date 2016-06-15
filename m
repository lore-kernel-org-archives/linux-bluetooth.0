Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] audio/avdtp: Fix memory leak
Date: Wed, 15 Jun 2016 15:26:38 +0300
Message-Id: <1465993598-30695-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1465993598-30695-1-git-send-email-luiz.dentz@gmail.com>
References: <1465993598-30695-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fixes not freeing the stream if endpoint response with an error
causing the followin trace:

146 (104 direct, 42 indirect) bytes in 1 blocks are definitely lost in loss record 209 of 244
   at 0x4C2A988: calloc (vg_replace_malloc.c:711)
   by 0x50CE580: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.4600.2)
   by 0x42600F: avdtp_setconf_cmd (avdtp.c:1474)
   by 0x42600F: avdtp_parse_cmd (avdtp.c:1966)
   by 0x42600F: session_cb (avdtp.c:2165)
   by 0x50C8E59: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4600.2)
   by 0x50C91EF: ??? (in /usr/lib64/libglib-2.0.so.0.4600.2)
   by 0x50C9511: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4600.2)
   by 0x40BFC8: main (main.c:687)
---
 profiles/audio/avdtp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 82de98b..4ec9cca 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1397,6 +1397,7 @@ static void setconf_cb(struct avdtp *session, struct avdtp_stream *stream,
 		avdtp_send(session, session->in.transaction,
 				AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATION,
 				&rej, sizeof(rej));
+		stream_free(stream);
 		return;
 	}
 
-- 
2.5.5

