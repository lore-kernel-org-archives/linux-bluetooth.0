Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Move set_nonblocking function to audio/unix.c
Date: Thu,  4 Nov 2010 19:43:28 +0000
Message-Id: <1288899810-18722-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/unix.c      |   20 ++++++++++++++++++++
 src/glib-helper.c |   20 --------------------
 src/glib-helper.h |    2 --
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/audio/unix.c b/audio/unix.c
index ad822bd..62eee31 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -27,6 +27,7 @@
 #endif
 
 #include <stdio.h>
+#include <fcntl.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <stdlib.h>
@@ -115,6 +116,25 @@ static void client_free(struct unix_client *client)
 	g_free(client);
 }
 
+static int set_nonblocking(int fd)
+{
+	long arg;
+
+	arg = fcntl(fd, F_GETFL);
+	if (arg < 0)
+		return -errno;
+
+	/* Return if already nonblocking */
+	if (arg & O_NONBLOCK)
+		return 0;
+
+	arg |= O_NONBLOCK;
+	if (fcntl(fd, F_SETFL, arg) < 0)
+		return -errno;
+
+	return 0;
+}
+
 /* Pass file descriptor through local domain sockets (AF_LOCAL, formerly
  * AF_UNIX) and the sendmsg() system call with the cmsg_type field of a "struct
  * cmsghdr" set to SCM_RIGHTS and the data being an integer value equal to the
diff --git a/src/glib-helper.c b/src/glib-helper.c
index b3c5003..9d76626 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -27,7 +27,6 @@
 
 #include <stdlib.h>
 #include <errno.h>
-#include <fcntl.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -113,25 +112,6 @@ static void cache_sdp_session(bdaddr_t *src, bdaddr_t *dst,
 						cached);
 }
 
-int set_nonblocking(int fd)
-{
-	long arg;
-
-	arg = fcntl(fd, F_GETFL);
-	if (arg < 0)
-		return -errno;
-
-	/* Return if already nonblocking */
-	if (arg & O_NONBLOCK)
-		return 0;
-
-	arg |= O_NONBLOCK;
-	if (fcntl(fd, F_SETFL, arg) < 0)
-		return -errno;
-
-	return 0;
-}
-
 struct search_context {
 	bdaddr_t		src;
 	bdaddr_t		dst;
diff --git a/src/glib-helper.h b/src/glib-helper.h
index 8a334e9..e89c2c6 100644
--- a/src/glib-helper.h
+++ b/src/glib-helper.h
@@ -21,8 +21,6 @@
  *
  */
 
-int set_nonblocking(int fd);
-
 typedef void (*bt_callback_t) (sdp_list_t *recs, int err, gpointer user_data);
 typedef void (*bt_destroy_t) (gpointer user_data);
 
-- 
1.7.3.2

