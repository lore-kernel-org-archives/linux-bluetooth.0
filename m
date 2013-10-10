Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] avdtp: Remove unused avdtp_is_connected function
Date: Thu, 10 Oct 2013 10:53:37 +0200
Message-ID: <1381395221-5067-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
References: <1381395221-5067-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is not used anywhere and can be removed.
---
 profiles/audio/avdtp.c | 19 -------------------
 profiles/audio/avdtp.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index fc896c7..1f29050 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3164,25 +3164,6 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 	}
 }
 
-gboolean avdtp_is_connected(struct btd_device *device)
-{
-	struct avdtp_server *server;
-	struct avdtp *session;
-
-	server = find_server(servers, device_get_adapter(device));
-	if (!server)
-		return FALSE;
-
-	session = find_session(server->sessions, device);
-	if (!session)
-		return FALSE;
-
-	if (session->state != AVDTP_SESSION_STATE_DISCONNECTED)
-		return TRUE;
-
-	return FALSE;
-}
-
 struct avdtp_service_capability *avdtp_stream_get_codec(
 						struct avdtp_stream *stream)
 {
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index b8aaf1d..e19dfc3 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -218,8 +218,6 @@ struct avdtp *avdtp_get(struct btd_device *device);
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
-gboolean avdtp_is_connected(struct btd_device *device);
-
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 							void *data, int size);
 
-- 
1.8.4

