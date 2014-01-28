Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/4] android/hal-audio: Set stream fd to blocking
Date: Tue, 28 Jan 2014 09:14:46 -0800
Message-Id: <1390929286-30206-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390929286-30206-1-git-send-email-luiz.dentz@gmail.com>
References: <1390929286-30206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the stream to block on io operation so it does not return
EAGAIN on syscall such as write.
---
 android/hal-audio.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 2ca6289..b1323b0 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -25,6 +25,7 @@
 #include <sys/un.h>
 #include <unistd.h>
 #include <arpa/inet.h>
+#include <fcntl.h>
 
 #include <hardware/audio.h>
 #include <hardware/hardware.h>
@@ -1108,6 +1109,24 @@ static int in_remove_audio_effect(const struct audio_stream *stream,
 	return -ENOSYS;
 }
 
+static int set_blocking(int fd)
+{
+	int flags;
+
+	flags = fcntl(fd, F_GETFL, 0);
+	if (flags < 0) {
+		error("fcntl(F_GETFL): %s (%d)", strerror(errno), errno);
+		return -errno;
+	}
+
+	if (fcntl(fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
+		error("fcntl(F_SETFL): %s (%d)", strerror(errno), errno);
+		return -errno;
+	}
+
+	return 0;
+}
+
 static int audio_open_output_stream(struct audio_hw_device *dev,
 					audio_io_handle_t handle,
 					audio_devices_t devices,
@@ -1156,8 +1175,10 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	if (!preset || fd < 0)
 		goto fail;
 
-	out->ep->fd = fd;
+	if (set_blocking(fd) < 0)
+		goto fail;
 
+	out->ep->fd = fd;
 	codec = out->ep->codec;
 
 	codec->init(preset, mtu, &out->ep->codec_data);
-- 
1.8.4.2

