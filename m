Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] android/hal-audio: Set stream fd to blocking
Date: Mon, 27 Jan 2014 15:41:50 -0800
Message-Id: <1390866110-16184-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390866110-16184-1-git-send-email-luiz.dentz@gmail.com>
References: <1390866110-16184-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the stream to block on io operation so it does not return
EAGAIN on syscall such as write.
---
 android/hal-audio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 8a0737b..103e174 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -25,6 +25,7 @@
 #include <sys/un.h>
 #include <unistd.h>
 #include <arpa/inet.h>
+#include <fcntl.h>
 
 #include <hardware/audio.h>
 #include <hardware/hardware.h>
@@ -1159,8 +1160,13 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	if (!preset || fd < 0)
 		goto fail;
 
-	out->ep->fd = fd;
+	if (fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK) < 0) {
+		error("fcntl(F_SETFL, ~O_NONBLOCK): %s (%d)", strerror(errno),
+									errno);
+		goto fail;
+	}
 
+	out->ep->fd = fd;
 	codec = out->ep->codec;
 
 	codec->init(preset, mtu, &out->ep->codec_data);
-- 
1.8.4.2

