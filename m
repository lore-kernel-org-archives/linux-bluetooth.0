Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 6/6] android/hal-audio: Adjust audio quality automatically
Date: Thu, 17 Apr 2014 01:50:38 +0200
Message-Id: <1397692238-18642-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397692238-18642-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397692238-18642-1-git-send-email-andrzej.kaczmarek@tieto.com>
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
index e25aa07..f60d8cf 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -971,6 +971,8 @@ static bool resume_endpoint(struct audio_endpoint *ep)
 	ep->samples = 0;
 	ep->resync = false;
 
+	ep->codec->update_qos(ep->codec_data, QOS_POLICY_DEFAULT);
+
 	return true;
 }
 
@@ -1117,6 +1119,9 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 
 			if (diff > MAX_DELAY) {
 				warn("lag is %jums, resyncing", diff / 1000);
+
+				ep->codec->update_qos(ep->codec_data,
+							QOS_POLICY_DECREASE);
 				ep->resync = true;
 			}
 		}
-- 
1.9.2

