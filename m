Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 1/5] android/hal-audio: Always call qos_update
Date: Mon, 2 Jun 2014 18:37:47 +0200
Message-ID: <1401727071-28731-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401727071-28731-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401727071-28731-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As it turned out, it's better to always call update_qos and just
provide dummy callback from codecs which do not support it.
---
 android/hal-audio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 8b82498..f15e767 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -544,8 +544,7 @@ static bool resume_endpoint(struct audio_endpoint *ep)
 	ep->samples = 0;
 	ep->resync = false;
 
-	if (ep->codec->update_qos)
-		ep->codec->update_qos(ep->codec_data, QOS_POLICY_DEFAULT);
+	ep->codec->update_qos(ep->codec_data, QOS_POLICY_DEFAULT);
 
 	return true;
 }
@@ -704,8 +703,7 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 			if (diff > MAX_DELAY) {
 				warn("lag is %jums, resyncing", diff / 1000);
 
-				if (ep->codec->update_qos)
-					ep->codec->update_qos(ep->codec_data,
+				ep->codec->update_qos(ep->codec_data,
 							QOS_POLICY_DECREASE);
 				ep->resync = true;
 			}
-- 
1.9.3

