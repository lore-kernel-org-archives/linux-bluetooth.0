Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Cleanup error handling
Date: Fri, 25 Oct 2013 11:43:26 +0300
Message-Id: <1382690606-20721-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove unneeded assignment err=errno and instead use errno directly.
---
 android/hal-ipc.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 6566ebb..20421db 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -150,9 +150,8 @@ static int accept_connection(int sk)
 
 	err = poll(&pfd, 1, CONNECT_TIMEOUT);
 	if (err < 0) {
-		err = errno;
-		error("Failed to poll: %d (%s)", err, strerror(err));
-		return -1;
+		error("Failed to poll: %d (%s)", errno, strerror(errno));
+		return err;
 	}
 
 	if (err == 0) {
@@ -161,11 +160,9 @@ static int accept_connection(int sk)
 	}
 
 	new_sk = accept(sk, NULL, NULL);
-	if (new_sk < 0) {
-		err = errno;
-		error("Failed to accept socket: %d (%s)", err, strerror(err));
-		return -1;
-	}
+	if (new_sk < 0)
+		error("Failed to accept socket: %d (%s)", errno,
+							strerror(errno));
 
 	return new_sk;
 }
@@ -178,9 +175,8 @@ bool hal_ipc_init(void)
 
 	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
 	if (sk < 0) {
-		err = errno;
-		error("Failed to create socket: %d (%s)", err,
-							strerror(err));
+		error("Failed to create socket: %d (%s)", errno,
+							strerror(errno));
 		return false;
 	}
 
@@ -190,16 +186,14 @@ bool hal_ipc_init(void)
 	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = errno;
-		error("Failed to bind socket: %d (%s)", err, strerror(err));
+		error("Failed to bind socket: %d (%s)", errno, strerror(errno));
 		close(sk);
 		return false;
 	}
 
 	if (listen(sk, 2) < 0) {
-		err = errno;
-		error("Failed to listen on socket: %d (%s)", err,
-								strerror(err));
+		error("Failed to listen on socket: %d (%s)", errno,
+							strerror(errno));
 		close(sk);
 		return false;
 	}
-- 
1.7.10.4

