Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/4] android/AVDTP: Make stream channel priority 5
Date: Tue, 28 Jan 2014 09:14:44 -0800
Message-Id: <1390929286-30206-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390929286-30206-1-git-send-email-luiz.dentz@gmail.com>
References: <1390929286-30206-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes channel priority 5 so it has higher priority than regular
traffic but less than signalling channel.
---
 android/avdtp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/avdtp.c b/android/avdtp.c
index e93ff70..1783555 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2832,10 +2832,19 @@ gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, int fd,
 						size_t imtu, size_t omtu)
 {
 	GIOChannel *io;
+	int priority;
 
 	if (stream != stream->session->pending_open)
 		return FALSE;
 
+	priority = 5;
+	if (setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &priority,
+						sizeof(priority)) < 0) {
+		error("setsockopt(SO_PRIORITY): %s (%d)", strerror(errno),
+									errno);
+		return FALSE;
+	}
+
 	io = g_io_channel_unix_new(fd);
 
 	handle_transport_connect(stream->session, io, imtu, omtu);
-- 
1.8.4.2

