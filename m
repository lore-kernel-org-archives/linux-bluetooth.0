Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 6/9] avdtp: Don't use audio_device src and dst fields in avdtp_confirm_cb
Date: Wed, 5 Dec 2012 11:10:21 +0100
Message-ID: <1354702224-15895-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
References: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is already src and dst available from bt_io.
---
 profiles/audio/avdtp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index deb8d26..9f7bea2 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2546,7 +2546,7 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	session->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) session_cb, session);
 
-	session->auth_id = btd_request_authorization(&dev->src, &dev->dst,
+	session->auth_id = btd_request_authorization(&src, &dst,
 							ADVANCED_AUDIO_UUID,
 							auth_cb, session);
 	if (session->auth_id == 0) {
-- 
1.7.9.5

