Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] audio/avdtp: Add check for callback before run it
Date: Thu, 26 Feb 2015 17:20:20 +0200
Message-Id: <1424964022-8887-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424964022-8887-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avdtp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 15b611f..3c4e9b1 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1035,15 +1035,17 @@ static void finalize_discovery(struct avdtp *session, int err)
 	if (!discover)
 		return;
 
+	session->discover = NULL;
+
 	avdtp_error_init(&avdtp_err, AVDTP_ERRNO, err);
 
 	if (discover->id > 0)
 		g_source_remove(discover->id);
 
-	discover->cb(session, session->seps, err ? &avdtp_err : NULL,
+	if (discover->cb)
+		discover->cb(session, session->seps, err ? &avdtp_err : NULL,
 							discover->user_data);
 	g_free(discover);
-	session->discover = NULL;
 }
 
 static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
-- 
2.1.0

