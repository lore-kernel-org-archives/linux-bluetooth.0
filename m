Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 11/11] android/hal-audio: Implement set_parameters for device
Date: Wed, 15 Jan 2014 19:03:57 +0100
Message-ID: <1389809037-11575-12-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 58f48bb..a435aec 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -943,8 +943,16 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
 static int audio_set_parameters(struct audio_hw_device *dev,
 							const char *kvpairs)
 {
+	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
+	struct a2dp_stream_out *out = a2dp_dev->out;
+
 	DBG("");
-	return -ENOSYS;
+
+	if (!out)
+		return 0;
+
+	return out->stream.common.set_parameters((struct audio_stream *) out,
+							kvpairs);
 }
 
 static char *audio_get_parameters(const struct audio_hw_device *dev,
-- 
1.8.5.2

