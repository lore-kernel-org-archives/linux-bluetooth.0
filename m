Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] android/socket: Remove unneeded code
Date: Thu, 28 Nov 2013 16:38:06 +0200
Message-Id: <1385649486-19978-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The flag is already set in bt_io_listen.
---
 android/socket.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 8df6e01..ea88712 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -696,8 +696,6 @@ static int handle_listen(void *buf)
 
 	rfsock->real_sock = g_io_channel_unix_get_fd(io);
 
-	/* TODO: Add server watch */
-	g_io_channel_set_close_on_unref(io, TRUE);
 	g_io_channel_unref(io);
 
 	DBG("real_sock %d fd %d hal_fd %d", rfsock->real_sock, rfsock->fd,
-- 
1.8.3.2

