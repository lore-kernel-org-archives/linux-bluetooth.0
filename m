Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 08/19] android/socket: Write channel to Android fd
Date: Tue, 19 Nov 2013 15:29:58 +0200
Message-Id: <1384867809-18135-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android framework expects to receive channel number as int.
---
 android/socket.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 936b70e..e4479e5 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -376,6 +376,13 @@ static int handle_listen(void *buf)
 	rfsock->real_sock = g_io_channel_unix_get_fd(io);
 	servers = g_list_append(servers, rfsock);
 
+	/* TODO: Check this */
+	if (write(rfsock->fd, &chan, sizeof(chan)) != sizeof(chan)) {
+		error("Error sending RFCOMM channel");
+		cleanup_rfsock(rfsock);
+		return -1;
+	}
+
 	DBG("real_sock %d fd %d hal_fd %d",
 				rfsock->real_sock, rfsock->fd, hal_fd);
 
-- 
1.7.10.4

