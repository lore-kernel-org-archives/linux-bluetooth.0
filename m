Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/4] android/socket: Setup socket buffer sizes
Date: Tue,  3 Dec 2013 17:51:13 +0200
Message-Id: <1386085873-21715-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386085873-21715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386085873-21715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set socket buffer sizes for socketpair's end and real RFCOMM socket
equal to SOCKET_BUFFER.
---
 android/socket.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/socket.c b/android/socket.c
index 6293b59..3898767 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -82,6 +82,9 @@ static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
 {
 	int fds[2] = {-1, -1};
 	struct rfcomm_sock *rfsock;
+	socklen_t len = sizeof(int);
+	int size = SOCKET_BUFFER;
+	int i;
 
 	if (socketpair(AF_LOCAL, SOCK_STREAM, 0, fds) < 0) {
 		error("socketpair(): %s", strerror(errno));
@@ -94,6 +97,15 @@ static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
 	*hal_fd = fds[1];
 	rfsock->real_sock = sock;
 
+	for (i = 0; i < 2; i++) {
+		if (setsockopt(fds[i], SOL_SOCKET, SO_SNDBUF, &size, len) < 0)
+			warn("setsockopt() SO_SNDBUF fd: %d %s", fds[i],
+							strerror(errno));
+		if (setsockopt(fds[i], SOL_SOCKET, SO_RCVBUF, &size, len) < 0)
+			warn("setsockopt() SO_RCVBUF fd: %d %s", fds[i],
+							strerror(errno));
+	}
+
 	rfsock->buf = g_malloc(SOCKET_BUFFER);
 
 	return rfsock;
-- 
1.8.3.2

