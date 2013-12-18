Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/AVDTP: Fix not removing start_timer source
Date: Wed, 18 Dec 2013 14:29:43 +0200
Message-Id: <1387369783-28164-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It is possible that stream->start_timer can be set on stream_free which
should then should take care of remove it properly otherwise it can
trigger which would very likely cause a crash.

Thanks to Hannu Mallat <hannu.mallat@jolla.com> for reporting it.
---
 android/avdtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/avdtp.c b/android/avdtp.c
index 5ae3afc..3a3380a 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -670,6 +670,9 @@ static void stream_free(void *data)
 	if (stream->timer)
 		g_source_remove(stream->timer);
 
+	if (stream->start_timer > 0)
+		g_source_remove(stream->start_timer);
+
 	if (stream->io)
 		close_stream(stream);
 
-- 
1.8.3.1

