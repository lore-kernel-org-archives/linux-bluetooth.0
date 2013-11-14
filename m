Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 10/16] android/hal-sock: Write channel to Android fd
Date: Thu, 14 Nov 2013 17:11:49 +0200
Message-Id: <1384441915-23966-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android framework expects to receive channel number as int.
---
 android/socket.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 7d1ada8..3e0c9f1 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -345,6 +345,13 @@ static int handle_listen(void *buf)
 	rfslot->real_sock = g_io_channel_unix_get_fd(io);
 	rfcomm_srv_list = g_list_append(rfcomm_srv_list, rfslot);
 
+	/* TODO: Check this */
+	if (write(rfslot->fd, &chan, sizeof(chan)) != sizeof(chan)) {
+		error("Error sending RFCOMM channel");
+		cleanup_rfslot(rfslot);
+		return -1;
+	}
+
 	DBG("real_sock %d fd %d hal_fd %d",
 				rfslot->real_sock, rfslot->fd, hal_fd);
 
-- 
1.7.10.4

