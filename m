Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] audio/avdtp:-Fix-not-removing-start_timer-source
Date: Fri, 22 May 2015 19:28:01 +0900
Message-id: <1432290483-2910-5-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
References: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is possible that stream->start_timer can be set on stream_free which
should then should take care of remove it properly otherwise it can
trigger which would very likely cause a crash.

Thanks to Hannu Mallat <hannu.mallat@jolla.com> for reporting it.

This patch is made based on 24fc2b639e6fe567633a60dd4d99eca36a0f1323.
---
 profiles/audio/avdtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index ac89370..eed3f88 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -714,6 +714,9 @@ static void stream_free(void *data)
 	if (stream->timer)
 		g_source_remove(stream->timer);
 
+	if (stream->start_timer > 0)
+		g_source_remove(stream->start_timer);
+
 	if (stream->io)
 		close_stream(stream);
 
-- 
2.1.4

