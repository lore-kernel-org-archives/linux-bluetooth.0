Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 08/19] android/socket: Notify channel to Android framework
Date: Wed, 20 Nov 2013 12:24:26 +0200
Message-Id: <1384943077-5366-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android framework expects to receive channel number as int.
---
 android/socket.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 5901d45..90561dc 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -410,6 +410,12 @@ static int handle_listen(void *buf)
 	DBG("real_sock %d fd %d hal_fd %d", rfsock->real_sock, rfsock->fd,
 								hal_fd);
 
+	if (write(rfsock->fd, &chan, sizeof(chan)) != sizeof(chan)) {
+		error("Error sending RFCOMM channel");
+		cleanup_rfsock(rfsock);
+		return -1;
+	}
+
 	return hal_fd;
 }
 
-- 
1.7.10.4

