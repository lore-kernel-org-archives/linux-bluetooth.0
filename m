Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/6] android/hal-audio: Ignore write call when closing
Date: Thu, 6 Feb 2014 18:54:07 +0100
Message-ID: <1391709250-8047-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391709250-8047-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391709250-8047-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should not try to neither auto-resume nor write when state is set to
NONE as this is case when we're being closed and it's ok do ignore
write request.
---
 android/hal-audio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index efdf823..766327b 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -831,6 +831,10 @@ static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 {
 	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
 
+	/* just return in case we're closing */
+	if (out->audio_state == AUDIO_A2DP_STATE_NONE)
+		return -1;
+
 	/* We can auto-start only from standby */
 	if (out->audio_state == AUDIO_A2DP_STATE_STANDBY) {
 		DBG("stream in standby, auto-start");
-- 
1.8.5.3

