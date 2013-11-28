Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] android/socket: Avoid double close of file descriptor
Date: Thu, 28 Nov 2013 16:38:05 +0200
Message-Id: <1385649486-19978-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since we close all file descriptors in cleanup_rfsock do not close it also
during iochannel cleaning up. The flag was setup in bt_io_listen and
bt_io_connect calls.
---
 android/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 45ff90e..8df6e01 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -641,6 +641,7 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 	/* Handle rfcomm events */
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	id = g_io_add_watch(io, cond, sock_rfcomm_event_cb, rfsock_acc);
+	g_io_channel_set_close_on_unref(io, FALSE);
 
 	rfsock_acc->rfcomm_watch = id;
 
@@ -777,6 +778,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 	/* Handle rfcomm events */
 	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 	id = g_io_add_watch(io, cond, sock_rfcomm_event_cb, rfsock);
+	g_io_channel_set_close_on_unref(io, FALSE);
 
 	rfsock->rfcomm_watch = id;
 
-- 
1.8.3.2

