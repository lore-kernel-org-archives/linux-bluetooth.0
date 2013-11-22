Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv7 14/14] android/socket: Refactor socket send_fd function
Date: Fri, 22 Nov 2013 10:34:55 +0200
Message-Id: <1385109295-11445-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385109295-11445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make code cleaner and initialize local cmsg buffer to zeroes.
---
 android/socket.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index dbd2012..daf4370 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -379,7 +379,7 @@ static int bt_sock_send_fd(int sock_fd, const void *buf, int len, int send_fd)
 	struct msghdr msg;
 	struct cmsghdr *cmsg;
 	struct iovec iv;
-	char msgbuf[CMSG_SPACE(1)];
+	char cmsgbuf[CMSG_SPACE(sizeof(int))];
 
 	DBG("len %d sock_fd %d send_fd %d", len, sock_fd, send_fd);
 
@@ -387,13 +387,16 @@ static int bt_sock_send_fd(int sock_fd, const void *buf, int len, int send_fd)
 		return -1;
 
 	memset(&msg, 0, sizeof(msg));
+	memset(cmsgbuf, 0, sizeof(cmsgbuf));
+
+	msg.msg_control = cmsgbuf;
+	msg.msg_controllen = sizeof(cmsgbuf);
 
-	msg.msg_control = msgbuf;
-	msg.msg_controllen = sizeof(msgbuf);
 	cmsg = CMSG_FIRSTHDR(&msg);
 	cmsg->cmsg_level = SOL_SOCKET;
 	cmsg->cmsg_type = SCM_RIGHTS;
 	cmsg->cmsg_len = CMSG_LEN(sizeof(send_fd));
+
 	memcpy(CMSG_DATA(cmsg), &send_fd, sizeof(send_fd));
 
 	iv.iov_base = (unsigned char *) buf;
-- 
1.8.3.2

