Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/AVDTP: Duplicate fd passed to avdtp_new
Date: Fri, 20 Dec 2013 11:56:27 +0200
Message-Id: <1387533387-6724-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This use dup to create a new fd to be used by AVDTP session leaving the
caller free to close the original fd. Note that even if the caller
decides to keep the original fd it will still be notified when
avdtp_shutdown is called since it uses shutdown.
---
 android/a2dp.c  | 1 -
 android/avdtp.c | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 9087c62..b7bb8d2 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -150,7 +150,6 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 		return;
 	}
 
-	g_io_channel_set_close_on_unref(chan, FALSE);
 	fd = g_io_channel_unix_get_fd(chan);
 
 	/* FIXME: Add proper version */
diff --git a/android/avdtp.c b/android/avdtp.c
index 353316c..ec78cc6 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2055,9 +2055,14 @@ struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 {
 	struct avdtp *session;
 	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	int new_fd;
+
+	new_fd = dup(fd);
+	if (new_fd < 0)
+		return NULL;
 
 	session = g_new0(struct avdtp, 1);
-	session->io = g_io_channel_unix_new(fd);
+	session->io = g_io_channel_unix_new(new_fd);
 	session->version = version;
 	session->imtu = imtu;
 	session->omtu = omtu;
-- 
1.8.3.1

