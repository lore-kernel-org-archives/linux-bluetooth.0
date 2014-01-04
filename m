Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 10/12] android/client: Use memcpy() for getting CMSG_DATA()
Date: Fri,  3 Jan 2014 21:55:26 -0400
Message-Id: <1388800528-10699-11-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1388800528-10699-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is how it is done in all other places in BlueZ. Also drop
unnecessary "descs" local variable.

Fixes clang error:

android/client/if-sock.c:164:11: error: cast from 'unsigned char *' to
'int *' increases required alignment from 1 to 4 [-Werror,-Wcast-align]
---
 android/client/if-sock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/client/if-sock.c b/android/client/if-sock.c
index 5394a5d..050bc96 100644
--- a/android/client/if-sock.c
+++ b/android/client/if-sock.c
@@ -154,21 +154,19 @@ static void read_accepted(int fd)
 
 	for (cmsgptr = CMSG_FIRSTHDR(&msg);
 		cmsgptr != NULL; cmsgptr = CMSG_NXTHDR(&msg, cmsgptr)) {
-		int *descs;
 		int count;
 
 		if (cmsgptr->cmsg_level != SOL_SOCKET ||
 			cmsgptr->cmsg_type != SCM_RIGHTS)
 			continue;
 
-		descs = (int *) CMSG_DATA(cmsgptr);
+		memcpy(&accepted_fd, CMSG_DATA(cmsgptr), sizeof(accepted_fd));
 		count = ((cmsgptr->cmsg_len - CMSG_LEN(0)) / sizeof(int));
 
 		if (count != 1)
 			haltest_error("Failed to accept descriptors count=%d\n",
 									count);
 
-		accepted_fd = descs[0];
 		break;
 	}
 
-- 
1.8.3.2

