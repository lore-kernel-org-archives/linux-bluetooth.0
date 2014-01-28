Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/4] android/hal-audio: Fix not handling EINTR errors
Date: Tue, 28 Jan 2014 09:14:45 -0800
Message-Id: <1390929286-30206-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390929286-30206-1-git-send-email-luiz.dentz@gmail.com>
References: <1390929286-30206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the kernel interrupts us while writting just try again.
---
 android/hal-audio.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 8d737ad..2ca6289 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -399,7 +399,7 @@ static void sbc_resume(void *codec_data)
 	sbc_data->frames_sent = 0;
 }
 
-static void write_media_packet(int fd, struct sbc_data *sbc_data,
+static int write_media_packet(int fd, struct sbc_data *sbc_data,
 				struct media_packet *mp, size_t data_len)
 {
 	struct timespec cur;
@@ -407,10 +407,13 @@ static void write_media_packet(int fd, struct sbc_data *sbc_data,
 	unsigned expected_frames;
 	int ret;
 
-	ret = write(fd, mp, sizeof(*mp) + data_len);
-	if (ret < 0) {
-		int err = errno;
-		error("SBC: failed to write data: %d (%s)", err, strerror(err));
+	while (true) {
+		ret = write(fd, mp, sizeof(*mp) + data_len);
+		if (ret >= 0)
+			break;
+
+		if (errno != EINTR)
+			return -errno;
 	}
 
 	sbc_data->frames_sent += mp->payload.frame_count;
@@ -432,6 +435,8 @@ static void write_media_packet(int fd, struct sbc_data *sbc_data,
 	if (sbc_data->frames_sent >= expected_frames)
 		usleep(sbc_data->frame_duration *
 				mp->payload.frame_count);
+
+	return ret;
 }
 
 static ssize_t sbc_write_data(void *codec_data, const void *buffer,
@@ -474,7 +479,9 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 		 */
 		if (mp->payload.frame_count == sbc_data->frames_per_packet ||
 				bytes == consumed) {
-			write_media_packet(fd, sbc_data, mp, encoded);
+			ret = write_media_packet(fd, sbc_data, mp, encoded);
+			if (ret < 0)
+				return ret;
 
 			encoded = 0;
 			free_space = sbc_data->out_buf_size - sizeof(*mp);
-- 
1.8.4.2

