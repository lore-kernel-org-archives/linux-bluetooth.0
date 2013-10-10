Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] avdtp: Remove unused avdtp_stream_setup_active function
Date: Thu, 10 Oct 2013 10:53:38 +0200
Message-ID: <1381395221-5067-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
References: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is not used anywhere and can be removed.
---
 profiles/audio/avdtp.c | 5 -----
 profiles/audio/avdtp.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 1f29050..e83245e 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3857,11 +3857,6 @@ gboolean avdtp_has_stream(struct avdtp *session, struct avdtp_stream *stream)
 	return g_slist_find(session->streams, stream) ? TRUE : FALSE;
 }
 
-gboolean avdtp_stream_setup_active(struct avdtp *session)
-{
-	return session->stream_setup;
-}
-
 void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc)
 {
 	session->device_disconnect = dev_dc;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index e19dfc3..3bf7503 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -307,7 +307,6 @@ int avdtp_error_posix_errno(struct avdtp_error *err);
 struct btd_adapter *avdtp_get_adapter(struct avdtp *session);
 struct btd_device *avdtp_get_device(struct avdtp *session);
 
-gboolean avdtp_stream_setup_active(struct avdtp *session);
 void avdtp_set_device_disconnect(struct avdtp *session, gboolean dev_dc);
 
 int avdtp_init(struct btd_adapter *adapter);
-- 
1.8.4

