Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 7/7] android/hal-audio: Adjust audio quality automatically
Date: Wed, 9 Apr 2014 16:16:58 +0200
Message-ID: <1397053018-4610-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case we go out of sync with audio clock and start skipping data to
catch up, we also decrease audio quality to have better change to avoid
going out of sync in future, i.e. due to poor radio link quality.

Quality is reset to default value on stream resume.
---
 android/hal-audio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 2db927c..aad9925 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -960,6 +960,8 @@ static bool resume_endpoint(struct audio_endpoint *ep)
 	ep->samples = 0;
 	ep->resync = false;
 
+	ep->codec->quality_ctrl(ep->codec_data, QUALITY_CTRL_DEFAULT);
+
 	return true;
 }
 
@@ -1106,6 +1108,9 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 
 			if (diff > MAX_DELAY) {
 				warn("lag is %jums, resyncing", diff / 1000);
+
+				ep->codec->quality_ctrl(ep->codec_data,
+							QUALITY_CTRL_DECREASE);
 				ep->resync = true;
 			}
 		}
-- 
1.9.1

