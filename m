Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/4] android/socket: Cleanup sockets on unregister
Date: Tue,  3 Dec 2013 17:51:10 +0200
Message-Id: <1386085873-21715-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386085873-21715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386085873-21715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This cleans up rfsock structures closing all sockets and making general cleanup
for servers and for connections. This will be called form socket unregister.
---
 android/socket.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index c9eca44..9020874 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -93,8 +93,10 @@ static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
 	return rfsock;
 }
 
-static void cleanup_rfsock(struct rfcomm_sock *rfsock)
+static void cleanup_rfsock(gpointer data)
 {
+	struct rfcomm_sock *rfsock = data;
+
 	DBG("rfsock: %p fd %d real_sock %d chan %u",
 		rfsock, rfsock->fd, rfsock->real_sock, rfsock->channel);
 
@@ -936,5 +938,8 @@ void bt_socket_unregister(void)
 {
 	DBG("");
 
+	g_list_free_full(connections, cleanup_rfsock);
+	g_list_free_full(servers, cleanup_rfsock);
+
 	ipc_unregister(HAL_SERVICE_ID_SOCK);
 }
-- 
1.8.3.2

