Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] android/socket: Do not close fd on unref
Date: Thu, 12 Dec 2013 17:17:51 +0200
Message-Id: <1386861474-29524-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

We close file descriptors in cleanup_rfsock() and leaving the default
value gives us glib warnings if we close fd already and got G_IO_NVAL in
server_cb from bt_io.
---
 android/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/socket.c b/android/socket.c
index 5e8f8e5..9d759be 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -736,6 +736,7 @@ static void handle_listen(const void *buf, uint16_t len)
 	rfsock->real_sock = g_io_channel_unix_get_fd(io);
 
 	g_io_channel_unref(io);
+	g_io_channel_set_close_on_unref(io, FALSE);
 
 	DBG("real_sock %d fd %d hal_fd %d", rfsock->real_sock, rfsock->fd,
 								hal_fd);
-- 
1.8.3.2

