Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 06/26] android/hal-audio: Make update_qos optional
Date: Mon, 26 May 2014 15:16:32 +0200
Message-ID: <1401110212-11526-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 946a835..534620a 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -524,7 +524,8 @@ static bool resume_endpoint(struct audio_endpoint *ep)
 	ep->samples = 0;
 	ep->resync = false;
 
-	ep->codec->update_qos(ep->codec_data, QOS_POLICY_DEFAULT);
+	if (ep->codec->update_qos)
+		ep->codec->update_qos(ep->codec_data, QOS_POLICY_DEFAULT);
 
 	return true;
 }
@@ -683,7 +684,8 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 			if (diff > MAX_DELAY) {
 				warn("lag is %jums, resyncing", diff / 1000);
 
-				ep->codec->update_qos(ep->codec_data,
+				if (ep->codec->update_qos)
+					ep->codec->update_qos(ep->codec_data,
 							QOS_POLICY_DECREASE);
 				ep->resync = true;
 			}
-- 
1.9.3

