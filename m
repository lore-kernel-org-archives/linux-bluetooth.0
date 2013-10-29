Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/daemon: Solves warnings when compiling for Android
Date: Tue, 29 Oct 2013 15:29:54 +0200
Message-Id: <1383053394-22664-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When compiling for Android I get very annoying warnings shown below.
Though the issue is with android this really helps to clear Android
build screen.

external/bluetooth/bluez/android/main.c: In function 'cmd_watch_cb':
external/bluetooth/bluez/android/main.c:192:3: warning: format '%zd' expects
  argument of type 'signed size_t', but argument 2 has type 'ssize_t' [-Wformat]
external/bluetooth/bluez/android/main.c:197:3: warning: format '%zd' expects
  argument of type 'signed size_t', but argument 2 has type 'ssize_t' [-Wformat]
---
 Let me know if this solution is OK and I will change other parts as well.

 android/main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/main.c b/android/main.c
index 6ff30a9..63c9eda 100644
--- a/android/main.c
+++ b/android/main.c
@@ -171,7 +171,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 {
 	char buf[BLUEZ_HAL_MTU];
 	struct hal_hdr *msg = (void *) buf;
-	ssize_t ret;
+	int ret;
 	int fd;
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
@@ -189,12 +189,12 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 	}
 
 	if (ret < (ssize_t) sizeof(*msg)) {
-		error("HAL command too small, terminating (%zd)", ret);
+		error("HAL command too small, terminating (%d)", ret);
 		goto fail;
 	}
 
 	if (ret != (ssize_t) (sizeof(*msg) + msg->len)) {
-		error("Malformed HAL command (%zd bytes), terminating", ret);
+		error("Malformed HAL command (%d bytes), terminating", ret);
 		goto fail;
 	}
 
-- 
1.7.10.4

