Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] android/hal-audio: Fix not closing audio_sk
Date: Mon, 20 Jan 2014 14:25:26 +0200
Message-Id: <1390220727-21494-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

shutdown will only disconnect the peers but it is still needed to close
the file descriptor.
---
 android/hal-audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 2f6f8c2..0b4577e 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -246,6 +246,7 @@ static void audio_ipc_cleanup(void)
 {
 	if (audio_sk >= 0) {
 		shutdown(audio_sk, SHUT_RDWR);
+		close(audio_sk);
 		audio_sk = -1;
 	}
 }
@@ -1090,6 +1091,7 @@ static void *ipc_handler(void *data)
 
 		if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
 			info("Audio HAL: Socket closed");
+			close(audio_sk);
 			audio_sk = -1;
 		}
 
-- 
1.8.4.2

