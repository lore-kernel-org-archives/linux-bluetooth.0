Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH] audio: Fix style issue in start_timeout
Date: Mon,  2 Jul 2012 18:07:52 +0200
Message-Id: <1341245272-21737-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avdtp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index e431ce8..47a5d6d 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -3627,7 +3627,7 @@ static gboolean start_timeout(gpointer user_data)
 	struct avdtp_stream *stream = user_data;
 	struct avdtp *session = stream->session;
 
-	stream->open_acp = 0;
+	stream->open_acp = FALSE;
 
 	if (avdtp_start(session, stream) < 0)
 		error("wait_timeout: avdtp_start failed");
-- 
1.7.9.5

