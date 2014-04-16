Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 2/6] android/hal-audio: Add resume_endpoint helper
Date: Thu, 17 Apr 2014 01:50:34 +0200
Message-Id: <1397692238-18642-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397692238-18642-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397692238-18642-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 23eb6b8..992fdf7 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -910,6 +910,17 @@ static void close_endpoint(struct audio_endpoint *ep)
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
@@ -1010,12 +1021,9 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
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
1.9.2

