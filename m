Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] android/hal-audio: Set stream fd to blocking
Date: Mon, 27 Jan 2014 22:17:00 -0800
Message-Id: <1390889820-24709-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390889820-24709-1-git-send-email-luiz.dentz@gmail.com>
References: <1390889820-24709-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the stream to block on io operation so it does not return
EAGAIN on syscall such as write.
---
 android/hal-audio.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 2ca6289..21c1d94 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -25,6 +25,7 @@
 #include <sys/un.h>
 #include <unistd.h>
 #include <arpa/inet.h>
+#include <fcntl.h>
 
 #include <hardware/audio.h>
 #include <hardware/hardware.h>
@@ -1121,7 +1122,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	struct audio_preset *preset;
 	const struct audio_codec *codec;
 	uint16_t mtu;
-	int fd;
+	int fd, flags;
 
 	out = calloc(1, sizeof(struct a2dp_stream_out));
 	if (!out)
@@ -1156,8 +1157,18 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	if (!preset || fd < 0)
 		goto fail;
 
-	out->ep->fd = fd;
+	flags = fcntl(fd, F_GETFL, 0);
+	if (flags < 0) {
+		error("fcntl(F_GETFL): %s (%d)", strerror(errno), errno);
+		goto fail;
+	}
 
+	if (fcntl(fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
+		error("fcntl(F_SETFL): %s (%d)", strerror(errno), errno);
+		goto fail;
+	}
+
+	out->ep->fd = fd;
 	codec = out->ep->codec;
 
 	codec->init(preset, mtu, &out->ep->codec_data);
-- 
1.8.4.2

