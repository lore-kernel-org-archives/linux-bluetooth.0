Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android/a2dp: Fix audio resume on started stream
Date: Thu, 23 Jan 2014 17:59:52 +0100
Message-ID: <1390496392-22826-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case stream is started from remote we'll receive Resume Stream IPC
when audio is already considered as started (i.e. on first write from
AudioFlinger). In such case we should not try to send AVDTP_START since
this will fail but just reply success over IPC instead.
---
 android/a2dp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 572e0d1..10e43b1 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1376,10 +1376,12 @@ static void bt_stream_resume(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	err = avdtp_start(setup->dev->session, setup->stream);
-	if (err < 0) {
-		error("avdtp_start: %s", strerror(-err));
-		goto failed;
+	if (setup->state != HAL_AUDIO_STARTED) {
+		err = avdtp_start(setup->dev->session, setup->stream);
+		if (err < 0) {
+			error("avdtp_start: %s", strerror(-err));
+			goto failed;
+		}
 	}
 
 	audio_ipc_send_rsp(AUDIO_OP_RESUME_STREAM, AUDIO_STATUS_SUCCESS);
-- 
1.8.5.2

