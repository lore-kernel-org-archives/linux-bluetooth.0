Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] audio/avdtp: Remove start timer on stream_free()
Date: Thu, 26 Feb 2015 17:20:19 +0200
Message-Id: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Makes code identical to android/avdtp
---
 profiles/audio/avdtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 896f101..15b611f 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -717,6 +717,9 @@ static void stream_free(void *data)
 	if (stream->timer)
 		g_source_remove(stream->timer);
 
+	if (stream->start_timer > 0)
+		g_source_remove(stream->start_timer);
+
 	if (stream->io)
 		close_stream(stream);
 
-- 
2.1.0

