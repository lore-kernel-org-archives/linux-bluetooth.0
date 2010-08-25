Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 10:54:54 +0200
From: Colin Didier <didier@archos.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] An interrupted syscall is not an error when returning from
 poll() in audio/pcm_bluetooth.c
Message-ID: <20100825085454.GB27072@cybione.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

An interrupted syscall is not an error when returning from poll() at
line 240 of audio/pcm_bluetooth.c. So no need to freak out.

Here is a patch to fix this.

Cheers,
  Colin DIDIER

--- a/audio/pcm_bluetooth.c	2010-08-25 10:08:37.000000000 +0200
+++ b/audio/pcm_bluetooth.c	2010-08-25 10:08:59.000000000 +0200
@@ -237,9 +237,11 @@
 		ret = poll(fds, 2, poll_timeout);
 
 		if (ret < 0) {
-			SNDERR("poll error: %s (%d)", strerror(errno), errno);
-			if (errno != EINTR)
+			if (errno != EINTR) {
+				SNDERR("poll error: %s (%d)", strerror(errno),
+								errno);
 				break;
+			}
 		} else if (ret > 0) {
 			ret = (fds[0].revents) ? 0 : 1;
 			SNDERR("poll fd %d revents %d", ret, fds[ret].revents);
