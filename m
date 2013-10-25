Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 01/15] android: Remove not needed local variable in connect_hal
Date: Fri, 25 Oct 2013 12:49:57 +0200
Message-ID: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

err variable was set but never read.
---
 android/main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/android/main.c b/android/main.c
index 50b5901..18dc9f7 100644
--- a/android/main.c
+++ b/android/main.c
@@ -239,12 +239,12 @@ static GIOChannel *connect_hal(GIOFunc connect_cb)
 	struct sockaddr_un addr;
 	GIOCondition cond;
 	GIOChannel *io;
-	int err, sk;
+	int sk;
 
 	sk = socket(PF_LOCAL, SOCK_SEQPACKET, 0);
 	if (sk < 0) {
-		err = errno;
-		error("Failed to create socket: %d (%s)", err, strerror(err));
+		error("Failed to create socket: %d (%s)", errno,
+							strerror(errno));
 		return NULL;
 	}
 
@@ -258,9 +258,7 @@ static GIOChannel *connect_hal(GIOFunc connect_cb)
 
 	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
 
-	err = connect(sk, (struct sockaddr *) &addr, sizeof(addr));
-	if (err < 0) {
-		err = -errno;
+	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		error("Failed to connect HAL socket: %d (%s)", errno,
 							strerror(errno));
 		g_io_channel_unref(io);
-- 
1.8.4.1

