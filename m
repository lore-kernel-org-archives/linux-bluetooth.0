Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 15:07:49 +0200
From: Colin Didier <didier@archos.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] No error message on interrupted syscall
Message-ID: <20100825130749.GB7199@cybione.org>
References: <20100825085454.GB27072@cybione.org>
 <20100825112831.GB23943@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100825112831.GB23943@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

An interrupted syscall is not an error when returning from poll().
---
 audio/pcm_bluetooth.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index ff463fe..799f17f 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -237,9 +237,11 @@ iter_sleep:
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
-- 
1.7.1

