Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] audio/avdtp: Fix invalid reference counting
Date: Wed, 20 Aug 2014 11:06:52 -0300
Message-Id: <1408543612-5615-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the AVDTP session is terminated via any other mean than
'connection_lost()' (the only place that btd_device_unref() was called),
there was a dangling reference to the device.

This can be easily reproduced by suspending the host while using an A2DP
speaker. It has the very misleading effect of being unable to create the
device when the system resumes.
---
 profiles/audio/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 8a7d1c0..ba5f0e5 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1135,6 +1135,7 @@ static void avdtp_free(void *data)
 
 	g_free(session->buf);
 
+	btd_device_unref(session->device);
 	g_free(session);
 }
 
@@ -1160,7 +1161,6 @@ static void connection_lost(struct avdtp *session, int err)
 		return;
 
 	server->sessions = g_slist_remove(server->sessions, session);
-	btd_device_unref(session->device);
 	avdtp_free(session);
 }
 
-- 
2.0.4

