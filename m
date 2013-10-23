Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] android/hal: Fix crash while receiving notification
Date: Wed, 23 Oct 2013 15:46:23 +0200
Message-ID: <1382535986-30684-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
References: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following crash:
Invalid read of size 8
   at 0x408B33: notification_handler (hal-ipc.c:122)
   by 0x4E39E99: start_thread (pthread_create.c:308)
 Address 0x8 is not stack'd, malloc'd or (recently) free'd
---
 android/hal-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index e8bba11..97a3d29 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -118,7 +118,7 @@ static void *notification_handler(void *data)
 		fd = -1;
 
 		/* Receive auxiliary data in msg */
-		for (cmsg = CMSG_FIRSTHDR(&msg); !cmsg;
+		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
 					cmsg = CMSG_NXTHDR(&msg, cmsg)) {
 			if (cmsg->cmsg_level == SOL_SOCKET
 					&& cmsg->cmsg_type == SCM_RIGHTS) {
-- 
1.8.4

