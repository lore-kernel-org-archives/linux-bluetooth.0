Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android/a2dp: Fix typo in condition
Date: Thu, 16 Jan 2014 16:38:20 +0100
Message-ID: <1389886700-21480-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 9b168ed..2288912 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1262,7 +1262,7 @@ static void bt_stream_open(const void *buf, uint16_t len)
 		return;
 	}
 
-	if (avdtp_stream_get_transport(setup->stream, &fd, NULL, NULL, NULL)) {
+	if (!avdtp_stream_get_transport(setup->stream, &fd, NULL, NULL, NULL)) {
 		error("avdtp_stream_get_transport: failed");
 		audio_ipc_send_rsp(AUDIO_OP_OPEN_STREAM, AUDIO_STATUS_FAILED);
 		return;
-- 
1.8.5.2

