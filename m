Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 12/23] android/hal-sco: Skip resampling for input of 8k
Date: Thu, 17 Jul 2014 11:54:12 +0300
Message-Id: <1405587263-19867-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index f316340..3d53737 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -979,7 +979,7 @@ static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
 	size_t frame_num = bytes / frame_size;
 	size_t input_frame_num = frame_num;
 	void *read_buf = buffer;
-	size_t total, read_frames;
+	size_t total = bytes;
 	int ret;
 
 	DBG("Read from fd %d bytes %zu", sco_fd, bytes);
@@ -1000,27 +1000,29 @@ static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
 		}
 
 		read_buf = in->resample_buf;
-	}
 
-	total = input_frame_num * sizeof(int16_t) * 1;
+		total = input_frame_num * sizeof(int16_t) * 1;
+	}
 
 	if(!read_data(in, read_buf, total))
 		return -1;
 
-	read_frames = input_frame_num;
-
-	ret = in->resampler->resample_from_input(in->resampler,
+	if (in->resampler) {
+		ret = in->resampler->resample_from_input(in->resampler,
 							in->resample_buf,
-							&read_frames,
+							&input_frame_num,
 							(int16_t *) buffer,
 							&frame_num);
-	if (ret) {
-		error("Failed to resample frames: %zd input %zd (%s)",
-				frame_num, input_frame_num, strerror(ret));
-		return -1;
-	}
+		if (ret) {
+			error("Failed to resample frames: %zd input %zd (%s)",
+					frame_num, input_frame_num,
+					strerror(ret));
+			return -1;
+		}
 
-        DBG("resampler: remain %zd output %zd frames", read_frames, frame_num);
+		DBG("resampler: remain %zd output %zd frames", input_frame_num,
+								frame_num);
+	}
 
 	return bytes;
 }
@@ -1081,6 +1083,9 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
 
 	in->cfg.frame_num = IN_STREAM_FRAMES;
 
+	if (in->cfg.rate == AUDIO_STREAM_SCO_RATE)
+		goto skip_resampler;
+
 	/* Channel numbers for resampler */
 	chan_num = 1;
 
@@ -1108,7 +1113,7 @@ static int sco_open_input_stream(struct audio_hw_device *dev,
 	DBG("Resampler: input %d output %d chan %d frames %u size %zd",
 				AUDIO_STREAM_SCO_RATE, in->cfg.rate, chan_num,
 				in->resample_frame_num, resample_size);
-
+skip_resampler:
 	*stream_in = &in->stream;
 	sco_dev->in = in;
 
-- 
1.9.1

