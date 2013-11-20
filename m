Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 02/19] android/socket: Handling rfcomm sockets
Date: Wed, 20 Nov 2013 12:24:20 +0200
Message-Id: <1384943077-5366-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Implement functions creating and destroying rfcomm_socket structures.
---
 android/socket.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index d4c7674..e19b2aa 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -27,6 +27,7 @@
 
 #include <glib.h>
 #include <stdbool.h>
+#include <unistd.h>
 #include <errno.h>
 
 #include "lib/bluetooth.h"
@@ -43,6 +44,61 @@
 
 static bdaddr_t adapter_addr;
 
+/* Simple list of RFCOMM server sockets */
+GList *servers = NULL;
+
+/* Simple list of RFCOMM connected sockets */
+GList *connections = NULL;
+
+struct rfcomm_sock {
+	int fd;		/* descriptor for communication with Java framework */
+	int real_sock;	/* real RFCOMM socket */
+	int channel;	/* RFCOMM channel */
+
+	guint rfcomm_watch;
+	guint stack_watch;
+};
+
+static struct rfcomm_sock *create_rfsock(int sock, int *hal_fd)
+{
+	int fds[2] = {-1, -1};
+	struct rfcomm_sock *rfsock;
+
+	if (socketpair(AF_LOCAL, SOCK_STREAM, 0, fds) < 0) {
+		error("socketpair(): %s", strerror(errno));
+		*hal_fd = -1;
+		return NULL;
+	}
+
+	rfsock = g_new0(struct rfcomm_sock, 1);
+	rfsock->fd = fds[0];
+	*hal_fd = fds[1];
+	rfsock->real_sock = sock;
+
+	return rfsock;
+}
+
+static void cleanup_rfsock(struct rfcomm_sock *rfsock)
+{
+	DBG("rfsock: %p fd %d real_sock %d chan %u",
+		rfsock, rfsock->fd, rfsock->real_sock, rfsock->channel);
+
+	if (rfsock->fd > 0)
+		close(rfsock->fd);
+	if (rfsock->real_sock > 0)
+		close(rfsock->real_sock);
+
+	if (rfsock->rfcomm_watch > 0)
+		if (!g_source_remove(rfsock->rfcomm_watch))
+			error("rfcomm_watch source was not found");
+
+	if (rfsock->stack_watch > 0)
+		if (!g_source_remove(rfsock->stack_watch))
+			error("stack_watch source was not found");
+
+	g_free(rfsock);
+}
+
 static struct profile_info {
 	uint8_t		uuid[16];
 	uint8_t		channel;
@@ -81,6 +137,8 @@ static int handle_listen(void *buf)
 {
 	struct hal_cmd_sock_listen *cmd = buf;
 	struct profile_info *profile;
+	struct rfcomm_sock *rfsock;
+	int hal_fd;
 	int chan;
 
 	DBG("");
@@ -93,7 +151,11 @@ static int handle_listen(void *buf)
 
 	DBG("rfcomm channel %d", chan);
 
-	return -1;
+	rfsock = create_rfsock(-1, &hal_fd);
+	if (!rfsock)
+		return -1;
+
+	return hal_fd;
 }
 
 static int handle_connect(void *buf)
-- 
1.7.10.4

