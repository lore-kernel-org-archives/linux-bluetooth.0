Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 5/7] android/socket: Keep server iochannel reference
Date: Mon, 25 Nov 2013 13:22:55 +0200
Message-Id: <1385378577-20503-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385378577-20503-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385378577-20503-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

server io channel reference will be stored in rfsock structure
and might be deleted when Android end closes connection or when
HAL makes cleanup() call.
---
 android/socket.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 24503c5..93ace07 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -70,6 +70,8 @@ struct rfcomm_sock {
 	guint rfcomm_watch;
 	guint stack_watch;
 
+	GIOChannel *srv_io;
+
 	bdaddr_t dst;
 	uint32_t service_handle;
 
@@ -121,6 +123,11 @@ static void cleanup_rfsock(struct rfcomm_sock *rfsock)
 	if (rfsock->service_handle)
 		bt_adapter_remove_record(rfsock->service_handle);
 
+	if (rfsock->srv_io) {
+		g_io_channel_shutdown(rfsock->srv_io, TRUE, NULL);
+		g_io_channel_unref(rfsock->srv_io);
+	}
+
 	g_free(rfsock);
 }
 
@@ -696,9 +703,7 @@ static int handle_listen(void *buf)
 	rfsock->real_sock = g_io_channel_unix_get_fd(io);
 	servers = g_list_append(servers, rfsock);
 
-	/* TODO: Add server watch */
-	g_io_channel_set_close_on_unref(io, TRUE);
-	g_io_channel_unref(io);
+	rfsock->srv_io = io;
 
 	DBG("real_sock %d fd %d hal_fd %d", rfsock->real_sock, rfsock->fd,
 								hal_fd);
-- 
1.8.3.2

