Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 03/17] audio/IPC: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:50 -0400
Message-Id: <1321449604-4188-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.

This commit also changes places where errno can be replaced with -err
(for consistency) and one perror() usage error.
---
 audio/ipc.c    |   18 +++++++++---------
 test/ipctest.c |   12 ++++++++----
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/audio/ipc.c b/audio/ipc.c
index 669eeef..02d956b 100644
--- a/audio/ipc.c
+++ b/audio/ipc.c
@@ -56,19 +56,19 @@ int bt_audio_service_open(void)
 
 	sk = socket(PF_LOCAL, SOCK_STREAM, 0);
 	if (sk < 0) {
-		err = errno;
+		err = -errno;
 		fprintf(stderr, "%s: Cannot open socket: %s (%d)\n",
-			__FUNCTION__, strerror(err), err);
-		errno = err;
+			__FUNCTION__, strerror(-err), -err);
+		errno = -err;
 		return -1;
 	}
 
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = errno;
+		err = -errno;
 		fprintf(stderr, "%s: connect() failed: %s (%d)\n",
-			__FUNCTION__, strerror(err), err);
+			__FUNCTION__, strerror(-err), -err);
 		close(sk);
-		errno = err;
+		errno = -err;
 		return -1;
 	}
 
@@ -96,10 +96,10 @@ int bt_audio_service_get_data_fd(int sk)
 
 	ret = recvmsg(sk, &msgh, 0);
 	if (ret < 0) {
-		err = errno;
+		err = -errno;
 		fprintf(stderr, "%s: Unable to receive fd: %s (%d)\n",
-			__FUNCTION__, strerror(err), err);
-		errno = err;
+			__FUNCTION__, strerror(-err), -err);
+		errno = -err;
 		return -1;
 	}
 
diff --git a/test/ipctest.c b/test/ipctest.c
index 9fdfac4..4968443 100644
--- a/test/ipctest.c
+++ b/test/ipctest.c
@@ -139,7 +139,7 @@ static int service_send(struct userdata *u, const bt_audio_msg_header_t *msg)
 	else {
 		err = -errno;
 		ERR("Error sending data to audio service: %s(%d)",
-			strerror(errno), errno);
+			strerror(-err), -err);
 	}
 
 	return err;
@@ -171,7 +171,7 @@ static int service_recv(struct userdata *u, bt_audio_msg_header_t *rsp)
 	} else {
 		err = -errno;
 		ERR("Error receiving data from audio service: %s(%d)",
-			strerror(errno), errno);
+			strerror(-err), -err);
 	}
 
 	return err;
@@ -215,8 +215,12 @@ static int init_bt(struct userdata *u)
 
 	u->service_fd = bt_audio_service_open();
 	if (u->service_fd <= 0) {
-		perror(strerror(errno));
-		return errno;
+		int err = -errno;
+
+		ERR("bt_audio_service_open() failed: %s (%d)", strerror(-err),
+									-err);
+
+		return err;
 	}
 
 	return 0;
-- 
1.7.0.4

