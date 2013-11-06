Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 06/14] android/hal: Use IPC notifications sanity checks
Date: Wed, 6 Nov 2013 15:09:22 +0100
Message-ID: <1383746970-25906-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make HAL library checks received IPC notifications for correctness.
---
 android/hal-ipc.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 293be87..13392c2 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -105,21 +105,8 @@ static void *notification_handler(void *data)
 			exit(EXIT_FAILURE);
 		}
 
-		if (ret < (ssize_t) sizeof(*ev)) {
-			error("Too small notification (%zd bytes), aborting",
-									ret);
-			exit(EXIT_FAILURE);
-		}
-
-		if (ev->opcode < HAL_MINIMUM_EVENT) {
-			error("Invalid notification (0x%x), aborting",
-							ev->opcode);
-			exit(EXIT_FAILURE);
-		}
-
-		if (ret != (ssize_t) (sizeof(*ev) + ev->len)) {
-			error("Malformed notification(%zd bytes), aborting",
-									ret);
+		if (!hal_notif_check(ev, ev->payload, ret)) {
+			error("IPC protocol error in notification, aborting");
 			exit(EXIT_FAILURE);
 		}
 
-- 
1.8.4.2

