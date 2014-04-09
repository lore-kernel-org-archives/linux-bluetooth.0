Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/7] android/hal-audio: Add resume_endpoint helper
Date: Wed, 9 Apr 2014 16:16:54 +0200
Message-ID: <1397053018-4610-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 2f28b13..558331a 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -901,6 +901,17 @@ static void close_endpoint(struct audio_endpoint *ep)
 	ep->codec_data = NULL;
 }
 
+static bool resume_endpoint(struct audio_endpoint *ep)
+{
+	if (ipc_resume_stream_cmd(ep->id) != AUDIO_STATUS_SUCCESS)
+		return false;
+
+	clock_gettime(CLOCK_MONOTONIC, &ep->start);
+	ep->samples = 0;
+
+	return true;
+}
+
 static void downmix_to_mono(struct a2dp_stream_out *out, const uint8_t *buffer,
 								size_t bytes)
 {
@@ -1001,12 +1012,9 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 	if (out->audio_state == AUDIO_A2DP_STATE_STANDBY) {
 		DBG("stream in standby, auto-start");
 
-		if (ipc_resume_stream_cmd(out->ep->id) != AUDIO_STATUS_SUCCESS)
+		if (!resume_endpoint(out->ep))
 			return -1;
 
-		clock_gettime(CLOCK_MONOTONIC, &out->ep->start);
-		out->ep->samples = 0;
-
 		out->audio_state = AUDIO_A2DP_STATE_STARTED;
 	}
 
-- 
1.9.1

