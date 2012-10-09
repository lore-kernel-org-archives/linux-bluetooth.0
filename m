Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/5] audio: Fix audio driver is not probed
Date: Tue, 09 Oct 2012 20:35:47 +0900
Message-id: <1349782548-27923-4-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1349782548-27923-1-git-send-email-chanyeol.park@samsung.com>
References: <1349782548-27923-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This patch fix the bugs that when handling an AVDTP incoming connection,
audio-a2dp driver is not probed because advanced audio UUID is missed.
---
 audio/manager.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/audio/manager.c b/audio/manager.c
index 26cd9bf..b052009 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -1093,7 +1093,8 @@ static struct btd_profile gateway_profile = {
 static struct btd_profile a2dp_profile = {
 	.name		= "audio-a2dp",
 
-	.remote_uuids	= BTD_UUIDS(A2DP_SOURCE_UUID, A2DP_SINK_UUID),
+	.remote_uuids	= BTD_UUIDS(A2DP_SOURCE_UUID, A2DP_SINK_UUID,
+							ADVANCED_AUDIO_UUID),
 	.device_probe	= a2dp_probe,
 	.device_remove	= audio_remove,
 
-- 
1.7.9.5

