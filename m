Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH] audio: make *_suspend() use bt_stop_stream_rsp
Date: Tue, 17 Feb 2009 12:49:37 +0200
Message-Id: <1234867777-24745-1-git-send-email-marcandre.lureau@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/unix.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/unix.c b/audio/unix.c
index 294155a..7fc4387 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -352,7 +352,7 @@ static void headset_suspend_complete(struct audio_device *dev, void *user_data)
 {
 	struct unix_client *client = user_data;
 	char buf[BT_SUGGESTED_BUFFER_SIZE];
-	struct bt_start_stream_rsp *rsp = (void *) buf;
+	struct bt_stop_stream_rsp *rsp = (void *) buf;
 
 	if (!dev)
 		goto failed;
@@ -613,7 +613,7 @@ static void a2dp_suspend_complete(struct avdtp *session,
 {
 	struct unix_client *client = user_data;
 	char buf[BT_SUGGESTED_BUFFER_SIZE];
-	struct bt_start_stream_rsp *rsp = (void *) buf;
+	struct bt_stop_stream_rsp *rsp = (void *) buf;
 	struct a2dp_data *a2dp = &client->d.a2dp;
 
 	if (err)
-- 
1.6.1.224.gb56c

