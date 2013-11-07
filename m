Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/ipc: Fix crash when sending file descriptor
Date: Thu,  7 Nov 2013 15:36:49 +0200
Message-Id: <1383831409-16900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since CMSG_FIRSTHDR is defined as shown below:

  ((size_t) (mhdr)->msg_controllen >= sizeof (struct cmsghdr) \
   ? (struct cmsghdr *) (mhdr)->msg_control : (struct cmsghdr *) 0)

it return NULL if msg_controllen is not defined. Accessing
that pointer result in daemon crash.
---
 android/ipc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index e672bf8..943c196 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -64,6 +64,9 @@ void ipc_send(GIOChannel *io, uint8_t service_id, uint8_t opcode, uint16_t len,
 	msg.msg_iovlen = 2;
 
 	if (fd >= 0) {
+		msg.msg_control = cmsgbuf;
+		msg.msg_controllen = sizeof(cmsgbuf);
+
 		cmsg = CMSG_FIRSTHDR(&msg);
 		cmsg->cmsg_level = SOL_SOCKET;
 		cmsg->cmsg_type = SCM_RIGHTS;
@@ -71,9 +74,6 @@ void ipc_send(GIOChannel *io, uint8_t service_id, uint8_t opcode, uint16_t len,
 
 		/* Initialize the payload */
 		memcpy(CMSG_DATA(cmsg), &fd, sizeof(int));
-
-		msg.msg_control = cmsgbuf;
-		msg.msg_controllen = sizeof(cmsgbuf);
 	}
 
 	if (sendmsg(g_io_channel_unix_get_fd(io), &msg, 0) < 0) {
-- 
1.7.10.4

