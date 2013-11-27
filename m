Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] android/socket: Fix rfsock lists
Date: Wed, 27 Nov 2013 18:19:14 +0200
Message-Id: <1385569154-11579-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385569154-11579-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385569154-11579-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes several places where rfsock structure were not removed
from the list due to connection errors.
---
 android/socket.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index d55db54..3f07dc6 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -625,8 +625,6 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 		return;
 	}
 
-	connections = g_list_append(connections, rfsock_acc);
-
 	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
 		rfsock->fd, rfsock->real_sock, rfsock->channel,
 		sock_acc);
@@ -636,6 +634,8 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 		return;
 	}
 
+	connections = g_list_append(connections, rfsock_acc);
+
 	/* Handle events from Android */
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_stack = g_io_channel_unix_new(rfsock_acc->fd);
@@ -700,7 +700,6 @@ static int handle_listen(void *buf)
 	}
 
 	rfsock->real_sock = g_io_channel_unix_get_fd(io);
-	servers = g_list_append(servers, rfsock);
 
 	/* TODO: Add server watch */
 	g_io_channel_set_close_on_unref(io, TRUE);
@@ -717,6 +716,8 @@ static int handle_listen(void *buf)
 
 	rfsock->service_handle = sdp_service_register(profile, cmd->name);
 
+	servers = g_list_append(servers, rfsock);
+
 	return hal_fd;
 }
 
@@ -787,6 +788,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 
 	return;
 fail:
+	connections = g_list_remove(connections, rfsock);
 	cleanup_rfsock(rfsock);
 }
 
@@ -865,6 +867,7 @@ static void sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 
 	return;
 fail:
+	connections = g_list_remove(connections, rfsock);
 	cleanup_rfsock(rfsock);
 }
 
-- 
1.8.3.2

