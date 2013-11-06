Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 02/14] android: Use IPC command sanity checks
Date: Wed, 6 Nov 2013 15:09:18 +0100
Message-ID: <1383746970-25906-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make deamon checks received IPC commands for correctness.
---
 android/main.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/android/main.c b/android/main.c
index 75004cf..85ea270 100644
--- a/android/main.c
+++ b/android/main.c
@@ -236,13 +236,8 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
-	if (ret < (ssize_t) sizeof(*msg)) {
-		error("HAL command too small, terminating (%zd)", ret);
-		goto fail;
-	}
-
-	if (ret != (ssize_t) (sizeof(*msg) + msg->len)) {
-		error("Malformed HAL command (%zd bytes), terminating", ret);
+	if (!hal_cmd_check(msg, msg->payload, ret)) {
+		error("IPC protocol error, terminating");
 		goto fail;
 	}
 
-- 
1.8.4.2

