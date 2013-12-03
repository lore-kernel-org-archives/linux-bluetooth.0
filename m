Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/4] android/socket: Use heap instead of stack
Date: Tue,  3 Dec 2013 17:51:12 +0200
Message-Id: <1386085873-21715-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386085873-21715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386085873-21715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Keep buffer used in socket copy in heap instead of stack.
---
 android/socket.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index 9ff9019..6293b59 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -73,6 +73,8 @@ struct rfcomm_sock {
 	bdaddr_t dst;
 	uint32_t service_handle;
 
+	unsigned char *buf;
+
 	const struct profile_info *profile;
 };
 
@@ -92,6 +94,8 @@ static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
 	*hal_fd = fds[1];
 	rfsock->real_sock = sock;
 
+	rfsock->buf = g_malloc(SOCKET_BUFFER);
+
 	return rfsock;
 }
 
@@ -123,6 +127,8 @@ static void cleanup_rfsock(gpointer data)
 	if (rfsock->service_handle)
 		bt_adapter_remove_record(rfsock->service_handle);
 
+	g_free(rfsock->buf);
+
 	g_free(rfsock);
 }
 
@@ -489,7 +495,6 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
-	unsigned char buf[SOCKET_BUFFER];
 	int len, sent;
 
 	if (cond & G_IO_HUP) {
@@ -503,14 +508,14 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
-	len = read(rfsock->fd, buf, sizeof(buf));
+	len = read(rfsock->fd, rfsock->buf, SOCKET_BUFFER);
 	if (len <= 0) {
 		error("read(): %s", strerror(errno));
 		/* Read again */
 		return TRUE;
 	}
 
-	sent = try_write_all(rfsock->real_sock, buf, len);
+	sent = try_write_all(rfsock->real_sock, rfsock->buf, len);
 	if (sent < 0) {
 		error("write(): %s", strerror(errno));
 		goto fail;
@@ -528,7 +533,6 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 								gpointer data)
 {
 	struct rfcomm_sock *rfsock = data;
-	unsigned char buf[SOCKET_BUFFER];
 	int len, sent;
 
 	if (cond & G_IO_HUP) {
@@ -542,14 +546,14 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
-	len = read(rfsock->real_sock, buf, sizeof(buf));
+	len = read(rfsock->real_sock, rfsock->buf, SOCKET_BUFFER);
 	if (len <= 0) {
 		error("read(): %s", strerror(errno));
 		/* Read again */
 		return TRUE;
 	}
 
-	sent = try_write_all(rfsock->fd, buf, len);
+	sent = try_write_all(rfsock->fd, rfsock->buf, len);
 	if (sent < 0) {
 		error("write(): %s", strerror(errno));
 		goto fail;
-- 
1.8.3.2

