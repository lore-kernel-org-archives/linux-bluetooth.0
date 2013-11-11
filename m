Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 9/9] android/hal-sock: Write channel to Android fd
Date: Mon, 11 Nov 2013 14:37:18 +0200
Message-Id: <1384173438-21708-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 20f4e38..0188646 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -27,6 +27,7 @@
 
 #include <glib.h>
 #include <stdbool.h>
+#include <unistd.h>
 #include <errno.h>
 
 #include "lib/bluetooth.h"
@@ -292,6 +293,10 @@ static int handle_listen(void *buf)
 	rfslot->real_sock = g_io_channel_unix_get_fd(io);
 	rfcomm_srv_list = g_list_append(rfcomm_srv_list, rfslot);
 
+	/* TODO: Check this */
+	if (write(rfslot->fd, &ch, sizeof(ch)) < 0)
+		return -1;
+
 	DBG("real_sock %d fd %d hal_fd %d",
 				rfslot->real_sock, rfslot->fd, rfslot->hal_fd);
 
-- 
1.7.10.4

