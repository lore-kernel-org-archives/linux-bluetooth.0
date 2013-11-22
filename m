Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/6] android/socket: Add error printing possible close() failure
Date: Fri, 22 Nov 2013 17:49:33 +0200
Message-Id: <1385135376-21057-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385135376-21057-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385135376-21057-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/socket.c b/android/socket.c
index fcba1e8..07b205d 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -97,9 +97,14 @@ static void cleanup_rfsock(struct rfcomm_sock *rfsock)
 		rfsock, rfsock->fd, rfsock->real_sock, rfsock->channel);
 
 	if (rfsock->fd > 0)
-		close(rfsock->fd);
+		if (close(rfsock->fd) < 0)
+			error("close() fd %d failed: %s", rfsock->fd,
+							strerror(errno));
+
 	if (rfsock->real_sock > 0)
-		close(rfsock->real_sock);
+		if (close(rfsock->real_sock) < 0)
+			error("close() fd %d: failed: %s", rfsock->real_sock,
+							strerror(errno));
 
 	if (rfsock->rfcomm_watch > 0)
 		if (!g_source_remove(rfsock->rfcomm_watch))
-- 
1.8.3.2

