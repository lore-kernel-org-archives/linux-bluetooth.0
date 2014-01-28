Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] android/AVDTP: Make signalling channel priority 6
Date: Mon, 27 Jan 2014 22:16:57 -0800
Message-Id: <1390889820-24709-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes signalling priority 6 so it can push commands before the
stream channel, without this the stream channel may be schedule
first and cause the signalling commands to timeout while waiting a slot.
---
v2: Return error if writes fails since that probably means the socket has been
disconnected, also makes code setting socket to blocking a bit cleaner.

 android/avdtp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/avdtp.c b/android/avdtp.c
index 4abcd75..4cfffc8 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2057,6 +2057,7 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 	struct avdtp *session;
 	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 	int new_fd;
+	int priority;
 
 	new_fd = dup(fd);
 	if (new_fd < 0) {
@@ -2064,6 +2065,14 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 		return NULL;
 	}
 
+	priority = 6;
+	if (setsockopt(new_fd, SOL_SOCKET, SO_PRIORITY,
+			(const void *) &priority, sizeof(priority)) < 0) {
+		error("setsockopt(SO_PRIORITY): %s (%d)", strerror(errno),
+									errno);
+		return NULL;
+	}
+
 	session = g_new0(struct avdtp, 1);
 	session->io = g_io_channel_unix_new(new_fd);
 	session->version = version;
-- 
1.8.4.2

