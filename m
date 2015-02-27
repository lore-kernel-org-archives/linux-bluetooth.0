Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 07/20] audio/avdtp: Remove start timer on stream_free()
Date: Fri, 27 Feb 2015 17:02:55 +0200
Message-Id: <1425049388-18333-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Makes code identical to android/avdtp
---
 profiles/audio/avdtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1bfbff7..83338b0 100644
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

