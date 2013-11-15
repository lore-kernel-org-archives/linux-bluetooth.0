Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 09/16] android/hal-sock: Write channel to Android fd
Date: Fri, 15 Nov 2013 16:37:51 +0200
Message-Id: <1384526278-26260-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384526278-26260-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384526278-26260-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android framework expects to receive channel number as int.
---
 android/socket.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 2bc4f06..a3915c3 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -355,6 +355,13 @@ static int handle_listen(void *buf)
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

