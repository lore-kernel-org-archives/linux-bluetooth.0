Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv9 21/21] android/socket: Check create_rfsock returns valid structure
Date: Mon, 25 Nov 2013 15:08:57 +0200
Message-Id: <1385384937-29858-22-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/socket.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index 03b6d6d..fe16e49 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -647,6 +647,12 @@ static void accept_cb(GIOChannel *io, GError *err, gpointer user_data)
 
 	sock_acc = g_io_channel_unix_get_fd(io);
 	rfsock_acc = create_rfsock(sock_acc, &hal_fd);
+	if (!rfsock_acc) {
+		g_io_channel_shutdown(io, TRUE, NULL);
+		g_io_channel_unref(io);
+		return;
+	}
+
 	connections = g_list_append(connections, rfsock_acc);
 
 	DBG("rfsock: fd %d real_sock %d chan %u sock %d",
@@ -905,8 +911,11 @@ static int handle_connect(void *buf)
 
 	DBG("");
 
-	android2bdaddr(cmd->bdaddr, &dst);
 	rfsock = create_rfsock(-1, &hal_fd);
+	if (!rfsock)
+		return -1;
+
+	android2bdaddr(cmd->bdaddr, &dst);
 	bacpy(&rfsock->dst, &dst);
 
 	memset(&uuid, 0, sizeof(uuid));
-- 
1.8.3.2

