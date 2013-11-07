Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/ipc: Fix crash when sending file descriptor
Date: Thu,  7 Nov 2013 17:25:35 +0200
Message-Id: <1383837935-31110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <20131107151146.GE23283@x220.p-661hnu-f1>
References: <20131107151146.GE23283@x220.p-661hnu-f1>
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
index 9a8657d..729f157 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -62,6 +62,9 @@ void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 	msg.msg_iovlen = 2;
 
 	if (fd >= 0) {
+		msg.msg_control = cmsgbuf;
+		msg.msg_controllen = sizeof(cmsgbuf);
+
 		cmsg = CMSG_FIRSTHDR(&msg);
 		cmsg->cmsg_level = SOL_SOCKET;
 		cmsg->cmsg_type = SCM_RIGHTS;
@@ -69,9 +72,6 @@ void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 
 		/* Initialize the payload */
 		memcpy(CMSG_DATA(cmsg), &fd, sizeof(int));
-
-		msg.msg_control = cmsgbuf;
-		msg.msg_controllen = sizeof(cmsgbuf);
 	}
 
 	if (sendmsg(sk, &msg, 0) < 0) {
-- 
1.7.10.4

